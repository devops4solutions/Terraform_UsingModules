output "bastion_public_ip" {
  value = "${aws_instance.bastion.public_ip}"
}

output "sandbox_public_ip" {
  value = "${aws_instance.sandbox.public_ip}"
}

output "sandbox_private_ip" {
  value = "${aws_instance.sandbox.private_ip}"
}
