resource "aws_db_subnet_group" "default" {
  name       = "${var.tags.environment}-db-subnet-group"
  subnet_ids = [
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2a.id,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2b.id,
    data.aws_subnet.mam_dev_public_subnet_ap_southeast_2c.id
  ]

  tags = merge(map("Name", format("%s-db-subnet-group", var.tags["environment"])), var.tags)
}

/*
resource "aws_db_subnet_group" "default" {
  name       = "${var.tags.environment}-db-subnet-group"
  subnet_ids = [
    data.aws_subnet.mam_dev_private_subnet_ap_southeast_2a.id,
    data.aws_subnet.mam_dev_private_subnet_ap_southeast_2b.id,
    data.aws_subnet.mam_dev_private_subnet_ap_southeast_2c.id
  ]

  tags = merge(map("Name", format("%s-db-subnet-group", var.tags["environment"])), var.tags)
}
*/
