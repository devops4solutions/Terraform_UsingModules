variable "aws_region" {
  description = "AWS region to launch servers."
  default     = "us-east-1"
}

variable "vpc_cidr" {
  description = "CIDR to use for the new VPC"
  default = "11.0.0.0/16"
}

variable "IAM_CrossAccountRole" {
  description = "Role created on the environment to get assumes from the devops account"
  default = "arn:aws:iam::106231631067:role/Devops_CrossAccountRole"
}

variable "BucketName_Terraform" {
  description = "Bucket name which is used to store Terraform remote state file"
  default = "terraform-kpdi-development"
}




variable "aws_amis" {
  default = {
    us-east-1 = "ami-0ac019f4fcb7cb7e6"
  }
}

variable "environment" {
  description = "Tag to use for the Environment attribute"
  default="dev"
}

variable "tenant" {
  description = "Tag to use for the Environment attribute"
  default = "KPDI"
}



variable "ssh_key_name" {
  description = "Desired name of AWS key pair"
  default = "terraform-deploy"
}

variable "ssh_public_key" {
  description = "Base64 encoded public key string"
  default="../terraform-deploy.pub"
}

variable "ssh_private_key" {
  description = "Base64 encoded private key string"
  default="NA"
}

variable "deploy_ssh_private_key" {
  description = "SSH private key to install for cloning sandbox repositories"
 default="NA"
}

variable "install_deploy_ssh_private_key" {
  description = "Boolean to disable automatic installation of SSH private key for deployment"
  default = true
}



variable "instance_name_prefix" {
  description = "Prefix to use for generated EC2 instances"
  default = "Instance"
}

variable "instance_type" {
  description = "Instance Type"
  default = "t2.micro"
}

variable "sandbox_root_storage_allocation" {
  description = "Size in GB for the root EBS device"
  default = 500
}

variable "sandbox_home_storage_allocation" {
  description = "Size in GB for the EBS device to mount on /home"
  default = 500
}

variable "sandbox_www_storage_allocation" {
  description = "Size in GB for the EBS device to mount on /var/www"
  default = 500
}

variable "sandbox_storage_delete_on_termination" {
  description = "Delete the attached EBS volumes on instance termination"
  default = false
}


variable "sg_name_prefix" {
  description = "Prefix to use for generated security group names"
  default = ""
}

variable "db_identifier" {
  description = "Name to use for the RDS instance identifier"
  default="abc"
  
}

variable "db_root_user" {
  description = "Username to use for administration of RDS database"
  default = "root"
}

variable "vault_path"
{
   description="path of valut secret"
   default ="secret/CLIENTS/DEMO/DEVELOPMENT"
}

variable "db_root_password" {
  description = "Password to use for administration of RDS database"
  default = "mysqlroot"
}

variable "db_engine" {
  description = "Database engine to use for the RDS instance"
  default = "mysql"
}

variable "db_engine_version" {
  description = "Database version to use for the given engine"
  default = "5.7.19"
}

variable "db_instance_class" {
  description = "Instance class to use for the RDS instance"
  default = "db.t2.micro"
}

variable "db_family" {
  description = "Database family to use for the RDS instance"
  default = "mysql5.7"
}

variable "db_multi_az" {
  description = "Deploy the RDS instance across multiple AZs"
  default = false
}

variable "db_backup_retention_period" {
  description = "The number of days to retain backups for"
  default = 0
}

variable "db_storage_allocation" {
  description = "Amount of storage space to allocate for the RDS instance in GB"
  default = 1000
}
variable "db_port" {
  description = "DB port"
  default = 3306
}
variable "maintenance_window" {
  description = "Maintenance Window"
  default = "Mon:00:00-Mon:03:00"
}
variable "backup_window" {
  description = "Back Up Window"
  default = "03:00-06:00"
}
