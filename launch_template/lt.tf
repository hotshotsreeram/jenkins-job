module "ami_id" {
  source = "/var/lib/jenkins/workspace/jenkins-test/ami"

  # ... additional inputs
}

resource "aws_launch_template" "hello-world" {
  name = var.name
  disable_api_termination = true
  iam_instance_profile {
    name = var.profile
  }
  image_id = module.ami_id.ami
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