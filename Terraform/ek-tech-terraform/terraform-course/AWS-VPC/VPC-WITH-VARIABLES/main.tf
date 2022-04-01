
 ### Step 3: Create a VPC (Virtual Private Cloud in AWS)!
resource "aws_vpc" "custom" {
  cidr_block = var.cdir-bloc-subnet[0]
  enable_dns_hostnames = true
  tags = {
    Name = "custom"
  }
}


### Step 4: Create a Public Subnet with auto public IP Assignment enabled in custom VPC!
resource "aws_subnet" "subnet1" {
  depends_on = [
    aws_vpc.custom
  ]
  vpc_id = aws_vpc.custom.id
  cidr_block = var.cdir-bloc-subnet[1]
  availability_zone = var.azs[0]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet"
  }
}


### Step 5: Create a Private Subnet in customer VPC!
resource "aws_subnet" "subnet2" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1
  ]
  vpc_id = aws_vpc.custom.id
  cidr_block = var.cdir-bloc-subnet[2]
  
  # Data Center of this subnet.
  availability_zone = var.azs[1]
  
  tags = {
    Name = "Private Subnet"
  }
}


### Step 6: Creating an Internet Gateway!
resource "aws_internet_gateway" "Internet_Gateway" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]
  vpc_id = aws_vpc.custom.id

  tags = {
    Name = "IG-Public-&-Private-VPC"
  }
}


### Step 7: Create a routing table for Internet Gateway!
resource "aws_route_table" "Public-Subnet-RT" {
  depends_on = [
    aws_vpc.custom,
    aws_internet_gateway.Internet_Gateway
  ]
  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = var.external-route
    gateway_id = aws_internet_gateway.Internet_Gateway.id
  }

  tags = {
    Name = "Route Table for Internet Gateway"
  }
}


### Step 8: Associate the routing table to the Public Subnet!
resource "aws_route_table_association" "RT-IG-Association" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_route_table.Public-Subnet-RT
  ]

  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.Public-Subnet-RT.id
}


### Step 9: Creating an Elastic IP for the NAT Gateway!
resource "aws_eip" "Nat-Gateway-EIP" {
  depends_on = [
    aws_route_table_association.RT-IG-Association
  ]
  vpc = true
}


### Step 10: Creating a NAT Gateway!
resource "aws_nat_gateway" "NAT_GATEWAY" {
  depends_on = [
    aws_eip.Nat-Gateway-EIP
  ]

  # Allocating the Elastic IP to the NAT Gateway!
  allocation_id = aws_eip.Nat-Gateway-EIP.id
  subnet_id = aws_subnet.subnet1.id
  tags = {
    Name = "Nat-Gateway_Project"
  }
}


### Step 11: Creating a Route Table for the NAT Gateway!
resource "aws_route_table" "NAT-Gateway-RT" {
  depends_on = [
    aws_nat_gateway.NAT_GATEWAY
  ]

  vpc_id = aws_vpc.custom.id

  route {
    cidr_block = var.external-route
    nat_gateway_id = aws_nat_gateway.NAT_GATEWAY.id
  }

  tags = {
    Name = "Route Table for NAT Gateway"
  }

}


### Step 12: Associating the Route table for NAT Gateway to Public Subnet!
resource "aws_route_table_association" "Nat-Gateway-RT-Association" {
  depends_on = [
    aws_route_table.NAT-Gateway-RT
  ]

  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.NAT-Gateway-RT.id
}


### Step 13: Create a Security Group for the WordPress instance!
resource "aws_security_group" "WS-SG" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]

  description = "HTTP, PING, SSH"
  name = "webserver-sg"
  vpc_id = aws_vpc.custom.id

  ingress {
    description = "HTTP for webserver"
    from_port   = var.httpd-port
    to_port     = var.httpd-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for ping
  ingress {
    description = "Ping"
    from_port   = 0
    to_port     = 0
    protocol    = "ICMP"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Created an inbound rule for SSH
  ingress {
    description = "SSH"
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outward Network Traffic for the WordPress
  egress {
    description = "output from webserver"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


#### Step 14: Create a Security Group for Mysql instance!
resource "aws_security_group" "MySQL-SG" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.WS-SG
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name = "mysql-sg"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for MySQL
  ingress {
    description = "MySQL Access"
    from_port   = var.mysql-port
    to_port     = var.mysql-port
    protocol    = "tcp"
    security_groups = [aws_security_group.WS-SG.id]
  }

  egress {
    description = "output from MySQL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 15: Creating a Security Group for the Bastion Host!
resource "aws_security_group" "BH-SG" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2
  ]

  description = "MySQL Access only from the Webserver Instances!"
  name = "bastion-host-sg"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for Bastion Host SSH
  ingress {
    description = "Bastion Host SG"
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    description = "output from Bastion Host"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 16: Creating a Security Group for the MySQL Instance which allows only bastion host to connect & do the updates!
resource "aws_security_group" "DB-SG-SSH" {
  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.BH-SG
  ]

  description = "MySQL Bastion host access for updates!"
  name = "mysql-sg-bastion-host"
  vpc_id = aws_vpc.custom.id

  # Created an inbound rule for MySQL Bastion Host
  ingress {
    description = "Bastion Host SG"
    from_port   = var.ssh-port
    to_port     = var.ssh-port
    protocol    = "tcp"
    security_groups = [aws_security_group.BH-SG.id]
  }

  egress {
    description = "output from MySQL BH"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


### Step 17: Launching a Webserver Instance hosting WordPress in it in public subnet!
resource "aws_instance" "webserver" {

  depends_on = [
    aws_vpc.custom,
    aws_subnet.subnet1,
    aws_subnet.subnet2,
    aws_security_group.BH-SG,
    aws_security_group.DB-SG-SSH
  ]
  
  # AMI ID [I have used my custom AMI which has some softwares pre installed]
  ami = var.ami-key-pair[0]
  instance_type = var.instancetype[0]
  //instance_type = var.instancetype[1]
  subnet_id = aws_subnet.subnet1.id
  key_name = var.ami-key-pair[1]
  vpc_security_group_ids = [aws_security_group.WS-SG.id]

  tags = {
   Name = "Webserver_From_Terraform"
  }

  # Installing required softwares into the system!
  connection {
    type = "ssh"
    user = var.user
    private_key = file(var.private-key-path)
    host = aws_instance.webserver.public_ip
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


### Step 18: Launching a MySQL instance in the private subnet!
resource "aws_instance" "MySQL" {
  depends_on = [
    aws_instance.webserver,
  ]

  ami = var.ami-key-pair[0]
  instance_type = var.instancetype[0]
  //instance_type = var.instancetype[2]
  subnet_id = aws_subnet.subnet2.id
  key_name = var.ami-key-pair[1]
  vpc_security_group_ids = [aws_security_group.MySQL-SG.id, aws_security_group.DB-SG-SSH.id]

  tags = {
   Name = "MySQL_From_Terraform"
  }
}


### Step 19: Launching a Bastion Host instance in the public subnet!
resource "aws_instance" "Bastion-Host" {
   depends_on = [
    aws_instance.webserver,
    aws_instance.MySQL
  ]
  
  ami = var.ami-key-pair[0]
  instance_type = var.instancetype[0]
  subnet_id = aws_subnet.subnet1.id
  key_name = var.ami-key-pair[1]
  vpc_security_group_ids = [aws_security_group.BH-SG.id]
  tags = {
   Name = "Bastion_Host_From_Terraform"
  }
}



