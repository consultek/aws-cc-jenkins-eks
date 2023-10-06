Bootstrap
=========

## Description

Terraform [bootstrap](../terraform/bootstrap) module is used to provision following AWS resources which are used as Terraform backend configuration for infra Terraform module.

1. AWS DynamoDB Table.
2. AWS S3 Bucket.

## Steps

1. Set input variables.

    ```
    AWS_REGION=$(awk -F "=" '/region/ {print $2}' $PROJECT_ROOT/terraform/backend.conf | tr -d ' "')
    S3_BUCKET_NAME=$(awk -F "=" '/bucket/ {print $2}' $PROJECT_ROOT/terraform/backend.conf | tr -d ' "')
    DYNAMODB_TABLE_NAME=$(awk -F "=" '/dynamodb_table/ {print $2}' $PROJECT_ROOT/terraform/backend.conf | tr -d ' "')
    ```

2. Change into terraform bootstrap directory.

    ```
    cd $PROJECT_ROOT/terraform/bootstrap
    ```

3. Run Terraform init.

    ```
    terraform init
    ```

4. Run Terraform plan and check output.

    ```
    terraform plan -var=terraform_backend="{\"s3_bucket_name\":\"${S3_BUCKET_NAME}\", \"dynamodb_table_name\":\"${DYNAMODB_TABLE_NAME}\"}" -var=aws_region=${AWS_REGION}
    ```

5. Apply Terraform config.

    ```
    terraform apply -auto-approve -var=terraform_backend="{\"s3_bucket_name\":\"${S3_BUCKET_NAME}\", \"dynamodb_table_name\":\"${DYNAMODB_TABLE_NAME}\"}" -var=aws_region=${AWS_REGION}
    ```
