provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = try(data.aws_eks_cluster.workload.endpoint, null)
  cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.workload.certificate_authority.0.data), null)
  token                  = try(data.aws_eks_cluster_auth.workload.token, null)
}

provider "helm" {
  kubernetes {
    host                   = try(data.aws_eks_cluster.workload.endpoint, null)
    cluster_ca_certificate = try(base64decode(data.aws_eks_cluster.workload.certificate_authority.0.data), null)
    token                  = try(data.aws_eks_cluster_auth.workload.token, null)
  }
}
