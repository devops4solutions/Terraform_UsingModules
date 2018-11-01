module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "${join("-", list(lower(var.tenant), "hosting", lower(var.environment)))}"
  cidr = "${var.vpc_cidr}"

  azs = "${var.availability_zones["${var.aws_region}"]}"

  private_subnets = ["${var.private_subnets}"]
  public_subnets  = ["${var.public_subnets}"]
  database_subnets = ["${var.database_subnets}"]

  enable_nat_gateway = true
  single_nat_gateway = true

  public_subnet_tags = {
    Tier = "Public"
  }

  private_subnet_tags = {
    Tier = "Private"
  }

  database_subnet_tags = {
    Tier = "Database"
  }

  tags = {
    Terraform = "True"
    Environment = "${var.environment}",
    Tenant = "${var.tenant}"
  }
}

resource "aws_flow_log" "vpc_flow_log" {
  log_group_name = "${aws_cloudwatch_log_group.vpc_cloudwatch_log_group.name}"
  iam_role_arn   = "${var.vpcflowlogsrole_arn}"
  vpc_id         = "${module.vpc.vpc_id}"
  traffic_type   = "ALL"
}

resource "aws_cloudwatch_log_group" "vpc_cloudwatch_log_group" {
  name = "${join("-", list(lower(var.tenant), "vpc_cloudwatch_log_group", lower(var.environment)))}"
}

