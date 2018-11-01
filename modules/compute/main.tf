resource "aws_key_pair" "auth" {
  key_name   = "${var.ssh_key_name}"
  public_key = "${file(var.ssh_public_key)}"
}

resource "aws_instance" "proxy" {

  connection {
    type = "ssh"
    user = "ubuntu"
	host = "${aws_instance.proxy.public_ip}" 
	}

  instance_type = "${var.instance_type}"

  ami = "${var.aws_amis}"
  key_name = "${aws_key_pair.auth.id}" 

  vpc_security_group_ids = ["${var.proxy_security_groups}"]
  associate_public_ip_address = "true"

  subnet_id = "${var.public_subnet_id}"

  tags {
    "Name" = "${var.tenant}-${var.environment}-Proxy"
    "Terraform" = "True"
    "Role" = "Proxy"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

 
}

resource "aws_instance" "bastion" {

  connection {
    type = "ssh"
    user = "ubuntu"
	host = "${aws_instance.bastion.public_ip}"
  //  private_key = "${base64decode(var.ssh_private_key)}"
  }

  instance_type = "${var.instance_type}"

  ami = "${var.aws_amis}"
  key_name = "${aws_key_pair.auth.id}" 

  vpc_security_group_ids = ["${var.bastion_security_groups}"]
  associate_public_ip_address = "true"

  subnet_id = "${var.public_subnet_id}"

  tags {
    "Name" = "${var.tenant}-${var.environment}-bastion"
    "Terraform" = "True"
    "Role" = "Bastion"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

 
}

resource "aws_instance" "sandbox" {

  connection {
    type = "ssh"
    user = "ubuntu"
	// host = "${aws_instance.sandbox.public_ip}"
   // public_key = "${base64decode(var.ssh_public_key)}"
  }

  instance_type = "${var.instance_type}"
 // associate_public_ip_address = "true"

 ami = "${var.aws_amis}"
   key_name = "${aws_key_pair.auth.id}" 

  vpc_security_group_ids = ["${var.sandbox_security_groups}"]
  
    subnet_id = "${var.private_subnet_id}"


  root_block_device = {
    volume_size = "${var.sandbox_root_storage_allocation}"
  }

  ebs_block_device = [
    {
      device_name = "/dev/xvdb"
      volume_size = "${var.sandbox_home_storage_allocation}"
      delete_on_termination = "${var.sandbox_storage_delete_on_termination}"
    },
    {
      device_name = "/dev/xvdc"
      volume_size = "${var.sandbox_www_storage_allocation}"
      delete_on_termination = "${var.sandbox_storage_delete_on_termination}"
    }
  ]

  tags {
    "Name" = "${var.tenant}-${var.environment}-sandbox"
    "Terraform" = "True"
    "Role" = "Hosting-Sandbox-Shared"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

 
}
