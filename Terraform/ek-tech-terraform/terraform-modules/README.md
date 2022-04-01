### Bit
* cidrsubnet: it use to calculate subnets
* 8 is the number of bits
* if the numer of bit is 8, we have the below subnets.(255.255.255.0)
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

private_cidrs   = [
      + "10.0.3.0/24",
      + "10.0.4.0/24",
      + "10.0.5.0/24",
    ]

public_cidrs    = [
      + "10.0.0.0/24",
      + "10.0.1.0/24",
      + "10.0.2.0/24",
    ]
```

* if the numer of bit is 4, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 8, count.index)}"

+ private_cidrs   = [
      + "10.0.48.0/20",
      + "10.0.64.0/20",
      + "10.0.80.0/20",
    ]

  + public_cidrs    = [
      + "10.0.0.0/20",
      + "10.0.16.0/20",
      + "10.0.32.0/20",
    ]
```
* if the numer of bit is 10, we have the below subnets.
```tf
cidr_block = "${cidrsubnet(var.cidr_block, 10, count.index)}"
+ private_cidrs   = [
      + "10.0.0.192/26",
      + "10.0.1.0/26",
      + "10.0.1.64/26",
 
  + public_cidrs    = [
      + "10.0.0.0/26",
      + "10.0.0.64/26",
      + "10.0.0.128/26",
    ]
```
### Connect on the private from bastion 
* Store the in s3 
* Download it into a bastion and change the permission
```t
wget https://s3.amazonaws.com/linuxtraining.tk/bastion-key.pem
chmod 400 bastion-key.pem
ssh -i "bastion-key.pem" ec2-user@10.0.5.205
```
### Test on the private subnet
```
yum update -y
yum install -y tree
ping -c5 www.google.com
```

### RDS
* Put the DB on the public subnet so the you can test the connection


### from_port and to_port values for icmp protocol ingress rule aws_security_group resource? 
- [here](https://stackoverflow.com/questions/65673015/from-port-and-to-port-values-for-icmp-protocol-ingress-rule-aws-security-group-r)
- and [here](https://earlruby.org/2021/08/allow-ping-from-specific-subnets-to-aws-ec2-instances-using-terraform/)

Assuming you want to allow a ping to your server you can use the following terraform configuration 
```
from_port = 8
to_port = 0
protocol = "icmp"
```


```t
resource "aws_instance" "my-test-instance" {
  count                  = 2
  ami                    = "${data.aws_ami.centos.id}"
  instance_type          = "${var.instance_type}"
  key_name               = "${var.key_name.id}"
  vpc_security_group_ids = ["${var.security_group}"]
  // this will create 2 instance in 2 different subnet us-west-2a and us-west-2b. we use the element function to do that.
  subnet_id              = "${element(var.subnets, count.index )}"
  user_data              = "${data.template_file.init.rendered}"

  tags = {
    Name = "my-instance-${count.index + 1}"
  }
}

resource "aws_ebs_volume" "my-test-ebs" {
  count             = 2
  availability_zone = "${data.aws_availability_zones.available.names[count.index]}"
  size              = 1
  type              = "gp2"
}
```

## RDS Postgres
https://github.com/terraform-aws-modules/terraform-aws-rds/tree/v4.2.0/examples/complete-mysql
https://gist.github.com/kshailen/0d4f78596b0ab12659be908163ed1fc2
https://aws.amazon.com/getting-started/hands-on/create-connect-postgresql-db/



https://asvignesh.in/installing-postgresql-in-aws-ubuntu-ec2-instance/
sudo apt install postgresql postgresql-contrib
sudo apt update

### RDS Postgres connection from AWS
psql -h <DB endpoint or host> -p <port> -U <username> -W <database>
psql -h development-postgres-identifier.cv3uwkomseya.us-east-1.rds.amazonaws.com -p 5432 -U edu -W postgres


### Postgresql 13 installation on AWS Ec2 Amazon Linux 2
https://www.how2shout.com/linux/install-postgresql-13-on-aws-ec2-amazon-linux-2/
```
sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg13]
name=PostgreSQL 13 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/13/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF

sudo yum update
sudo yum install postgresql13 postgresql13-server
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb
sudo systemctl start postgresql-13
sudo systemctl enable postgresql-13
```


* allocated_storage: This is the amount in GB
* storage_type: Type of storage we want to allocate(options avilable "standard" (magnetic), "gp2" (general purpose SSD), or "io1" (provisioned IOPS SSD)
* engine: Database engine(for supported values check https://docs.aws.amazon.com/AmazonRDS/latest/APIReference/API_CreateDBInstance.html) eg: Oracle, Amazon Aurora,Postgres 
* engine_version: engine version to use
* instance_class: instance type for rds instance
* name: The name of the database to create when the DB instance is created.
* username: Username for the master DB user.
* password: Password for the master DB user
* db_subnet_group_name:  DB instance will be created in the VPC associated with the DB subnet group. If unspecified, will be created in the default VPC
* vpc_security_group_ids: List of VPC security groups to associate.
* allows_major_version_upgrade: Indicates that major version upgrades are allowed. Changing this parameter does not result in an outage and the change is asynchronously applied as soon as possible.
* auto_minor_version_upgrade:Indicates that minor engine upgrades will be applied automatically to the DB instance during the maintenance window. Defaults to true.
* backup_retention_period: The days to retain backups for. Must be between 0 and 35. When creating a Read Replica the value must be greater than 0
* backup_window:The daily time range (in UTC) during which automated backups are created if they are enabled. Must not overlap with maintenance_window
* maintainence_window:The window to perform maintenance in. Syntax: "ddd:hh24:mi-ddd:hh24:mi".
* multi_az: Specifies if the RDS instance is multi-AZ
* skip_final_snapshot: Determines whether a final DB snapshot is created before the DB instance is deleted. If true is specified, no DBSnapshot is created. If false is specified, a DB snapshot is created before the DB instance is deleted, using the value from final_snapshot_identifier. Default is false


### TERRAFORM – MANAGING AUTO SCALING GROUPS & LOAD BALANCERS
https://hands-on.cloud/terraform-recipe-managing-auto-scaling-groups-and-load-balancers/