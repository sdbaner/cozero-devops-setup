resource "aws_ecr_lifecycle_policy" "ecr_policy" {
  repository = aws_ecr_repository.ecr_repo.name

  policy = jsonencode({
    rules = [
      {
        rule_priority = 1
        description   = "Keep only 3 images"
        selection     = {
          count_type        = "imageCountMoreThan"
          count_number      = 3
          tag_status        = "tagged"
          tag_prefix_list   = ["v"]
        }
        action = {
          type = "expire"
        }
      }
    ]
  })
}
