variable "name_prefix" {
  description = "Name prefix used for EBS CSI IAM resources"
  type        = string
}

variable "oidc_issuer_url" {
  description = "OIDC issuer URL of the EKS cluster"
  type        = string
}

variable "oidc_audience" {
  description = "OIDC audience for IRSA"
  type        = string
  default     = "sts.amazonaws.com"
}

variable "namespace" {
  description = "Kubernetes namespace of the EBS CSI controller service account"
  type        = string
  default     = "kube-system"
}

variable "service_account_name" {
  description = "Name of the EBS CSI controller service account"
  type        = string
  default     = "ebs-csi-controller-sa"
}

variable "tags" {
  description = "Common tags applied to IAM resources"
  type        = map(string)
  default     = {}
}