resource "aws_codecommit_repository" "sample_app" {
  repository_name = var.codecommit_repo_name
  description     = "This is the sample app repository"
}
