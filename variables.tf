variable "aws_region" {
  description = "AWS region to deploy resources in"
  type        = string
  default     = "ap-south-1"
}

variable "project_name" {
  description = "Project name to be used in resource naming and tagging"
  type        = string
  default     = "concourseci"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
}

variable "availability_zones" {
  description = "Availability zones for the public subnets"
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster"
  type        = string
}

variable "eks_public_access_cidrs" {
  description = "CIDR blocks allowed to access the public EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_instance_types" {
  description = "EC2 instance types for EKS worker nodes"
  type        = list(string)
}

variable "node_capacity_type" {
  description = "Capacity type for EKS worker nodes. Valid values are ON_DEMAND or SPOT"
  type        = string
}

variable "node_desired_size" {
  description = "Desired number of EKS worker nodes"
  type        = number
}

variable "node_min_size" {
  description = "Minimum number of EKS worker nodes"
  type        = number
}

variable "node_max_size" {
  description = "Maximum number of EKS worker nodes"
  type        = number
}

variable "eks_addons" {
  description = "Map of EKS add-ons to install/manage"
  type = map(object({
    addon_version               = optional(string)
    resolve_conflicts_on_create = optional(string, "OVERWRITE")
    resolve_conflicts_on_update = optional(string, "OVERWRITE")
    service_account_role_arn    = optional(string)
  }))
  default = {}
}

variable "argocd_chart_version" {
  description = "ArgoCD Helm chart version"
  type        = string
}