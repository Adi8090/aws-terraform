output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.this.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}