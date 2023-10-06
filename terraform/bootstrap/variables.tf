variable "aws_region" {
  description = "AWS region name"
  type        = string
}

variable "terraform_backend" {
  description = "AWS region mappings"
  type = object({
    dynamodb_table_name = string
    s3_bucket_name      = string
  })
}
