# Specify the provider and access details
provider "aws" {
  region = "${var.aws_region}"
}

/*locals {
  default_instance_name_prefix = "${join("-", list(lower(var.tenant), "infra", lower(var.environment)))}"
  instance_name_prefix = "${var.instance_name_prefix != "" ? var.instance_name_prefix : local.default_instance_name_prefix}"
}
*/
locals {
  default_sg_name_prefix = "${join("-", list(lower(var.tenant), "infra", lower(var.environment)))}"
  sg_name_prefix = "${var.sg_name_prefix != "" ? var.sg_name_prefix : local.default_sg_name_prefix}"
}

// VPC
module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${join("-", list(lower(var.tenant), "infra", lower(var.environment)))}"
  cidr = "${var.vpc_cidr}"

  azs = "${var.availability_zones["${var.aws_region}"]}"

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

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Tier = "Public"
  }

  private_subnet_tags = {
    Tier = "Private"
  }

  tags = {
    Terraform = "True"
    Environment = "${var.environment}"
    Tenant = "${var.tenant}"
  }
}

// Security Groups
module "ssh_public_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "${local.sg_name_prefix}-ssh-server-public"
  description = "Security group for web-server with SSH ports open publicly"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

// Security Groups
module "ssh_private_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/ssh"

  name        = "${local.sg_name_prefix}-ssh-server-private"
  description = "Security group for web-server with SSH ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}

// Security Groups
module "web_server_public_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/web"

  name        = "${local.sg_name_prefix}-web-server-public"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["0.0.0.0/0"]
}

// Security Groups
module "web_server_private_sg" {
  source = "terraform-aws-modules/security-group/aws//modules/web"

  name        = "${local.sg_name_prefix}-web-server-private"
  description = "Security group for web-server with HTTP ports open within VPC"
  vpc_id      = "${module.vpc.vpc_id}"

  ingress_cidr_blocks = ["${module.vpc.vpc_cidr_block}"]
}

module "ec2_instance" {

  source = "../modules/kpdi-infra-compute"
  instance_type ="${var.instance_type}"
  ssh_key_name ="${var.ssh_key_name}"
  tenant="${var.tenant}"
  environment="${var.environment}"
  ssh_public_key ="{var.ssh_public_key}"
  ssh_private_key="{var.ssh_private_key}"
    
	
  aws_amis = "${var.aws_amis["${var.aws_region}"]}"

 
  instance_name_prefix="{var.instance_name_prefix}"
 // public_subnet_id = "${element(module.vpc.public_subnets,0)}"
public_subnet_id = "${module.vpc.public_subnets}"
  web_server_public_sg ="${module.web_server_public_sg.this_security_group_id}"

}

terraform {

 backend "s3" {
 bucket = "terraform-remote-kpdi-dev"
 region = "us-east-1"
 key = "terraform.tfstate"
 encrypt="true"
 }
 }


