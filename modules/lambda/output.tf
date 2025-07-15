output "lambda_function_arn" {
  value = aws_lambda_function.image_processor.arn
}
output "allow_s3" {
  value = aws_lambda_permission.allow_s3
}
