variable "subnet_id" {
  description = "The ID of the subnet to deploy the instance in"
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to attach"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
  default     = "t2.micro"
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
  default     = "ubuntu-web-server"
}

variable "vm_username" {
  description = "The username for the EC2 instance"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "The SSH password for the EC2 instance"
  type        = string
  sensitive   = true 
}