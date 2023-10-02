variable "security_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
}

variable "instance_name" {
  description = "Value of the Name tag for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Type of the EC2 instance"
  type        = string
}

variable "instance_ami" {
  description = "AMI of the EC2 instance"
  type        = string
}

variable "iam_instance_profile" {
  description = "AMI of the EC2 instance"
  type        = string
}
