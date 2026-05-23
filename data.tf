data "aws_eks_cluster" "this" {
  name = module.eks_cluster.cluster_name

  depends_on = [
    module.eks_cluster
  ]
}

data "aws_eks_cluster_auth" "this" {
  name = module.eks_cluster.cluster_name

  depends_on = [
    module.eks_cluster
  ]
}
