###########
# Tagging #
###########

variable "s3_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to S3 bucket."
  default     = {}
}
