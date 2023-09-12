output "cgwID" {
  description = "ID of the customer gateway"
  value       = aws_customer_gateway.cgw.id
}

output "cgwTagName" {
  description = "Tag name of the customer gateway"
  value       = aws_customer_gateway.cgw.tags.Name
}

output "tgwID" {
  description = "ID of transit gateway"
  value       = aws_ec2_transit_gateway.tgw.id
}

output "tgwTagName" {
  description = "Tag name of transit gateway"
  value       = aws_ec2_transit_gateway.tgw.tags.Name
}

output "vpnConnID" {
  description = "ID of vpn connection"
  value       = aws_vpn_connection.vpn_cnn.id
}

output "rtbID" {
  description = "ID of routing table"
  value       = aws_route.tgw_route.id
}
