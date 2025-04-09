output "ecr_repository_name" {
  description = "Name of the ECR repository"
  value       = aws_ecr_repository.ecr_repo.name
}

output "ecr_repository_url" {
  description = "URL of the ECR repository"
  value       = aws_ecr_repository.ecr_repo.repository_url
}

