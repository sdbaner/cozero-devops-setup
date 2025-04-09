module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"
  name = var.vpc
  cidr = var.vpc_cidr

  azs             = var.availability_zones
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  #enable_nat_gateway  = true
  #single_nat_gateway  = true 
  #enable_vpn_gateway = true

  tags = {
    Terraform                                     = "true"
    Environment                                   = var.environment
    Project                                       = var.project
  }
  public_subnet_tags = {
    resource = "shared"
  }
  private_subnet_tags = {
    resource = "shared"
  }

}


