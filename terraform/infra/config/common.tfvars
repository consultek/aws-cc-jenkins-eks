aws_region = "ap-southeast-2"

codecommit_repo_name = "sample-app"

eks_cluster_name = "consultek-demo"

eks_cluster_version = "1.27"

jenkins_agent_iam_role_name = "consultek-demo-eks-jenkins-agent"

jenkins_iam_role_name = "consultek-demo-eks-jenkins"

jenkins_pipeline_job_name = "deploy-sample-app"

jenkins_pipeline_repo_branch = "main"

k8_ns_jenkins = "jenkins-system"

k8_sa_name_jenkins = "jenkins"

k8_sa_name_jenkins_agent = "jenkins-agent"

subnet_tag_names = {
  eks_control_plane = [
    "demo-nonprod-application-a",
    "demo-nonprod-application-b",
    "demo-nonprod-application-c",
  ]
  eks_worker_nodes = [
    "demo-nonprod-application-a",
    "demo-nonprod-application-b",
    "demo-nonprod-application-c",
  ]
}

vpc_tag_name = "demo-nonprod"
