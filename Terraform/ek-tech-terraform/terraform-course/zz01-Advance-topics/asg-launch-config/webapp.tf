
resource "aws_launch_template" "lt-webapp" {
  count    = local.webapp["instance_count"]
  name     = format("%s-webapp-${count.index + 1}", local.tags["application"])
  image_id = data.aws_ami.amazon-linux-2.id

  instance_type = local.webapp["instance_type"]

  key_name      = local.webapp["key_name"]
  ebs_optimized = false

  monitoring {
    enabled = false
  }

  lifecycle {
    create_before_destroy = true
  }

 
  # root disk
  block_device_mappings {
    device_name = local.amzn_root_disk

    ebs {
      volume_type           = "gp2"
      volume_size           = local.webapp["root_disk_size"]
      delete_on_termination = true
      encrypted             = false
    }
  }


  tag_specifications {
    resource_type = "instance"

    tags = merge(map("Name", format("%s-webapp-${count.index + 1}", local.tags["application"])), local.tags)
  }

  tag_specifications {
    resource_type = "volume"

    tags = merge(map("Name", format("%s-webapp-${count.index + 1}", local.tags["application"])), local.tags)
  }

  tags = merge(map("Name", format("%s-webapp-${count.index + 1}", local.tags["application"])), local.tags)

}


  