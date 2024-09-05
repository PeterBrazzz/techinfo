
######################
# S3 artifact bucket #
######################

variable "s3_force_destroy" {
  type        = bool
  description = "Should all objects be deleted during the s3 bucket termination?"
  default     = false
}

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

variable "s3_versioning" {
  type = object({
    enabled    = bool
    mfa_delete = bool
  })
  description = "S3 bucket versioning config block."
  default = {
    enabled    = false
    mfa_delete = false
  }
}

variable "s3_tags" {
  type        = map(string)
  description = "A key - value list of tags, that is attached to S3 bucket."
  default     = {}
}

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

variable "ecr_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to a ECR repository."
  default     = {}
}
