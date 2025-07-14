resource "aws_s3_bucket" "source_bucket" {
  bucket = var.source_bucketname

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}
