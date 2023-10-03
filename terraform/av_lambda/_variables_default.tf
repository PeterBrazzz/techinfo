#######
# ECR #
#######

variable "ecr_tag_mutability" {
  type        = string
  description = "ECR tag mutability."
  default     = "MUTABLE"
  validation {
    condition     = can(index(["MUTABLE", "IMMUTABLE"], var.ecr_tag_mutability))
    error_message = "Only ['MUTABLE', 'IMMUTABLE'] values are allowed for tag_mutability variable."
  }
}

variable "ecr_scan_on_push" {
  type        = bool
  description = "Is scan on push needed?"
  default     = true
}

variable "lambda_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to a lambda."
  default     = {}
}

variable "ecr_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to a ECR repository."
  default     = {}
}

##########
# Lambda #
##########

variable "lambda_memory" {
  type        = number
  description = "Memory size for av-lambda function."
  default     = 2000
}

###################
# CloudWatch Logs #
###################

variable "cloudwatch_kms_key" {
  type        = string
  description = "CloudWatch log group kms key id."
  default     = null
  validation {
    condition     = var.cloudwatch_kms_key != ""
    error_message = "CloudWatch kms key variable must not be an empty string."
  }
}

variable "cloudwatch_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to the CloudWatch log group."
  default     = {}
}

#################
# Notifications #
#################

variable "chatbot_arn" {
  type        = string
  description = "ChatBot ARN for notifications."
  default     = null
  validation {
    condition     = var.chatbot_arn != ""
    error_message = "ChatBot ARN must not be an empty string."
  }
}
