module "instance_id" {
  source = "/var/lib/jenkins/workspace/jenkins-test/ec2"

  # ... additional inputs
}

resource "aws_ami_from_instance" "practice" {
  name = "${module.instance_id.instance}-practice"
  source_instance_id = module.instance_id.instance
}

output "ami" {
  value = aws_ami_from_instance.practice.id
}
