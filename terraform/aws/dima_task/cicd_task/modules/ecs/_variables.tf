variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources."
  validation {
    condition     = length(compact([null, "", var.name_prefix])) > 0
    error_message = "Name prefix must not be empty."
  }
}

#######
# VPC #
#######

variable "vpc_id" {
  type        = string
  description = "VPC ID where resources are created."
  validation {
    condition     = length(compact([null, "", var.vpc_id])) > 0
    error_message = "VPC id must not be empty."
  }
}

variable "vpc_subnets" {
  type = list(string)
  description = "VPC subnets configuration."
  validation {
    condition     = var.vpc_subnets != null
    error_message = "VPC subnets configuration must not be empty."
  }
}

#######
# ECR #
#######

variable "ecr_repo_url" {
  type = string
  description = "ECR repository URL."
    validation {
    condition     = var.ecr_repo_url != null
    error_message = "ECR repository url must not be empty."
  }
}

variable "ecr_repo_arn" {
  type = string
  description = "ECR repository ARN."
    validation {
    condition     = var.ecr_repo_arn != null
    error_message = "ECR repository ARN must not be empty."
  }
}