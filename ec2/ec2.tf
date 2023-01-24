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

