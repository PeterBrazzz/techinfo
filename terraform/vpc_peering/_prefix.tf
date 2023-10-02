variable "prefix" {
  description = "Prefix for names"
  type        = string
  default     = "sanchoiser-project"
}

variable "prefix_ap" {
  description = "Prefix for Tokyo infrastructure"
  type        = string
  default     = "sanchoiser-project-ap-northeast-1"
}

variable "prefix_us" {
  description = "Prefix for Oregon infrastructure"
  type        = string
  default     = "sanchoiser-project-us-west-2"
}

variable "prefix_eu" {
  description = "Prefix for Paris infrastructure"
  type        = string
  default     = "sanchoiser-project-eu-west-3"
}