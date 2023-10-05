resource "aws_iam_role" "eks_jenkins" {
  name        = var.jenkins_iam_role_name
  description = "IAM role for EKS Jenkins service account"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = module.eks.oidc_provider_arn
        }
        Condition = {
          StringEquals = {
            "${replace(module.eks.cluster_oidc_issuer_url, "/http[s]?:\\/\\//", "")}:aud" = "sts.amazonaws.com"
            "${replace(module.eks.cluster_oidc_issuer_url, "/http[s]?:\\/\\//", "")}:sub" = "system:serviceaccount:${var.k8_ns_jenkins}:${var.k8_sa_name_jenkins_agent}"
          }
        }
      },
    ]
  })
  force_detach_policies = true
}

resource "aws_iam_role_policy" "eks_jenkins_access_codecommit" {
  name = "CodeCommitRepoAccess"
  role = aws_iam_role.eks_jenkins.id
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "codecommit:BatchGet*",
          "codecommit:BatchDescribe*",
          "codecommit:Describe*",
          "codecommit:EvaluatePullRequestApprovalRules",
          "codecommit:Get*",
          "codecommit:List*",
          "codecommit:GitPull"
        ]
        Effect = "Allow"
        Resource = [
          aws_codecommit_repository.sample_app.arn
        ]
      },
    ]
  })
}
