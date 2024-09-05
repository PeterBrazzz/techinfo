variable "prefix" {
  description = "Prefix for names."
  type        = string
}

variable "default_tag" {
  default     = {}
  description = "Additional tag for all resources."
  type        = map(string)
}

variable "tags_iam_role" {
  default     = {}
  description = "Additional resource tag for iam role."
  type        = map(string)
}

variable "tags_policy" {
  default     = {}
  description = "Additional resource tag for iam policy."
  type        = map(string)
}

variable "tags_instance_profile" {
  default     = {}
  description = "Additional resource tag for instance profile."
  type        = map(string)
}
