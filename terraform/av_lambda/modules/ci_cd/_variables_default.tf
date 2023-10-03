################
# CodePipeline #
################

variable "code_pipeline_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to the CodePipeline project."
  default     = {}
}

variable "code_pipeline_iam_role_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to IAM role of CodePipeline project."
  default     = {}
}

#############
# CodeBuild #
#############

variable "code_build_description" {
  type        = string
  description = "Description of CodeBuild project."
  default     = null
  validation {
    condition     = var.code_build_description != ""
    error_message = "CodeBuild description must not be empty."
  }
}

variable "code_build_build_timeout" {
  type        = number
  description = "How long in minutes, from 5 to 480 (8 hours), for AWS CodeBuild to wait until timing out any related build that does not get marked as completed?"
  default     = 60
  validation {
    condition     = var.code_build_build_timeout >= 5 && var.code_build_build_timeout <= 480
    error_message = "Build timeout value must be between 5 and 480."
  }
}

variable "code_build_queued_timeout" {
  type        = number
  description = "How long in minutes, from 5 to 480 (8 hours), a build is allowed to be queued before it times out?"
  default     = 480
  validation {
    condition     = var.code_build_queued_timeout >= 5 && var.code_build_queued_timeout <= 480
    error_message = "Build queued timeout value must be between 5 and 480."
  }
}

variable "code_build_source_buildspec" {
  type        = string
  description = "A path to the buildspec in the repo."
  default     = "./automation/docker-buildspec.yaml"
  validation {
    condition     = length(compact([null, "", var.code_build_source_buildspec])) > 0
    error_message = "CodeBuild source builspec variable must not be empty."
  }
}

variable "code_build_artifact_name" {
  type        = string
  description = "Artifact name of CodeBuild project."
  default     = "application"
  validation {
    condition     = length(compact([null, "", var.code_build_artifact_name])) > 0
    error_message = "CodeBuild artifact name must not be empty."
  }
}

variable "code_build_compute_type" {
  type        = string
  description = "Compute type CodeBuild environment uses. Ignored if environment_type is 'LINUX_CONTAINER' or 'LINUX_GPU_CONTAINER'."
  default     = "BUILD_GENERAL1_SMALL"
  validation {
    condition     = can(index(["BUILD_GENERAL1_SMALL", "BUILD_GENERAL1_MEDIUM", "BUILD_GENERAL1_LARGE", "BUILD_GENERAL1_2XLARGE"], var.code_build_compute_type))
    error_message = "Only ['BUILD_GENERAL1_SMALL', 'BUILD_GENERAL1_MEDIUM', 'BUILD_GENERAL1_LARGE', 'BUILD_GENERAL1_2XLARGE'] values are allowed for code_build_compute_type variable."
  }
}

variable "code_build_image" {
  type        = string
  description = "CodeBuild environment image."
  default     = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
  validation {
    condition     = length(compact([null, "", var.code_build_image])) > 0
    error_message = "CodeBuild image must not be empty."
  }
}

variable "code_build_image_pull_credentials_type" {
  type        = string
  description = "The type of credentials AWS CodeBuild uses to pull images in your build."
  default     = "CODEBUILD"
  validation {
    condition     = can(index(["CODEBUILD", "SERVICE_ROLE"], var.code_build_image_pull_credentials_type))
    error_message = "Only ['CODEBUILD', 'SERVICE_ROLE'] values are allowed for code_build_image_pull_credentials_type variable."
  }
}

variable "code_build_image_privileged_mode" {
  type        = bool
  description = "Should CodeBuild image run in privilleged mode?"
  default     = true
}

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

variable "code_build_environment_vars_ssm" {
  type = list(
    object({
      name = string
      arn  = string
      kms  = string
    })
  )
  description = "A list of env variables from ssm parameters is set to CodeBuild project."
  default     = []
}

variable "code_build_environment_vars_secrets_manager" {
  type = list(
    object({
      keys = list(string)
      arn  = string
      kms  = string
    })
  )
  description = "A list of env variables from secrets manager is set to CodeBuild project."
  default     = []
}

variable "code_build_cloudwatch_kms_key_id" {
  type        = string
  description = "CodeBuild CloudWatch log group kms key id."
  default     = null
  validation {
    condition     = var.code_build_cloudwatch_kms_key_id != ""
    error_message = "CodeBuild CloudWatch log group kms key id must not be empty."
  }
}

variable "code_build_external_iam_policies" {
  type        = list(string)
  description = "A list of external iam policies attached to CodeBuild project."
  default     = []
}

variable "code_build_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to the CodeBuild project."
  default     = {}
}

variable "code_build_iam_role_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to IAM role of CodeBuild project."
  default     = {}
}

variable "code_build_sg_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to SG of CodeBuild project."
  default     = {}
}

variable "code_build_cloudwatch_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to CloudWatch log group of CodeBuild project."
  default     = {}
}

######################
# S3 artifact bucket #
######################

variable "s3_sse_algorithm" {
  type        = string
  description = "The server-side encryption algorithm of s3 bucket. If empty, no encryption is set."
  default     = "AES256"
  validation {
    condition     = can(index(["AES256", "aws:kms"], var.s3_sse_algorithm))
    error_message = "Only ['AES256', 'aws:kms'] values are allowed for s3_sse_algorithm variable."
  }
}

variable "s3_sse_kms_key_id" {
  type        = string
  description = "The AWS KMS master key ID used for the SSE-KMS encryption."
  default     = null
  validation {
    condition     = var.s3_sse_kms_key_id != ""
    error_message = "S3 SSE kms key id variable must not be an empty string."
  }
}

variable "s3_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to S3 bucket."
  default     = {}
}

########################
# EventBrige Scheduler #
########################

variable "code_pipeline_scheduler_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to the EventBrige Scheduler project."
  default     = {}
}

variable "code_pipeline_scheduler_iam_role_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to IAM role of EventBrige Scheduler project."
  default     = {}
}
