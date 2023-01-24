provider "aws" {
    region = var.aws_region
}

terraform {
  backend "s3" {
    bucket = "my-tf-sr-first-bucket"
    key = "practice/jenkins-job/elb/terraform.tfstate"
    region = "us-east-1"
  }
}