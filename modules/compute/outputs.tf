output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "proxy_public_ip" {
  value = "${aws_instance.proxy.public_ip}"
}

output "sandbox_private_ip" {
  value = "${aws_instance.sandbox.private_ip}"
}
