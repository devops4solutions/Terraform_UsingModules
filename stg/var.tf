variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "tenant" {
  description = "tenant for this network infrastructure"
  default = "Test-KPDI"
}

variable "environment" {
  description = "environment for this network deployment"
  default = "Test-dev"
}

variable "sg_name_prefix" {
  description = "Prefix to use for generated security group names"
  default = "Test-Terraform"
}

variable "instance_name_prefix" {
  description = "Prefix to use for generated EC2 instances"
  default = "Test-Bastion"
}

variable "ssh_public_key" {
  description = "Base64 encoded public key string"
  default="/var/lib/jenkins/.ssh/id_rsa.terraform.pub"
}

variable "ssh_private_key" {
  description = "Base64 encoded private key string"
  default="/var/lib/jenkins/.ssh/id_rsa.terraform"
}

variable "ssh_key_name" {
  description = "Desired name of AWS key pair"
  default = "terraform-deploy"
}

variable "aws_amis" {
  default = {
    us-east-1 = "ami-06b5810be11add0e2"
  }
}

variable instance_type {
default ="t2.micro"
}


variable "vpc_cidr" {
  description = "CIDR to use for this VPC"
  default = "11.0.0.0/16"
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
