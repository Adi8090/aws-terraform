variable "vpc_id" {
  description = "The VPC ID where the security group will be created"
  type        = string
}

variable "sg_name" {
  description = "Name of the security group"
  type        = string
  default     = "ec2-security-group"
}

resource "aws_security_group" "this" {
  name        = var.sg_name
  description = "Allow inbound SSH and HTTP traffic"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to your IP in production!
  }

  ingress {
    description = "HTTP from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = var.sg_name
  }
}