variable "aws_region" {
  description = "AWS region"
  type        = string
}

variable "project" {
  description = "Project name to be used for tagging"
  type        = string
}

variable "environment" {
  description = "Environment (dev/staging/prod)"
  type        = string
}

variable "image_uri" {
  description = "image uri "
  type        = string
}
