data "terraform_remote_state" "elb"{
    backend = "s3" 
    config = {
        bucket = "my-tf-sr-first-bucket"
        key = "practice/jenkins-job/elb/terraform.tfstate"
        region = "us-east-1"
    }
}

data "terraform_remote_state" "lt"{
    backend = "s3" 
    config = {
        bucket = "my-tf-sr-first-bucket"
        key = "practice/jenkins-job/lt/terraform.tfstate"
        region = "us-east-1"
    }
}

resource "aws_autoscaling_group" "practice" {
  vpc_zone_identifier = [var.subnet, var.subnet2]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  health_check_type    = "EC2"
  load_balancers = [data.terraform_remote_state.elb.outputs.elb_id]

  launch_template {
    id      = data.terraform_remote_state.lt.outputs.lt_id
    version = data.terraform_remote_state.lt.outputs.version
  }

  instance_refresh {
    strategy = "Rolling"
    triggers = ["launch_template"]
  }
}