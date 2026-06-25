terraform {
  backend "s3" {
    bucket = "terraform-state-172"
    key    = "serverless/terraform.tfstate"
    region = "ap-south-1"
  }
}