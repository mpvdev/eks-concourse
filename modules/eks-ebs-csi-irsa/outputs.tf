output "oidc_provider_arn" {
  description = "ARN of the IAM OIDC provider"
  value       = aws_iam_openid_connect_provider.this.arn
}

output "ebs_csi_role_name" {
  description = "Name of the EBS CSI IRSA IAM role"
  value       = aws_iam_role.ebs_csi.name
}

output "ebs_csi_role_arn" {
  description = "ARN of the EBS CSI IRSA IAM role"
  value       = aws_iam_role.ebs_csi.arn
}