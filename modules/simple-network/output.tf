output "vpc_id" {
  value = aws_vpc.this.id
}

output "public_subnet_ids" {
  value = [for _, subnet in aws_subnet.public_subnet : subnet.id]
}

output "private_subnet_ids" {
  value = [for _, subnet in aws_subnet.private_subnet : subnet.id]
}



