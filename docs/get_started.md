[AWS CLI Config & Credentials]: http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html
[IAM]: http://docs.aws.amazon.com/IAM/latest/UserGuide/introduction.html

Get Started
=========

## Pre-Requisites

- Install [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- Install [Terraform](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)

## Environment Setup

### AWS CLI Config & Credentials

Please ensure [AWS CLI Config & Credentials][] of AWS organizations management account are set with sufficient [IAM][] privileges.

1. Using IAM user API access keys.

    * ~/.aws/config

        ```shell
        [profile <aws_profile>]  # profile name for target AWS account. e.g. "consultek-demo"
        region = ap-southeast-2  # AWS region.
        ```

    * ~/.aws/credentials

        ```shell
        [<aws_profile>]  # profile name for target AWS account. e.g. "consultek-demo"
        aws_access_key_id = XXXXXXXXXXXXX
        aws_secret_access_key = YYYYYYYYYYYYYYYYYYYYYYYYYYYY
        ```

2. Using AWS profile to assume AWS SSO roles.

    * ~/.aws/config

        ```shell
        [profile <aws_profile>]  # profile name of target AWS account
        region = ap-southeast-2  # AWS region.
        sso_start_url = https://<org>.awsapps.com/start  # AWS SSO URL for AWS organization.
        sso_region = ap-southeast-2  # AWS SSO region.
        sso_account_id = 012345678912  # AWS organizations management account ID
        sso_role_name = Administrator  # AWS SSO role name
        ```

### Environment Variables

Set environment variables

```shell
export AWS_PROFILE="<aws_profile>"  # profile name of target AWS account. e.g. "consultek-demo"
```

You can test AWS API access once you have set the environment variable to the corresponding AWS account.

```shell
# Verify account ID and caller information.
aws sts get-caller-identity
```
