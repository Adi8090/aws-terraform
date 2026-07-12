<<<<<<< HEAD
# output "vpc_id" {
#   description = "The ID of the VPC"
#   value       = aws_vpc.this.id
# }

=======
>>>>>>> parent of a8790d1 (VPC error resolve1)
output "subnet_id" {
  description = "The ID of the subnet"
  value       = aws_subnet.this.id
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.this.id
}