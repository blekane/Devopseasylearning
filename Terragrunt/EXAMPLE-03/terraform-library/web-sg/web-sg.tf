variable "environment" {
  type = string
  default = "mam-prod"
}


output "sg_id" {
  value = data.aws_security_group.mam_prod_elb_sg.id
}


resource "aws_security_group" "web_sg" {
  name        = "${var.environment}-web-sg"
  description = "Allow ports 22 from bastion-sg and 80 from elb-sg"
  vpc_id      = data.aws_vpc.mam_prod.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    //cidr_blocks = ["0.0.0.0/0"]
    security_groups = [data.aws_security_group.mam_prod_elb_sg.id]
  }

    ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    //cidr_blocks = ["0.0.0.0/0"]
    security_groups = [data.aws_security_group.mam-prod-bastion-sg.id]
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Name" = "${var.environment}-web-sg"
  }
}

