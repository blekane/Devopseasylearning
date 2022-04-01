output "public_subnets" {
  // to get the 2 public subnets
  value = "${aws_subnet.public_subnet.*.id}"
}

output "security1_group" {
  value = "${aws_security_group.test_sg.id}"
}

output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "subnet1" {
  // To get the 2 subnets and choose the first one
  // * is to get all the subnet
  value = "${element(aws_subnet.public_subnet.*.id, 1 )}"
}

output "subnet2" {
  value = "${element(aws_subnet.public_subnet.*.id, 2 )}"
}

output "private_subnet1" {
  value = "${element(aws_subnet.private_subnet.*.id, 1 )}"
}

output "private_subnet2" {
  value = "${element(aws_subnet.private_subnet.*.id, 2 )}"
}