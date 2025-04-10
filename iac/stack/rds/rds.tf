# Referencing vpc statefile to fetch subnet details
data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "cozero-terraform-state-bucket"
    key            = "shared/vpc/terraform.tfstate"
    region         = "eu-central-1"
    use_lockfile   = true  # Instead of deprecated `dynamodb_table`
    #dynamodb_table = "terraform-lock-table"
  }
}

# Create subnet group for RDS
resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.dbname}-subnet-group"
  subnet_ids = data.terraform_remote_state.vpc.outputs.private_subnets

  tags = {
    Name = "${var.dbname}-subnet-group"
  }
}

# Add security group to block external access to RDS and allow traffic within the VPC cidr
resource "aws_security_group" "rds_sg" {
  name        = "${var.dbname}-rds-sg"
  description = "Allow traffic to RDS only from within the VPC"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = [data.terraform_remote_state.vpc.outputs.vpc_cidr_block]
    description = "Allow PostgreSQL access only from within the VPC"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # Allow all outbound traffic (default)
  }

  tags = {
    Name = "${var.dbname}-rds-sg"
  }
}

# Postgres parameters
resource "aws_db_parameter_group" "postgresql" {
  name   = "params"
  family = "postgres17"

  parameter {
    name  = "log_connections"
    value = "1"
  }
}

# Create the RDS
resource "aws_db_instance" "postgresql" {
  allocated_storage                   = 20
  engine                              = "postgres"
  engine_version                      = "17.2"
  instance_class                      = "db.t4g.micro"
  identifier                          = var.dbname
  username                            = var.dbuser
  password                            = var.dbpassword
  db_subnet_group_name                = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids              = [aws_security_group.rds_sg.id]
  storage_encrypted                   = true
  parameter_group_name                = aws_db_parameter_group.postgresql.name
  multi_az                            = false # to save cost
  apply_immediately                   = true
  final_snapshot_identifier           = "rds-pg-cluster-backup"
  skip_final_snapshot                 = true

}



