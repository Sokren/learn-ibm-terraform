output "vsi_private_ip" {
  description = "The private IP address assigned to the VSI"
  value       = ibm_is_instance.vsi.primary_network_attachment[0].virtual_network_interface[0].primary_ip[0].address
}

output "vsi_public_ip" {
  description = "The public Floating IP attached to the VSI"
  value       = ibm_is_floating_ip.public_ip.address
}

output "ssh_connection_string" {
  description = "SSH connection command to connect to the VSI"
  value       = "ssh -i ./rsakey.pem root@${ibm_is_floating_ip.public_ip.address}"
}

output "private_key_pem" {
  description = "Private key in PEM format for SSH access"
  value       = tls_private_key.rsa_4096_key.private_key_pem
  sensitive   = true
}
