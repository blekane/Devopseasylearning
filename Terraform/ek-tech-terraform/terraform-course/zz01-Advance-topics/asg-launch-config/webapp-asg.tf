resource "aws_autoscaling_group" "asg-webapp" {
  count                   = local.webapp["instance_count"]
  name                    = format("%s-webapp-asg-${count.index + 1}", local.tags["application"])
  //vpc_zone_identifier     = data.aws_subnet.test_subnet.id

  launch_template {
    id      = aws_launch_template.lt-webapp[count.index].id
    version = "$Latest"
  }

  max_size                  = 1
  min_size                  = 1
  desired_capacity          = 1
  health_check_grace_period = 300
  health_check_type         = "EC2"

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [desired_capacity]
  }

  dynamic "tag" {
    for_each = merge(map("Name", format("%s-webapp-asg-${count.index + 1}", local.tags["application"])), local.tags)

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = false
    }
  }
}



