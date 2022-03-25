output "vpc_id" {
  description = "ID of my VPC"
  value       = aws_vpc.myvpc.id
}


output "vpc-publicsubnet-ids" {
  description = "IDs of my VPC public subnets"
  #value       = [aws_subnet.public_subnet.0.id, aws_subnet.public_subnet.1.id]
  value = [aws_subnet.public_subnet.*.id]
}


output "vpc-privatesubnet-ids" {
  description = "IDs of my VPC private subnets"
  #value       = [aws_subnet.private_subnet.0.id, aws_subnet.private_subnet.1.id]
  value = [aws_subnet.private_subnet.*.id]
}


output "vpc-dbsubnet-ids" {
  description = "IDs of my VPC db subnets"
  #value       = [aws_subnet.db_subnet.0.id, aws_subnet.db_subnet.1.id]
  value = [aws_subnet.db_subnet.*.id]
}


output "nat_eips" {
  description = "Elastic Ips for NAT"
  value       = [aws_eip.nat_eip.*.public_ip]
}