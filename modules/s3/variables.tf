variable "source_bucket_name" {}
variable "destination_bucket_name" {}
variable "lambda_function_arn" {}
variable "lambda_permission_dependency" {
  type = any
  default = null
}
