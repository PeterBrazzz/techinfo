# Variables for region ap-notheast-1 (Tokyo)

variable "ap_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.20.30.0/24"
}

variable "ap_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet"
  type        = string
  default     = "10.20.30.0/28"
}

variable "ap_public_subnet_cidr" {
  description = "CIDR block for public VPC subnet"
  type        = string
  default     = "10.20.30.16/28"
}

variable "ap_instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ap_instance_ami" {
  description = "AMI of the EC2 instance"
  type        = string
  default     = "ami-0f36dcfcc94112ea1"
}

# Variables for region eu-west-3 (Paris)

variable "eu_vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.20.32.0/24"
}

variable "eu_privat_subnet_cidr" {
  description = "CIDR block for privat VPC subnet"
  type        = string
  default     = "10.20.32.0/28"
}

variable "eu_public_subnet_cidr" {
  description = "CIDR block for public VPC subnet"
  type        = string
  default     = "10.20.32.16/28"
}

variable "eu_instance_type" {
  description = "Type of the EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "eu_instance_ami" {
  description = "AMI of the EC2 instance"
  type        = string
  default     = "ami-0eb375f24fdf647b8"
}


# # Variables for region us-west-2 (Oregon)

# variable "us_vpc_cidr" {
#   description = "CIDR block for VPC"
#   type        = string
#   default     = "10.20.31.0/24"
# }

# variable "us_privat_subnet_cidr" {
#   description = "CIDR block for privat VPC subnet"
#   type        = string
#   default     = "10.20.31.0/28"
# }


# variable "us_public_subnet_cidr" {
#   description = "CIDR block for public VPC subnet"
#   type        = string
#   default     = "10.20.31.16/28"
# }

# variable "us_instance_type" {
#   description = "Type of the EC2 instance"
#   type        = string
#   default     = "t2.micro"
# }

# variable "us_instance_ami" {
#   description = "AMI of the EC2 instance"
#   type        = string
#   default     = "ami-0c2ab3b8efb09f272"
# }



