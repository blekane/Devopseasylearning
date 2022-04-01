# # Bastion Host
# resource "aws_instance" "bastion" {
#   ami                    = data.aws_ami.amzlinux2.id
#   instance_type          = var.bastion_instance_type
#   key_name               = var.instance_keypair
#   monitoring             = var.monitoring
#   user_data              = file("${path.module}/website.sh")
#   subnet_id              = aws_subnet.public.*.id[1]
#   vpc_security_group_ids = [aws_security_group.bastion_sg.id]

#   tags = {
#     Name        = format("%s-bastion-host", var.environment)
#     Environment = var.environment
#     Owner       = var.owner
#     "Manage by" : "Terraform"
#   }

#   # connection {
#   #   type        = "ssh"
#   #   host        = aws_instance.bastion.public_ip
#   #   user        = "ec2-user"
#   #   private_key = file("./private-key/jenkins-key.pem")
#   #   # Default timeout is 5 minutes
#   #   timeout = "4m"
#   # }
#   # provisioner "file" {
#   #   source      = ("./private-key/jenkins-key.pem")
#   #   destination = "/home/ec2-user/jenkins-key.pem"
#   # }
#   # provisioner "remote-exec" {
#   #   inline = [
#   #     "chmod 400 /home/ec2-user/jenkins-key.pem"
#   #   ]
#   # }
# }


