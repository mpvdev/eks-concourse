variable "name_prefix" {
  description = "Name prefix used for EKS IAM resources"
  type        = string
}

variable "tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
  default     = {}
}