variable "instance_type" {
    type = string
}

variable "key" {
    type = string
}

variable "security_group" {
    type = list(string)
}

variable "name" {
    type = string
}

variable "profile" {
    type = string
}

variable "aws_region"{
    type = string
}