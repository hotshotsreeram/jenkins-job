module "lt" {
  source = "/var/lib/jenkins/workspace/jenkins-test/launch_template"

  # ... additional inputs
}

module "elb" {
  source = "/var/lib/jenkins/workspace/jenkins-test/elb"

  # ... additional inputs
}

resource "aws_autoscaling_group" "practice" {
  vpc_zone_identifier = [var.subnet, var.subnet2]
  desired_capacity   = 2
  max_size           = 2
  min_size           = 1
  health_check_type    = "ELB"
  load_balancers = [module.elb.elb_id]

  launch_template {
    id      = module.lt.lt_id
    version = "$Latest"
  }
}