terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-cozero"
    key    = "terraform-ecr.tfstate"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB
    # intentionally disabled to not get charged
  }
}
