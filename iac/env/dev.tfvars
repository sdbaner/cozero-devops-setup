aws_region         = "eu-central-1"
vpc                = "cozero-vpc"
vpc_cidr           = "10.0.0.0/16"
availability_zones = ["eu-central-1a", "eu-central-1b"]
private_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
public_subnets     = ["10.0.101.0/24", "10.0.102.0/24"]
environment        = "dev"
project            = "cozero"
