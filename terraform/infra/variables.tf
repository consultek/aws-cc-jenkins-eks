variable "aws_region" {
  description = "AWS region name."
  type        = string
}

variable "codecommit_repo_name" {
  description = "AWS CodeCommit repo name."
  type        = string
}

variable "eks_cluster_name" {
  description = "AWS EKS cluster name."
  type        = string
}

variable "eks_cluster_version" {
  description = "AWS EKS cluster version."
  type        = string
}

variable "jenkins_agent_iam_role_name" {
  description = "IAM role name for EKS Jenkins agent service account."
  type        = string
}

variable "jenkins_iam_role_name" {
  description = "IAM role name for EKS Jenkins controller service account."
  type        = string
}

variable "jenkins_pipeline_job_name" {
  description = "Jenkins Pipeline job name."
  type        = string
}

variable "jenkins_pipeline_repo_branch" {
  description = "Jenkins Pipeline SCM repo branch name."
  type        = string
}

variable "k8_ns_jenkins" {
  description = "Kubernetes namespace to deploy Jenkins helm chart."
  type        = string
}

variable "k8_sa_name_jenkins" {
  description = "Kubernetes service account name for Jenkins controller."
  type        = string
}

variable "k8_sa_name_jenkins_agent" {
  description = "Kubernetes service account name for Jenkins agent."
  type        = string
}

variable "subnet_tag_names" {
  description = "List of existing subnet tag names to provision EKS control plane and worker nodes."
  type = object({
    eks_control_plane = list(string)
    eks_worker_nodes  = list(string)
  })
}

variable "vpc_tag_name" {
  description = "Tag name of existing VPC"
  type        = string
}
