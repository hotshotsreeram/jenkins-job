resource "aws_instance" "practice_instance" {
    ami = var.ami
    instance_type = var.instance_type
    # VPC
    subnet_id = var.subnet
    # Security Group
    vpc_security_group_ids = var.security_group
    # the Public SSH key
    key_name = var.key
    # nginx installation
    associate_public_ip_address = true
    user_data = file("userdata.sh")
    tags = {
    # The count.index allows you to launch a resource 
    # starting with the distinct index number 0 and corresponding to this instance.
    Name = "my-machine"
  }
}


resource "aws_ebs_volume" "practice" {
  availability_zone = "us-east-1a"
  size              = 8

  tags = {
    Name = "Practice"
  }
}

resource "aws_ebs_snapshot" "practice_snapshot" {
  volume_id = aws_ebs_volume.practice.id

  tags = {
    Name = "Practice_snap"
  }
}

resource "aws_ami_from_instance" "practice" {
  name               = "terraform-practice"
  source_instance_id = aws_instance.practice_instance.id
}

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