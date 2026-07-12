# variable "vpc_id" {
#   description = "The VPC ID where the subnet will be created"
#   type        = string
# }

# variable "subnet_cidr" {
#   description = "The CIDR block for the subnet"
#   type        = string
#   default     = "10.0.1.0/24"
# }

# variable "subnet_name" {
#   description = "Name tag for the subnet"
#   type        = string
#   default     = "main-subnet"
# }

# variable "map_public_ip_on_launch" {
#   description = "Should be true if instances in this subnet should get a public IP"
#   type        = bool
#   default     = true
# }

resource "aws_subnet" "this" {
  count                   = length(var.subnet_cidrs)
  vpc_id                  = var.vpc_id
  cidr_block              = var.subnet_cidrs[count.index]
  availability_zone       = var.azs[count.index]
  map_public_ip_on_launch = var.map_public_ip_on_launch

  tags = {
    Name = "main-subnet-${count.index + 1}"
    # EKS requires this specific tag on public subnets so it knows where to put load balancers!
    "kubernetes.io/role/elb" = "1" 
  }
}