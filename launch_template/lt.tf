data "terraform_remote_state" "ami"{
    backend = "s3" 
    config = {
        bucket = "my-tf-sr-first-bucket"
        key = "practice/jenkins-job/ami/terraform.tfstate"
        region = "us-east-1"
    }
}

resource "aws_launch_template" "hello-world" {
  name = var.name
  disable_api_termination = true
  iam_instance_profile {
    name = var.profile
  }
  image_id = data.terraform_remote_state.ami.outputs.ami
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = var.security_group
  # lifecycle {
  #   prevent_destroy = true
  # }
}

output "lt_id" {
  value = aws_launch_template.hello-world.id
}

output "version" {
    value = aws_launch_template.hello-world.latest_version
}