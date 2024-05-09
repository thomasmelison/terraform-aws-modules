output "vpc_id" {
  description = "The ID of the VPC that has been provisioned."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "The list of the ids of the public subnets that have been provisioned."
  value       = [for _, subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  description = "The list of the ids of the private subnets that have been provisioned."
  value       = [for _, subnet in aws_subnet.private_subnet : subnet.id]
}



