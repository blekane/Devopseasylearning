
data "aws_vpc" "mam_prod" {
  filter {
    name = "tag:Name"
    values = ["mam-prod-vpc"]
  }
}