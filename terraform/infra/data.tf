data "aws_subnets" "eks_control_plane" {
  filter {
    name   = "tag:Name"
    values = var.subnet_tag_names.eks_control_plane
  }
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.eks.id
    ]
  }
}

data "aws_subnets" "eks_worker_nodes" {
  filter {
    name   = "tag:Name"
    values = var.subnet_tag_names.eks_worker_nodes
  }
  filter {
    name = "vpc-id"
    values = [
      data.aws_vpc.eks.id
    ]
  }
}

data "aws_vpc" "eks" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_tag_name]
  }
}
