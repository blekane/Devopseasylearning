# # test-ec2 Host
# resource "aws_instance" "test_ec2" {
#   count                  = var.test_ec2_instance_count
#   ami                    = data.aws_ami.amzlinux2.id
#   instance_type          = var.test_ec2_instance_type
#   key_name               = var.instance_keypair
#   monitoring             = var.monitoring
#   subnet_id              = aws_subnet.private.*.id[count.index + 1]
#   vpc_security_group_ids = [aws_security_group.test_ec2_sg.id]

#   tags = {
#     Name        = format("%s-test-webserver%02d", var.environment, count.index + 1)
#     Environment = var.environment
#     Owner       = var.owner
#     "Manage by" : "Terraform"
#   }
# }

