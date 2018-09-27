module "database" {
  source = "terraform-aws-modules/rds/aws"

  identifier = "demodb"
  engine = "${var.engine}"
  engine_version = "${var.engine_version}"
  instance_class = "${var.instance_class}"
  port = "${var.db_port}"
  maintenance_window = "${var.maintenance_window}"
  backup_window = "${var.backup_window}"
  allocated_storage = "${var.allocated_storage}"
  username = "${var.username}"
  password = "${var.password}"
  vpc_security_group_ids = ["${var.vpc_security_group_ids}"]
  subnet_ids = ["${var.subnet_ids}"]
  family = "${var.family}"
  backup_retention_period = "${var.backup_retention_period}"
  multi_az = "${var.multi_az}"
}
