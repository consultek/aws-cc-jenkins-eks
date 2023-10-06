module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_addons = {
    aws-ebs-csi-driver = {
      most_recent = true
    }
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  cluster_name    = var.eks_cluster_name
  cluster_version = var.eks_cluster_version

  cluster_endpoint_public_access  = true

  iam_role_name = "${var.eks_cluster_name}-eks-cluster-${var.aws_region}"
  iam_role_use_name_prefix = false


  vpc_id                   = data.aws_vpc.eks.id
  subnet_ids               = data.aws_subnets.eks_worker_nodes.ids
  control_plane_subnet_ids = data.aws_subnets.eks_control_plane.ids

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults  = {
    iam_role_additional_policies    = {
      AmazonEBSCSIDriverPolicy = "arn:aws:iam::aws:policy/service-role/AmazonEBSCSIDriverPolicy"
    }
    iam_role_name                   = "${var.eks_cluster_name}-eks-workers-${var.aws_region}"
    iam_role_use_name_prefix        = false
    launch_template_use_name_prefix = false
    use_name_prefix = false
  }
  eks_managed_node_groups = {
    default = {
      name                 = "${var.eks_cluster_name}-eks-node-group-default"
      min_size             = 1
      max_size             = 6
      desired_size         = 3
      instance_types       = ["t3.xlarge"]
      launch_template_name = "${var.eks_cluster_name}-eks-node-group-default"
    }
  }

  # aws-auth configmap
  manage_aws_auth_configmap = true
}
