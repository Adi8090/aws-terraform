variable "vpc_id" {
  description = "The VPC ID where the subnets will be created"
  type        = string
}

variable "subnet_cidrs" {
  description = "List of CIDR blocks for the subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "azs" {
  description = "List of Availability Zones"
  type        = list(string)
  default     = ["ap-south-1a", "ap-south-1b"]
}

variable "map_public_ip_on_launch" {
  description = "Should instances get a public IP"
  type        = bool
  default     = true
}