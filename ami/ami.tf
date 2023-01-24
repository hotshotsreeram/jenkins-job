data "terraform_remote_state" "instance"{
    backend = "s3" {
        bucket = "my-tf-sr-first-bucket"
        key = "practice/jenkins-job/ec2/terraform.tfstate"
        region = "us-east-1"
  }
}

resource "aws_ami_from_instance" "practice" {
  name = "${module.instance_id.instance}-practice"
  source_instance_id = data.terraform_remote_state.instance.id
}

output "ami" {
  value = aws_ami_from_instance.practice.id
}
