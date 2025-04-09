terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-cozero"
    key    = "shared/ecr/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB

  }
}
