provider "aws" {
  region = "us-east-1"
}


resource "aws_db_instance" "mysql" {
 
  identifier        = "demodb"
  engine            = "mysql"
  engine_version    = "5.7.19"
  instance_class    = "db.t2.micro"
  storage_type      = "standard"
  allocated_storage = 5
  name              = "demodb"
  username          = data.aws_ssm_parameter.db_user.value
  password          = data.aws_ssm_parameter.db_password.value
  port              = "3306"

  tags = {
    Name = "${var.environment}-mysql"
  }
}
