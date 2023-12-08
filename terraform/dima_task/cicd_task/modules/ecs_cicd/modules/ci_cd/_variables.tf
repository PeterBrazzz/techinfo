variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources."
  validation {
    condition     = length(compact([null, "", var.name_prefix])) > 0
    error_message = "Name prefix must not be empty."
  }
}

variable "artifact_bucket_id" {
  type        = string
  description = "Artifact bucket ID."
}

variable "artifact_bucket_arn" {
  type        = string
  description = "Artifact bucket ARN."
}

variable "code_build_vpc_id" {
  type        = string
  description = "VPC ID where CodeBuild resources are created."
  validation {
    condition     = length(compact([null, "", var.code_build_vpc_id])) > 0
    error_message = "CodeBuild VPC id must not be empty."
  }
}

variable "code_build_subnet_ids" {
  type        = list(string)
  description = "List of subnet IDs where Code Build will be hosted."
  validation {
    condition     = length(var.code_build_subnet_ids) > 0
    error_message = "List of subnet IDs must not be empty."
  }
}

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