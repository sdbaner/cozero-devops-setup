# VPC ID
output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

# VPC CIDR blocks
output "vpc_cidr_block" {
  description = "The CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

# VPC Private Subnets
output "private_subnets" {
  description = "A list of private subnets inside the VPC"
  value       = module.vpc.private_subnets
}

# VPC Public Subnets
output "public_subnets" {
  description = "A list of public subnets inside the VPC"
  value       = module.vpc.public_subnets
}

# VPC NAT gateway Public IP
output "nat_public_ips" {
  description = "List of public Elastic IPs created for AWS NAT Gateway"
  value       = module.vpc.nat_public_ips
}

# VPC NAT gateway Public IP
output "nat_gateway_ids" {
  description = "List of NAT Gateway IDs"
  value       = module.vpc.natgw_ids
}

# VPC AZs
output "availability_zones" {
  description = "A list of availability zones specified as argument to this module"
  value       = module.vpc.azs
}

# VPC Name
output "vpc_name" {
  description = "Name of the VPC"
  value       = var.vpc
}









