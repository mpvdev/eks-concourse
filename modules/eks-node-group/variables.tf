variable "cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "name_prefix" {
  description = "Prefix for the EKS managed node group name"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN used by EKS worker nodes"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs where worker nodes will be launched"
  type        = list(string)

  validation {
    condition     = length(var.subnet_ids) >= 2
    error_message = "At least two subnet IDs are recommended for the node group."
  }
}

variable "instance_types" {
  description = "EC2 instance types for the node group"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "capacity_type" {
  description = "Capacity type for the node group. Valid values are ON_DEMAND or SPOT"
  type        = string
  default     = "ON_DEMAND"

  validation {
    condition     = contains(["ON_DEMAND", "SPOT"], var.capacity_type)
    error_message = "capacity_type must be either ON_DEMAND or SPOT."
  }
}

variable "ami_type" {
  description = "AMI type for the EKS node group"
  type        = string
  default     = "AL2023_x86_64_STANDARD"
}

variable "disk_size" {
  description = "Disk size in GiB for worker nodes"
  type        = number
  default     = 30
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 2
}

variable "labels" {
  description = "Kubernetes labels applied to nodes in this node group"
  type        = map(string)
  default     = {}
}

variable "tags" {
  description = "Common tags applied to node group resources"
  type        = map(string)
  default     = {}
}