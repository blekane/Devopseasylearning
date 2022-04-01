output "elb_address" {
  value = aws_elb.web.dns_name
}

output "addresses" {
  value = aws_instance.web[*].public_ip
}

output "public_subnet_id" {
  value = module.vpc_basic02.public_subnet_id
}

