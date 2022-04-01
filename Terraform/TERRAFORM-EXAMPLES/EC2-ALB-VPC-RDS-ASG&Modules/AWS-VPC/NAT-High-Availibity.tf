# Create EIP

resource "aws_eip" "my-test-eip1" {
  vpc = true
}

resource "aws_eip" "my-test-eip2" {
  vpc = true
}

# Create a NAT and associate it with the EIP
// The public_subnet in AZ 1 and 2 (us-west-2a and us-west-2b)
resource "aws_nat_gateway" "my-test-nat-gateway1" {
  allocation_id = aws_eip.my-test-eip1.id
  subnet_id     = aws_subnet.public_subnet.0.id
}

resource "aws_nat_gateway" "my-test-nat-gateway2" {
  allocation_id = aws_eip.my-test-eip2.id
  subnet_id     = aws_subnet.public_subnet.1.id
}