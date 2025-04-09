terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-cozero"
    key    = "shared/vpc/terraform.tfstate"
    dynamodb_table = "terraform-lock"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB
  }
}
