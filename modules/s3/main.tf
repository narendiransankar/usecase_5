resource "aws_s3_bucket" "source" {
  bucket = var.source_bucket_name
}

resource "aws_s3_bucket" "destination" {
  bucket = var.destination_bucket_name
}

resource "aws_s3_bucket_notification" "lambda_trigger" {
  bucket = aws_s3_bucket.source.id

  lambda_function {
    events = ["s3:ObjectCreated:*"]
    lambda_function_arn = var.lambda_function_arn
  }

  depends_on = [
  aws_s3_bucket.source,
  var.lambda_permission_dependency
  ]
}
