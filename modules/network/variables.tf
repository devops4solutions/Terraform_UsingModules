variable "aws_region" {
  description = "AWS region to launch servers."
  
}

variable "availability_zones" {
  description = "Availability zones to use"
  default = {
   # eu-west-1 = [ "eu-west-1a", "eu-west-1b", "eu-west-1c" ]
    us-east-1 = [ "us-east-1a", "us-east-1b", "us-east-1c", "us-east-1e" ]
   # us-west-1 = [ "us-west-1a", "us-west-1b" ]
   # us-west-2 = [ "us-west-2a", "us-west-2b", "us-west-2c" ]
   # ca-central-1 = [ "ca-central-1a", "ca-central-1b"]
  }
}
variable "vpc_cidr" {
  description = "CIDR block to use for the VPC"
 }

variable "public_subnets" {
  type = "list"
  description = "CIDR blocks for public subnets in the VPC"
 
}

variable "private_subnets" {
  type = "list"
  description = "CIDR blocks for public subnets in the VPC"
 
}

variable "database_subnets" {
  type = "list"
  description = "CIDR blocks for database subnets in the VPC"
}



variable "environment" {
  description = "Tag to use for the Environment attribute"
 
}

variable "tenant" {
  description = "Tag to use for the Environment attribute"
  
}
