variable "private_dns_enabled" {
  type        = bool
  description = "Whether or not to associate a private hosted zone with the specified VPC."
  default     = false
}

###########
# Tagging #
###########

variable "endpoint_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to vpc endpoint."
  default     = {}
}

variable "sg_tags" {
  type        = map(string)
  description = "A key - value list of additional tags, that is attached to security group."
  default     = {}
}
