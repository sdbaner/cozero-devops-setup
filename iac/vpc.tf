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
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"    
  }
  public_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/cluster/${local.cluster_name}" = "shared"
    "kubernetes.io/role/elb"                      = "1"
  }

}


