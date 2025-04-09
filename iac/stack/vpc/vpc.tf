# Create VPC using Terraform AWS Module

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"
  name = var.vpc
  cidr = var.vpc_cidr

  azs = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  # NAT Gateways - Outbound Communication
  enable_nat_gateway = var.enable_nat_gateway
  single_nat_gateway = var.single_nat_gateway

  #enable_vpn_gateway = true

  # DNS Parameters in VPC
  enable_dns_hostnames = true
  enable_dns_support   = true

  # Additional tags for the VPC
  tags = {
    Terraform                       = "true"
    Environment                     = var.environment
    Project                         = var.project
    Resource                        = "global"
  }
  public_subnet_tags = {
    Resource = "global"
  }
  private_subnet_tags = {
    Resource = "global"
  }

}


