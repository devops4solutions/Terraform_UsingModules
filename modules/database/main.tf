resource "aws_db_instance" "mysqlDbInstance" {
     
identifier = "kpdi-hosting-shared"
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
  //family = "${var.family}"
  backup_retention_period = "${var.backup_retention_period}"
  multi_az = "${var.multi_az}"
  db_subnet_group_name   = "${aws_db_subnet_group.subnetGroup.id}"
  
   tags {
    "Name" = "${var.tenant}-${var.environment}-db"
    "Terraform" = "True"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

}

resource "aws_db_subnet_group" "subnetGroup" {
  name        = "main_subnet_group"
  description = "Our main group of subnets"
  subnet_ids  =["${var.db_subnet_id}","${var.db_subnet_2_id}"]
  
    tags {
    "Name" = "${var.tenant}-${var.environment}-subnet-group"
    "Terraform" = "True"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }
}


/*module "database" {
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
  subnet_ids = ["${var.db_subnet_id}","${var.db_subnet_2_id}"]
  family = "${var.family}"
  backup_retention_period = "${var.backup_retention_period}"
  multi_az = "${var.multi_az}"
} */
