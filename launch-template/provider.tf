provider "aws" {
    region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "my-tf-sr-first-bucket"
    key = "practice/launch-template/terraform.tfstate"
    region = "us-east-1"
  }
}