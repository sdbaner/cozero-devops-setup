# Referencing vpc statefile to fetch subnet details
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "cozero-terraform-state-bucket"
    key            = "shared/vpc/terraform.tfstate"
    region         = "eu-central-1"
    use_lockfile   = true  # Instead of deprecated `dynamodb_table`
  }
}


# Security Group for ECS Tasks
resource "aws_security_group" "ecs_tasks" {
  name        = "${var.project}-ecs-tasks-sg"
  description = "Allow inbound traffic for ECS tasks"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    description = "Allow HTTP inbound"
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${var.project}-ecs-tasks-sg"
    Environment = var.environment
  }
}


# ECS Cluster
resource "aws_ecs_cluster" "main" {
  name = "${var.project}-cluster"

  tags = {
    Name        = "${var.project}-ecs-cluster"
    Environment = var.environment
  }
}


# ECS Task Execution Role
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "${var.project}-ecs-task-execution-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })
}

# Host execution Role
data "aws_iam_policy_document" "host_execution_policy" {
  statement {
    effect = "Allow"
    actions = [
      "ecr:GetAuthorizationToken",
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "logs:CreateLogStream",
      "logs:PutLogEvents"
    ]
    resources = ["*"]
  }
}

resource "aws_iam_policy" "host_execution_policy" {
  policy = data.aws_iam_policy_document.host_execution_policy.json
  name   = "fargate-ecr-link"
}


# Attach the AWS managed policy for ECS task/host execution
resource "aws_iam_role_policy_attachment" "host_execution_role_attachment" {
  policy_arn = aws_iam_policy.host_execution_policy.arn  
  role       = aws_iam_role.ecs_task_execution_role.name
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_policy" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}


# ECS Task Definition
resource "aws_ecs_task_definition" "app" {
  family                   = "${var.project}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                     = 256
  memory                  = 512
  execution_role_arn      = aws_iam_role.ecs_task_execution_role.arn

  container_definitions = jsonencode([
    {
      name  = "${var.project}-container"
      image = var.image_uri
      portMappings = [
        {
          containerPort = 5000
          hostPort      = 5000
          protocol      = "tcp"
        }
      ]
      logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = "/ecs/${var.project}"
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
      }
    }
  ])
  tags = {
    Name        = "${var.project}-task-definition"
    Environment = var.environment
  }
}


# ECS Service
resource "aws_ecs_service" "app" {
  name            = "${var.project}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  force_new_deployment = true

  network_configuration {
    subnets          = data.terraform_remote_state.vpc.outputs.private_subnets
    security_groups  = [aws_security_group.ecs_tasks.id]  
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "app"
    container_port   = 5000
  }

  depends_on = [
    aws_lb.app,
    aws_lb_listener.app,
    aws_lb_target_group.app,
    aws_ecs_task_definition.app
  ]

  tags = {
    Name        = "${var.project}-ecs-service"
    Environment = var.environment
  }
}
