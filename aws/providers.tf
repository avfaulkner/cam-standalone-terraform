# Configure the AWS Provider
provider "aws" {
  version = "~> 2.0"
  region  = var.region
  profile = var.aws_profile
}

terraform {
  required_version = ">= 0.12.26"
}