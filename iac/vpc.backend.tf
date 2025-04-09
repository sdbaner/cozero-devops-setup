terraform {
  backend "s3" {
    bucket = "terraform-state-bucket-cozero"
    key    = "terraform-vpc.tfstate"
    region = "eu-central-1"
    
    # enable state locking with dynamoDB
    # intentionally disabled to not get charged
  }
}
