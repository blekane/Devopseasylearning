output "public_subnet01_id" {
  value = aws_subnet.public01.id
}

output "public_subnet02_id" {
  value = aws_subnet.public02.id
}


output "vpc_id" {
  value = aws_vpc.tfb.id
}

output "cidr" {
  value = aws_vpc.tfb.cidr_block
}
