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

variable "artifact_bucket" {
  type    = map(string)
  default = {}
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

#######
# ECR #
#######


variable "code_build_environment_vars" {
  type = list(
    object({
      name  = string
      value = string
    })
  )
  description = "A list of plaintext env variables is set to CodeBuild project."
  default     = []
}


# variable "ecr_repo_url" {
#   type = string
#   description = "ECR repository URL."
#     validation {
#     condition     = var.ecr_repo_url != null
#     error_message = "ECR repository url must not be empty."
#   }
# }

# variable "ecr_repo_arn" {
#   type = string
#   description = "ECR repository ARN."
#     validation {
#     condition     = var.ecr_repo_arn != null
#     error_message = "ECR repository arn must not be empty."
#   }
# }

#######
# ECS #
#######

variable "ecs_cluster_name" {
  type = string
  description = "Name of the ECS cluster."
  validation {
    condition     = var.ecs_cluster_name != null
    error_message = "ECS cluster name must not be empty."
  }
}

variable "ecs_service_name" {
  type = string
  description = "Name of the ECS service."
  validation {
    condition     = var.ecs_service_name != null
    error_message = "ECS service name must not be empty."
  }
}