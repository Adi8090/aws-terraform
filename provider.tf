terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Uncomment the block below later if you configure an S3 backend for remote state storage
  # backend "s3" {
  #   bucket = "my-terraform-state-bucket"
  #   key    = "aws-infra/terraform.tfstate"
  #   region = "ap-south-1"
  # }
}

provider "aws" {
  region = var.aws_region

}

# THIS IS THE MAGIC FIX:
  backend "s3" {
    bucket = "adi-terraform-state-12345" # Your exact bucket name
    key    = "aws-infra/terraform.tfstate"
    region = "ap-south-1"
  }
