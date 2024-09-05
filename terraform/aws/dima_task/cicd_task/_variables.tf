variable "name_prefix" {
  type        = string
  description = "Name prefix for all resources."
  default = "brazovsky-task"
}

# ################
# # CodePipeline #
# ################

# variable "code_pipeline_output_artifact_format" {
#   type        = string
#   description = "Description of CodeBuild project."
#   default     = "CODE_ZIP"
# }

# variable "code_pipeline_detect_changes" {
#   type        = string
#   description = "Detect changes."
#   default     = null
# }

# #############
# # CodeBuild #
# #############

# variable "secret_data" {
#   type = list(object({
#     name  = string
#     value = string
#   }))
#   description = "A list of values that should be set to a secret."
#   default     = []
# }

# variable "code_build_environment_vars" {
#   type = list(
#     object({
#       name  = string
#       value = string
#     })
#   )
#   description = "A list of plaintext env variables is set to CodeBuild project."
#   default     = []
# }

# variable "code_build_app_environment_extra_secrets" {
#   type = list(
#     object({
#       keys = list(string)
#       arn  = string
#       kms  = string
#       hash = string
#     })
#   )
#   description = "A list of env variables is set to the app during CodeBuild."
#   default     = []
# }

# variable "code_build_source_buildspec" {
#   type        = string
#   description = "A path to the buildspec in the repo."
#   default     = "./automation/pipeline-buildspec.yaml"
#   validation {
#     condition     = length(compact([null, "", var.code_build_source_buildspec])) > 0
#     error_message = "CodeBuild source builspec variable must not be empty."
#   }
# }


# #######
# # VPC #
# #######

# variable "vpc_id" {
#   type        = string
#   description = "VPC ID where resources are created."
#   validation {
#     condition     = length(compact([null, "", var.vpc_id])) > 0
#     error_message = "VPC id must not be empty."
#   }
# }

# variable "vpc_subnet_ids" {
#   type        = list(string)
#   description = "List of subnet IDs where VPC specific resources will be hosted."
#   validation {
#     condition     = length(var.vpc_subnet_ids) > 0
#     error_message = "List of subnet IDs must not be empty."
#   }
# }


# #######
# # SCM #
# #######

# variable "code_pipeline_source" {
#   type = object({
#     codestar_connection_arn = string
#     repository_id           = string
#     repository_branch       = string
#   })
#   description = "CodePipeline source configuration."
#   validation {
#     condition     = var.code_pipeline_source != null
#     error_message = "CodePipeline source configuration must not be empty."
#   }
# }
