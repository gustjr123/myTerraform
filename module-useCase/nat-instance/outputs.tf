output "name" {
  description = "Name of the instance"
  value       = module.nat_instance.name
}

output "id" {
  description = "ID of the instance"
  value       = module.nat_instance.id
}

output "NIC_name" {
  description = "Name of the NAT instance's network interface"
  value       = module.nat_instance.network_interface_name
}

output "NIC_id" {
  description = "ID of the NAT instance's network interface"
  value       = module.nat_instance.network_interface_id
}

