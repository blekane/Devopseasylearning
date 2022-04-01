output "postgresql_host" {
  value = "${aws_db_instance.default.address}"
}

output "postgresql_user" {
  value = "${aws_db_instance.default.username}"
}

output "postgresql_password" {
  value = "${random_string.db_password.result}"
}

output "postgresql_database" {
  value = "${aws_db_instance.default.name}"
}
