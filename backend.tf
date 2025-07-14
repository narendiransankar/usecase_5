terraform {
  required_version = ">= 1.0.0"

  backend "s3" {
    bucket = "hcl-backend-mumbai"
    key    = "usecase5/terraform.tfstate"
    region = "ap-south-1"
  }
}
