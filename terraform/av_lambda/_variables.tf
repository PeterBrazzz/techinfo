variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources."
  validation {
    condition     = length(compact([null, "", var.name_prefix])) > 0
    error_message = "Name prefix must not be empty."
  }
}

variable "env_name" {
  type        = string
  description = "Environment name"
  default     = "latest"
}

variable "bucket" {
  type    = map(string)
  default = {}
}

variable "bucket_id" {
  type    = map(string)
  default = {}
}

variable "artifact_bucket" {
  type    = map(string)
  default = {}
}


variable "sqs_arn" {
  type    = string
  default = null
}

variable "sqs_url" {
  type    = string
  default = null
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
  type = object({
    private = list(string)
    public  = list(string)
  })
  description = "VPC subnets configuration."
  validation {
    condition     = var.vpc_subnets != null
    error_message = "VPC subnets configuration must not be empty."
  }
}

#########
# CI/CD #
#########

variable "code_pipeline_source" {
  type = object({
    codestar_connection_arn = string
    repository_id           = string
    repository_branch       = string
  })
  description = "CodePipeline source configuration."
  validation {
    condition     = var.code_pipeline_source != null
    error_message = "CodePipeline source configuration must not be empty."
  }
}
