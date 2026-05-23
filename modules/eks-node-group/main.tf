resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = var.name_prefix
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  instance_types = var.instance_types
  capacity_type  = var.capacity_type
  ami_type       = var.ami_type
  disk_size      = var.disk_size

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  update_config {
    max_unavailable = 1
  }

  labels = var.labels

  tags = var.tags
}
