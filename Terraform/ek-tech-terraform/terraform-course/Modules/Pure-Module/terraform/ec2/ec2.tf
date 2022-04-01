### Launching a Webserver Instance hosting WordPress in it in public subnet!

resource "aws_instance" "webserver" {
	ami               = var.ami
	key_name          = var.key_name
	instance_type     = var.instance_type
	subnet_id         = data.aws_subnet.subnet_dev_vpc_public.id
	security_groups   = [aws_security_group.webserver_sg.id]
	availability_zone = var.availability_zone
  tags = {
   Name = "webserver"
  }

  # Installing required softwares into the system!
  connection {
    type        = "ssh"
    user        = var.user
    private_key = file(var.private-key-path)
    host        = aws_instance.webserver.public_ip
  }

  # Code for installing the softwares!
  provisioner "remote-exec" {
    inline = [
        "sudo yum update -y",
        "sudo yum install php php-mysqlnd httpd -y",
        "wget https://wordpress.org/wordpress-4.8.14.tar.gz",
        "tar -xzf wordpress-4.8.14.tar.gz",
        "sudo cp -r wordpress /var/www/html/",
        "sudo chown -R apache.apache /var/www/html/",
        "sudo systemctl start httpd",
        "sudo systemctl enable httpd",
        "sudo systemctl restart httpd"
    ]
  }
}

