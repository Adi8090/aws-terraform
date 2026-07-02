variable "vm_username" {
  description = "The username for the EC2 instance"
  type        = string
  default     = "ubuntu"
}

variable "vm_password" {
  description = "The SSH password for the EC2 instance"
  type        = string
  sensitive   = true # This prevents Terraform from printing it in the logs
}