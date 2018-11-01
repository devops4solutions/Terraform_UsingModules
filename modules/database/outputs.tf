output "db_instance_address" {
  value = "${aws_db_instance.mysqlDbInstance.address}"
}