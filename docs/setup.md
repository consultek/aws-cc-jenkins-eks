Setup
=========

1. Clone repository

    ```
    git clone git@github.com:consultek/aws-cc-jenkins-eks.git && cd aws-cc-jenkins-eks
    export PROJECT_ROOT=$(pwd)
    ```

2. Set following values for Terraform S3 backend configuration in [backend.conf](../terraform/backend.conf).

    ```
    bucket         = "" # S3 bucket name
    dynamodb_table = "" # DynamoDB table name
    encrypt        = true
    key            = "" # S3 key
    region         = "" # S3 bucket region
    ```
