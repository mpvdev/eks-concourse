module "vpc" {
  source              = "./modules/vpc"
  name_prefix         = local.name_prefix
  vpc_cidr            = var.vpc_cidr
  availability_zones  = var.availability_zones
  public_subnet_cidrs = var.public_subnet_cidrs
}

module "eks_iam" {
  source      = "./modules/eks-iam"
  name_prefix = local.name_prefix
  tags        = local.common_tags
}

module "eks_cluster" {
  source = "./modules/eks-cluster"

  name_prefix      = local.name_prefix
  cluster_version  = var.cluster_version
  cluster_role_arn = module.eks_iam.eks_cluster_role_arn

  subnet_ids = module.vpc.public_subnet_ids

  endpoint_public_access  = true
  endpoint_private_access = false
  public_access_cidrs     = var.eks_public_access_cidrs

  tags = local.common_tags

  depends_on = [
    module.eks_iam
  ]
}

module "eks_node_group" {
  source = "./modules/eks-node-group"

  cluster_name  = module.eks_cluster.cluster_name
  name_prefix   = local.name_prefix
  node_role_arn = module.eks_iam.eks_node_role_arn

  subnet_ids = module.vpc.public_subnet_ids

  instance_types = var.node_instance_types
  capacity_type  = var.node_capacity_type

  desired_size = var.node_desired_size
  min_size     = var.node_min_size
  max_size     = var.node_max_size

  labels = {
    role = "general"
  }

  tags = local.common_tags

  depends_on = [
    module.eks_cluster,
    module.eks_iam
  ]
}

module "ebs_csi_irsa" {
  source = "./modules/eks-ebs-csi-irsa"

  name_prefix     = local.name_prefix
  oidc_issuer_url = module.eks_cluster.cluster_oidc_issuer_url

  tags = local.common_tags

  depends_on = [
    module.eks_cluster
  ]
}

module "eks_addons" {
  source = "./modules/eks-addons"

  cluster_name = module.eks_cluster.cluster_name

  addons = merge(
    var.eks_addons,
    {
      aws-ebs-csi-driver = merge(
        var.eks_addons["aws-ebs-csi-driver"],
        {
          service_account_role_arn = module.ebs_csi_irsa.ebs_csi_role_arn
        }
      )
    }
  )
  tags = local.common_tags

  depends_on = [
    module.eks_node_group,
    module.ebs_csi_irsa
  ]
}

module "argocd" {
  source = "./modules/argocd"

  namespace     = "argocd"
  chart_version = var.argocd_chart_version

  tags = local.common_tags

  depends_on = [
    module.eks_addons
  ]
}