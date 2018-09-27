variable "identifier" {
  description = "string to use as identifier for RDS instances"
}

variable "db_port" {
  description = "DB port"
  
}
variable "maintenance_window" {
  description = "Maintenance Window"
  
}
variable "backup_window" {
  description = "Back Up Window"

}

variable "engine" {
  description = "Database engine to use"
}

variable "engine_version" {
  description = "Database version to use for the given engine"
}

variable "instance_class" {
  description = "size to use for the RDS instance"
}

variable "family" {
  description = "Database family to use for the RDS instance"
}

variable "vpc_security_group_ids" {
  type = "list"
  description = "security groups to use for the instance"
  
}

variable "subnet_ids" {
  type = "list"
  description = "subnet IDs to use for the instance"

}

variable "username" {
  description = "username for the database connection"
}

variable "password" {
  description = "password for the database connection"
  
}

variable "backup_retention_period" {
  description = "duration for backup retention"
  default = 0
}

variable "multi_az" {
  description = "deploy multi-az"
  
}

variable "allocated_storage" {
  description = "database storage allocation"
  
}
