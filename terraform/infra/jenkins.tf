resource "kubernetes_namespace" "jenkins" {
  metadata {
    name = var.k8_ns_jenkins
  }
  depends_on = [
    module.eks,
  ]
}

resource "helm_release" "jenkins" {
  name       = "jenkins"
  repository = "https://charts.jenkins.io"
  chart      = "jenkins"
  namespace  = var.k8_ns_jenkins
  atomic     = true
  values     = [
    templatefile(
      "${path.module}/templates/helm/jenkins-values.yml.tftpl",
      {
        jenkins_sa_name = var.k8_sa_name_jenkins
        jenkins_agent_sa_name = var.k8_sa_name_jenkins_agent
        jenkins_iam_role_arn = aws_iam_role.eks_jenkins.arn
        jenkins_agent_iam_role_arn = aws_iam_role.eks_jenkins_agent.arn
        pipeline_job_name = var.jenkins_pipeline_job_name
        pipeline_repo_url = aws_codecommit_repository.sample_app.clone_url_http
        pipeline_repo_branch = var.jenkins_pipeline_repo_branch
      }
    )
  ]
  depends_on = [
    kubernetes_namespace.jenkins,
  ]
}
