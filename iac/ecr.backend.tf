terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-cozero"
    key    = "shared/ecr/terraform.tfstate"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB
    # intentionally disabled to not get charged
  }
}
