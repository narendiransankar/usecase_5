terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "hcl-test-backend-state"
    key    = "usecase5/terraform.tfstate"
    region = "ap-south-1"
  }
}
