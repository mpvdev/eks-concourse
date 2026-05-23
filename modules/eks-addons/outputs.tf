output "addon_names" {
  description = "Names of the managed EKS add-ons"
  value       = keys(aws_eks_addon.this)
}

output "addon_arns" {
  description = "ARNs of the managed EKS add-ons"
  value = {
    for name, addon in aws_eks_addon.this : name => addon.arn
  }
}

output "addon_versions" {
  description = "Versions of the managed EKS add-ons"
  value = {
    for name, addon in aws_eks_addon.this : name => addon.addon_version
  }
}