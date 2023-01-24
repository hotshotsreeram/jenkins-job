variable "aws_region"{
    type = string
}

variable "ami" {
    type = string
}

variable "instance_type" {
    type = string
}

variable "key" {
    type = string
}

variable "subnet" {
    type = string
}

variable "security_group" {
    type = list(string)
}