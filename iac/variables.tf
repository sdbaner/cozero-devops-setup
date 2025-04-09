variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "vpc" {
  description = "VPC name"
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "List of availability zones"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDRs"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of public subnet CIDRs"
  type        = list(string)
}

variable "environment" {
  description = "Environment tag (e.g. dev, qa, prod)"
  type        = string
}

variable "project" {
  description = "Project name"
  type        = string
}

