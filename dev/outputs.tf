output "bastion_public_ip" {
  value = "${module.web_sandbox.bastion_public_ip}"
}

output "proxy_public_ip" {
  value = "${module.web_sandbox.proxy_public_ip}"
}

output "sandbox_private_ip" {
  value = "${module.web_sandbox.sandbox_private_ip}"
}
