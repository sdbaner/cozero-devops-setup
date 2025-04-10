terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket         = "cozero-terraform-state-bucket"
    key            = "shared/vpc/terraform.tfstate"
    dynamodb_table = "terraform-lock-table"
    region         = "eu-central-1"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}
