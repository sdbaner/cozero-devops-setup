terraform {
  backend "s3" {
    bucket = "cozero-terraform-state-bucket"
    key    = "shared/ecr/terraform.tfstate"
    dynamodb_table = "terraform-lock-table"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB

  }
}
