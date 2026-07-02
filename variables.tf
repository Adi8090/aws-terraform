variable "aws_region" {
  description = "The AWS region where resources will be created"
  type        = string
  default     = "ap-south-1" 
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the root VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "subnet_cidr_block" {
  description = "The CIDR block for the public subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "environment" {
  description = "Environment name used for tagging resources"
  type        = string
  default     = "dev"
}

variable "vm_password" {
  description = "The SSH password for the EC2 instance"
  type        = string
  sensitive   = true
}