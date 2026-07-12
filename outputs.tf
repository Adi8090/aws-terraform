output "deployed_region" {
  description = "The region where the infrastructure was deployed"
  value       = var.aws_region
}

output "vpc_id" {
  description = "The ID of the primary VPC"
  value       = module.vpc.vpc_id
}

output "subnet_id" {
  description = "The ID of the first public subnet"
  
  # UPDATE THIS LINE: Add the 's' and the [0]
  value       = module.subnet.subnet_ids[0]
}

output "security_group_id" {
  description = "The ID of the attached security group"
  value       = module.security_group.sg_id
}

output "ec2_public_ip" {
  description = "The public IP address to connect to the EC2 instance"
  value       = module.ec2.public_ip
}