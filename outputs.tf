output "vpc_id" {
  description = "ID of the VPC"
  value       = module.vpc.vpc_id
}

output "vpc_cidr_block" {
  description = "CIDR block of the VPC"
  value       = module.vpc.vpc_cidr_block
}

output "public_subnet_ids" {
  description = "IDs of the public subnets"
  value       = module.vpc.public_subnet_ids
}

output "public_subnet_cidr_blocks" {
  description = "CIDR blocks of the public subnets"
  value       = module.vpc.public_subnet_cidr_blocks
}

output "internet_gateway_id" {
  description = "ID of the Internet Gateway"
  value       = module.vpc.internet_gateway_id
}

output "public_route_table_id" {
  description = "ID of the public route table"
  value       = module.vpc.public_route_table_id
}

output "eks_cluster_role_name" {
  description = "Name of the EKS cluster IAM role"
  value       = module.eks_iam.eks_cluster_role_name
}

output "eks_cluster_role_arn" {
  description = "ARN of the EKS cluster IAM role"
  value       = module.eks_iam.eks_cluster_role_arn
}

output "eks_node_role_name" {
  description = "Name of the EKS node IAM role"
  value       = module.eks_iam.eks_node_role_name
}

output "eks_node_role_arn" {
  description = "ARN of the EKS node IAM role"
  value       = module.eks_iam.eks_node_role_arn
}

output "eks_cluster_name" {
  description = "Name of the EKS cluster"
  value       = module.eks_cluster.cluster_name
}

output "eks_cluster_arn" {
  description = "ARN of the EKS cluster"
  value       = module.eks_cluster.cluster_arn
}

output "eks_cluster_endpoint" {
  description = "EKS cluster API endpoint"
  value       = module.eks_cluster.cluster_endpoint
}

output "eks_cluster_security_group_id" {
  description = "Security group created by EKS for the cluster"
  value       = module.eks_cluster.cluster_security_group_id
}

output "eks_node_group_name" {
  description = "Name of the EKS managed node group"
  value       = module.eks_node_group.node_group_name
}

output "eks_node_group_arn" {
  description = "ARN of the EKS managed node group"
  value       = module.eks_node_group.node_group_arn
}

output "eks_node_group_status" {
  description = "Status of the EKS managed node group"
  value       = module.eks_node_group.node_group_status
}

output "eks_addon_names" {
  description = "Names of EKS add-ons managed by Terraform"
  value       = module.eks_addons.addon_names
}

output "eks_addon_versions" {
  description = "Versions of EKS add-ons managed by Terraform"
  value       = module.eks_addons.addon_versions
}

output "argocd_namespace" {
  description = "ArgoCD namespace"
  value       = module.argocd.namespace
}

output "argocd_release_status" {
  description = "ArgoCD Helm release status"
  value       = module.argocd.release_status
}