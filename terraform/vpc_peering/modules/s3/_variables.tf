variable "prefix" {
  description = "Prefix for names"
  type        = string
}

variable "tags_bucket" {
  default     = {}
  description = "Additional resource tag for bucket"
  type        = map(string)
}
