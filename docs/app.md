App
=========

## Description

Setup application by pushing sample app code from codebase to AWS CodeCommit repo once all infrastructure has been provisioned.

## Steps

1. Clone empty AWS CodeCommit repo to local workspace. Follow AWS [documentation](https://docs.aws.amazon.com/codecommit/latest/userguide/setting-up-https-unixes.html) to setup HTTPS connections to AWS CodeCommit repositories via AWSCLI credential helper.

    ```
    cd $PROJECT_ROOT/terraform/infra
    APP_REPO_URL=$(terraform output -raw codecommit_repo_clone_url_http)
    APP_REPO_NAME=$(basename $APP_REPO_URL)

    # Clone CodeCommit repo
    git clone $APP_REPO_URL /tmp/$APP_REPO_NAME && cd /tmp/$APP_REPO_NAME
    ```

2. Copy sample app files from codebase, modify Jenkinsfile and push to CodeCommit repo.

    ```
    cd /tmp/$APP_REPO_NAME

    # Copy sample files
    cp $PROJECT_ROOT/sample-app/* .

    # Modify Jenkinsfile
    JENKINS_AGENT_SA_NAME=$(awk -F "=" '/k8_sa_name_jenkins_agent/ {print $2}' $PROJECT_ROOT/terraform/infra/config/common.tfvars | tr -d ' "')
    sed -i "s/<JENKINS_AGENT_SA_NAME>/$JENKINS_AGENT_SA_NAME/g" Jenkinsfile
    sed -i "s#<CODECOMMIT_REPO_URL>#$APP_REPO_URL#g" Jenkinsfile

    # Git add and push to repo
    git config --global user.email "you@example.com"
    git config --global user.name "Your Name"
    git branch -M main
    git add .
    git commit -m "Add sample code."
    git push origin main
    ```

3. Get Jenkins admin credentials and port foward to Kubernetes service.

    ```
    # Update kubeconfig
    EKS_CLUSTER_NAME=$(awk -F "=" '/eks_cluster_name/ {print $2}' $PROJECT_ROOT/terraform/infra/config/common.tfvars | tr -d ' "')
    AWS_REGION=$(awk -F "=" '/aws_region/ {print $2}' $PROJECT_ROOT/terraform/infra/config/common.tfvars | tr -d ' "')
    aws eks --region $AWS_REGION update-kubeconfig --name $EKS_CLUSTER_NAME

    # Get Jenkins admin password
    JENKINS_NS=$(awk -F "=" '/k8_ns_jenkins/ {print $2}' $PROJECT_ROOT/terraform/infra/config/common.tfvars | tr -d ' "')
    printf $(kubectl get secret --namespace $JENKINS_NS jenkins -o jsonpath="{.data.jenkins-admin-password}" | base64 --decode);echo

    # Port foward to jenkins service
    kubectl port-forward -n $JENKINS_NS --address 0.0.0.0 svc/jenkins 8080:8080
    ```

4. Open browser and naviate to `https://localhost:8080`. Enter admin credentails (retrieved in step 3) and navigate to pipeline job. Execute Jenkins pipeline job to check if it is able to access AWS CodeCommit repo and run sample app.
