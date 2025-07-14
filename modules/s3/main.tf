resource "aws_s3_bucket" "source_bucket" {
  bucket = "source_bucket-hcl-us-east1-bucket"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
