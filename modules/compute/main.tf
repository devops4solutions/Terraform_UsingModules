resource "aws_instance" "bastion" {

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${base64decode(var.ssh_private_key)}"
  }

  instance_type = "${var.instance_type}"

  ami = "${var.aws_amis}"
  key_name = "${var.ssh_key_name}"

  vpc_security_group_ids = ["${var.bastion_security_groups}"]

  subnet_id = "${var.subnet_id}"

 // user_data = "${file("${path.module}/cloud-config/sandbox-bastion.yml")}"

  tags {
    "Name" = "${var.name_prefix}-bastion"
    "Terraform" = "True"
    "Chef" = "True"
    "Role" = "Bastion"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

 /* provisioner "file" {
    content = "${var.chef_data_bag_secret}"
    destination = "/home/ubuntu/chef_data_bag_secret"
  }

  provisioner "file" {
    content = "${base64decode(var.ssh_private_key)}"
    destination = "/home/ubuntu/.ssh/id_rsa.terraform"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ubuntu/chef_data_bag_secret /etc/chef/data_bag_secret",
      "sudo mv /home/ubuntu/.ssh/id_rsa.terraform /etc/chef/id_rsa.terraform",
      "sudo chown -R root:root /etc/chef/",
      "sudo chmod 0600 /etc/chef/id_rsa.terraform"
    ]
  } */
}

resource "aws_instance" "sandbox" {

  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = "${base64decode(var.ssh_private_key)}"
  }

  instance_type = "${var.instance_type}"

 ami = "${var.aws_amis}"
  key_name = "${var.ssh_key_name}"

  vpc_security_group_ids = ["${var.sandbox_security_groups}"]

  subnet_id = "${var.subnet_id}"

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

  //user_data = "${file("${path.module}/cloud-config/sandbox-web.yml")}"

  tags {
    "Name" = "${var.name_prefix}-sandbox"
    "Terraform" = "True"
    "Chef" = "True"
    "Role" = "Hosting-Sandbox-Shared"
    "Environment" = "${var.environment}"
    "Tenant" = "${var.tenant}"
  }

 /* provisioner "file" {
    content = "${var.chef_data_bag_secret}"
    destination = "/home/ubuntu/chef_data_bag_secret"
  }

  provisioner "file" {
    content = "${base64decode(var.ssh_private_key)}"
    destination = "/home/ubuntu/.ssh/id_rsa.terraform"
  }

  provisioner "file" {
    content = "${base64decode(var.deploy_ssh_private_key)}"
    destination = "/home/ubuntu/.ssh/id_rsa.deploy"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo mv /home/ubuntu/chef_data_bag_secret /etc/chef/data_bag_secret",
      "sudo mv /home/ubuntu/.ssh/id_rsa.terraform /etc/chef/id_rsa.terraform",
      "sudo mv /home/ubuntu/.ssh/id_rsa.deploy /etc/chef/id_rsa.deploy",
      "sudo chown -R root:root /etc/chef/",
      "sudo chmod 0600 /etc/chef/data_bag_secret",
      "sudo chmod 0600 /etc/chef/id_rsa.terraform",
      "sudo chmod 0600 /etc/chef/id_rsa.deploy"
    ]
  } */
}
