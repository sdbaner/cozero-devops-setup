variable "ecr_name" {
  description = "ECR private repository"
  type        = string
}

variable "environment" {
  description = "Environment tag (e.g. dev, qa, prod)"
  type        = string
}
