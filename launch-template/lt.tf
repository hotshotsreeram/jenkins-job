resource "aws_launch_template" "hello-world" {
  name = var.name
  disable_api_termination = true
  iam_instance_profile {
    name = var.profile
  }
  image_id = aws_ami_from_instance.practice.id
  instance_initiated_shutdown_behavior = "terminate"
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = var.security_group
}
