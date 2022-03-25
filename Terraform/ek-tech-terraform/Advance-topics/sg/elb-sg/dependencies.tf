data "aws_security_group" "bastion_id" {
  filter {
    name = "tag:Name"
    values = ["mam-dev-bastion"]
  }
}
