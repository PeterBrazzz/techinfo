variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources."
  validation {
    condition     = length(compact([null, "", var.name_prefix])) > 0
    error_message = "Name prefix must not be empty."
  }
}

variable "service_name" {
  type        = string
  description = "AWS service name that is used."
  validation {
    condition     = length(compact([null, "", var.service_name])) > 0
    error_message = "Service name must not be empty."
  }
}

variable "vpc_id" {
  type        = string
  description = "VPC id."
  validation {
    condition     = length(compact([null, "", var.vpc_id])) > 0
    error_message = "VPC id must not be empty."
  }
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet ids connected to the endpoint."
  validation {
    condition     = length(distinct(var.subnets)) > 0
    error_message = "Subnet list length must be greater than 0."
  }
}
