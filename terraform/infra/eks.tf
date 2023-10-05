module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = var.eks_cluster_name
  cluster_version = "1.27"

  cluster_endpoint_public_access  = true


  vpc_id                   = data.aws_vpc.eks.id
  subnet_ids               = data.aws_subnets.eks_worker_nodes.ids
  control_plane_subnet_ids = data.aws_subnets.eks_control_plane.ids

  # EKS Managed Node Group(s)
  eks_managed_node_groups = {
    default = {
      min_size     = 1
      max_size     = 6
      desired_size = 3
      instance_types = ["t3.large"]
    }
  }
  # aws-auth configmap
  manage_aws_auth_configmap = true
}
