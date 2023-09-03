output "name" {
  description = "Name of the instance"
  value       = aws_instance.nat_instance.tags.Name
}

output "id" {
  description = "ID of the instance"
  value       = aws_instance.nat_instance.id
}

output "network_interface_name" {
  description = "Name of the NAT instance's network interface"
  value       = aws_network_interface.network_interface.tags.Name
}

output "network_interface_id" {
  description = "ID of the NAT instance's network interface"
  value       = aws_network_interface.network_interface.id
}
