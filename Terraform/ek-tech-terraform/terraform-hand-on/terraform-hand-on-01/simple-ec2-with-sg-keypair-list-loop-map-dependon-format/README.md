# Terraform For Loops, Lists, Maps and Count Meta-Argument

- Terraform Meta-Argument: `count`
- **Terraform Lists & Maps**
  - List(string)
  - map(string)
- **Terraform for loops**
  - for loop with List
  - for loop with Map
  - for loop with Map Advanced
- **Splat Operators**
  - Legacy Splat Operator `.*.`
  - Generalized Splat Operator (latest)
  - Understand about Terraform Generic Splat Expression `[*]` when dealing with `count` Meta-Argument and multiple output values


### "Name" = format("zedcloud-%s-webserver%02d", var.environment, count.index + 1)
"Name" = "zedcloud-delta-webserver01"
"Name" = "zedcloud-delta-webserver02"
"Name" = "zedcloud-delta-webserver03"

### "Name" = format("zedcloud-%s-webserver%03d", var.environment, count.index + 1)
"Name" = "zedcloud-delta-webserver001"
"Name" = "zedcloud-delta-webserver002"
"Name" = "zedcloud-delta-webserver003"

### "Name" = format("zedcloud-%s-webserver%d", var.environment, count.index + 1)
"Name" = "zedcloud-delta-webserver1"
"Name" = "zedcloud-delta-webserver2"
"Name" = "zedcloud-delta-webserver3"

### "Name" = "zedcloud-${var.environment}-${count.index + 1}"
"Name" = "zedcloud-delta-webserver1"
"Name" = "zedcloud-delta-webserver2"
"Name" = "zedcloud-delta-webserver3"

### "Name" = "zedcloud-${var.environment}-0${count.index + 1}"
"Name" = "zedcloud-delta-webserver01"
"Name" = "zedcloud-delta-webserver02"
"Name" = "zedcloud-delta-webserver03"