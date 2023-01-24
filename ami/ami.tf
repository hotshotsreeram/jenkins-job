module "instance_id" {
  source = "jenkins-job/ec2"

  # ... additional inputs
}

resource "aws_ami_from_instance" "practice" {
  name = "${module.instance_id.instance}-practice"
  source_instance_id = module.instance_id.instance
}

output "ami" {
  value = aws_ami_from_instance.practice.id
}
