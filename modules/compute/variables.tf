variable "name_prefix" {
  description = "prefix to use for naming instances"
}

variable "private_subnet_id" {
  description = "Private ID of VPC subnet to use"
}

variable "public_subnet_id" {
  description = "Public ID of VPC subnet to use"
} 
variable "instance_type"
{
  description ="Instance Type"
}

variable aws_amis {}

variable "bastion_security_groups" {
  type = "list"
  description = "List of security group IDs to use for ssh bastion server"
}

variable "proxy_security_groups" {
  type = "list"
  description = "List of security group IDs to use for proxy server"
}

variable "sandbox_security_groups" {
  type = "list"
  description = "List of security group IDs to use for web server"
}

variable "ssh_key_name" {
  description = "Desired name of AWS key pair"
  
}

variable "ssh_public_key" {
  description = "Base64 encoded public key string"
}

variable "ssh_private_key" {
  description = "Base64 encoded private key string"
}

/*variable "deploy_ssh_private_key" {
  description = "SSH private key to install for cloning sandbox repositories"
  
}*/

variable "install_deploy_ssh_private_key" {
  description = "Boolean to disable automatic installation of SSH private key for deployment"
  default = true
}



variable "environment" {
  description = "Tag to use for the Environment attribute"
}

variable "tenant" {
  description = "Tag to use for the Environment attribute"
}

variable "sandbox_root_storage_allocation" {
  description = "Size in GB for the root EBS device"
}

variable "sandbox_home_storage_allocation" {
  description = "Size in GB for the EBS device to mount on /home"
}

variable "sandbox_www_storage_allocation" {
  description = "Size in GB for the EBS device to mount on /var/www"
}

variable "sandbox_storage_delete_on_termination" {
  description = "Delete the attached EBS volumes on instance termination"
  default = false
}




