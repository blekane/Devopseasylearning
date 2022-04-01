resource "aws_instance" "my-first-server" {
  ami               = "ami-04d29b6f966df1537"
  instance_type     = "t2.micro"
  key_name          = "jenkins-key"
  subnet_id         = local.rds_subnet_ids.1
  //subnet_id       = local.rds_subnet_ids.0
  //subnet_id       = local.rds_subnet_ids[0]
  tags = {
    Name = "test"
  }
}