provider "aws" {
  region = "${var.aws_region}"
}

locals {
  default_instance_name_prefix = "${join("-", list(lower(var.tenant), "hosting", lower(var.environment), "shared"))}"
  instance_name_prefix = "${var.instance_name_prefix != "" ? var.instance_name_prefix : local.default_instance_name_prefix}"
}

locals {
  default_sg_name_prefix = "${join("-", list(lower(var.tenant), "hosting", lower(var.environment)))}"
  sg_name_prefix = "${var.sg_name_prefix != "" ? var.sg_name_prefix : local.default_sg_name_prefix}"
}


module "vpc" {
  source = "../modules/network/"
  
  aws_region = "${var.aws_region}"
  vpc_cidr = "${var.vpc_cidr}"

  private_subnets = [
    "${cidrsubnet("${var.vpc_cidr}", 8, 2)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 3)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 4)}"
  ]

  public_subnets = [
    "${cidrsubnet("${var.vpc_cidr}", 8, 11)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 12)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 13)}"
  ]

  database_subnets = [
    "${cidrsubnet("${var.vpc_cidr}", 8, 21)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 22)}",
    "${cidrsubnet("${var.vpc_cidr}", 8, 23)}"
  ]

  environment = "${var.environment}"
  tenant = "${var.tenant}"
}

module "ssh_public_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "${local.sg_name_prefix}-ssh-server-public"
  description = "Security group for web-server with SSH ports open publicly"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "ssh_private_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "${local.sg_name_prefix}-ssh-server-private"
  description = "Security group for web-server with SSH ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}

module "web_server_public_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/web"

  name        = "${local.sg_name_prefix}-web-server-public"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

module "web_server_private_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/web"

  name        = "${local.sg_name_prefix}-web-server-private"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}

module "mysql_server_private_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/mysql"

  name        = "${local.sg_name_prefix}-mysql-server-private"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}


module "web_sandbox" {
  source = "../modules/compute"

  name_prefix = "${local.instance_name_prefix}"
 aws_amis = "${var.aws_amis["${var.aws_region}"]}"
  environment = "${var.environment}"
  tenant = "${var.tenant}"

  sandbox_root_storage_allocation = "${var.sandbox_root_storage_allocation}"
  sandbox_home_storage_allocation = "${var.sandbox_home_storage_allocation}"
  sandbox_www_storage_allocation = "${var.sandbox_www_storage_allocation}"
  sandbox_storage_delete_on_termination = "${var.sandbox_storage_delete_on_termination}"

  
  instance_type = "${var.instance_type}"
  ssh_private_key = "${var.ssh_private_key}"
  ssh_public_key = "${var.ssh_public_key}"
  ssh_key_name ="${var.ssh_key_name}"

  deploy_ssh_private_key = "${var.deploy_ssh_private_key}"
  install_deploy_ssh_private_key = "${var.install_deploy_ssh_private_key}"

  chef_data_bag_secret = "${var.chef_data_bag_secret_key}"

  subnet_id = "${element("${module.vpc.public_subnets}", 0)}"

  bastion_security_groups = [
    "${module.ssh_public_sg.this_security_group_id}"
  ]

  sandbox_security_groups = [
    "${module.web_server_public_sg.this_security_group_id}",
    "${module.ssh_public_sg.this_security_group_id}"
  ]
}

module "database" {
  source = "../modules/database"

  identifier = "${join("-", list(local.instance_name_prefix, var.db_engine))}"
  instance_class = "${var.db_instance_class}"
  db_port ="${var.db_port}"
  maintenance_window = "${var.maintenance_window}"
  backup_window = "${var.backup_window}"


  username = "${var.db_root_user}"
  password = "${var.db_root_password}"

  subnet_ids = ["${module.vpc.database_subnets}"]
  vpc_security_group_ids = ["${module.mysql_server_private_sg.this_security_group_id}"]

  engine = "${var.db_engine}"
  engine_version = "${var.db_engine_version}"
  family = "${var.db_family}"

  multi_az = "${var.db_multi_az}"

  allocated_storage = "${var.db_storage_allocation}"

  backup_retention_period = "${var.db_backup_retention_period}"
}

terraform {

 backend "s3" {
 bucket = "terraform-remote-kpdi-dev"
 region = "us-east-1"
 key = "terraform.tfstate"
 encrypt="true"
 }
 } 

