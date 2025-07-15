module "s3" {
  source = "./modules/s3"
  source_bucket_name      = var.source_bucket_name
  destination_bucket_name = var.destination_bucket_name
  lambda_function_arn    = module.lambda.lambda_function_arn
}

module "sns" {
  source         = "./modules/sns"
  topic_name     = var.sns_topic_name
  email_endpoint = var.notification_email
}

module "lambda" {
  source                  = "./modules/lambda"
  lambda_function_name    = var.lambda_function_name
  handler_name            = "image_processor.lambda_handler"
  runtime                 = "python3.9"
  source_bucket_name      = var.source_bucket_name
  destination_bucket_name = var.destination_bucket_name
  sns_topic_arn           = module.sns.topic_arn
  lambda_s3_trigger_arn   = module.s3.source_bucket_arn
}
