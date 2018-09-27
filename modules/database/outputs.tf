output "this_db_instance_address" {
  description = "The address of the RDS instance"
  value       = "${module.database.this_db_instance_address}"
}
