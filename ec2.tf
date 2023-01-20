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
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_ami_from_instance" "practice" {
  name = "${aws_instance.practice_instance.id}-practice"
  source_instance_id = aws_instance.practice_instance.id
}

resource "aws_launch_template" "hello-world" {
  name = var.name
  disable_api_termination = true
  iam_instance_profile {
    name = var.profile
  }
  image_id = aws_ami_from_instance.practice.id
  instance_type = var.instance_type
  key_name = var.key
  vpc_security_group_ids = var.security_group
  # lifecycle {
  #   prevent_destroy = true
  # }
}

resource "aws_autoscaling_group" "practice" {
  vpc_zone_identifier = [var.subnet, var.subnet2]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  health_check_type    = "ELB"
  load_balancers = [aws_elb.practice_elb.id]

  launch_template {
    id      = aws_launch_template.hello-world.id
    version = "$Latest"
  }
}

resource "aws_elb" "practice_elb" {
  name = "practice-elb"
  security_groups = var.security_group
  subnets = [var.subnet, var.subnet2]
  cross_zone_load_balancing   = true
  health_check {
    healthy_threshold = 2
    unhealthy_threshold = 2
    timeout = 3
    interval = 30
    target = "HTTP:80/"
  }
  listener {
    lb_port = 80
    lb_protocol = "http"
    instance_port = "80"
    instance_protocol = "http"
  }
}