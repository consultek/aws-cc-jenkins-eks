Infra
=========

## Description

Terraform [infra](../terraform/infra) module will provision required infrastructure to demonstrate AWS CodeCommit integration with Jenkins deployed on EKS.

## Steps

1. Modify input variables in TFVARS [file](../terraform/infra/config/common.tfvars). Refer to [variables.tf](../terraform/infra/variables.tf) for variable references.

2. Change into bootstrap directory.

    ```
    cd $PROJECT_ROOT/terraform/infra
    ```

3. Run Terraform init.

    ```
    terraform init -backend-config=$PROJECT_ROOT/terraform/backend.conf -reconfigure
    ```

4. Run Terraform plan and check output.

    ```
    terraform plan -var-file=$PROJECT_ROOT/terraform/infra/config/common.tfvars
    ```

5. Apply Terraform config.

    ```
    terraform apply -auto-approve -var-file=$PROJECT_ROOT/terraform/infra/config/common.tfvars
    ```
