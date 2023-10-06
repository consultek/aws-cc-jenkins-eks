locals {
  jenkins_iam_role_name = "${var.jenkins_iam_role_name}-${var.aws_region}"
  jenkins_agent_iam_role_name = "${var.jenkins_agent_iam_role_name}-${var.aws_region}"
}
