terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # The backend block MUST sit right here, inside the terraform block!
  backend "s3" {
    bucket = "adi-terraform-state-12345" # Ensure this matches your actual S3 bucket name
    key    = "aws-infra/terraform.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  region = var.aws_region
}