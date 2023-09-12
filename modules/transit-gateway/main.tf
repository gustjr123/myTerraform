provider "aws" {
  region = "ap-northeast-2"
}

# Create customer gateway
resource "aws_customer_gateway" "cgw" {
  bgp_asn    = var.cgwASN
  ip_address = var.cgwIP
  type       = var.cgwType

  tags = {
    Name = var.cgwTagName
  }
}

# Create transit gateway
resource "aws_ec2_transit_gateway" "tgw" {
  description = "transit gateway"

  dns_support                     = "enable"
  vpn_ecmp_support                = "enable"
  default_route_table_association = "enable"
  default_route_table_propagation = "enable"
  multicast_support               = "disable"

  auto_accept_shared_attachments = "enable"

  tags = {
    Name = "tgw"
  }
}

# Create tgw attachment (to your VPC)
resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attach" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  dns_support            = "enable"
  ipv6_support           = "disable"
  appliance_mode_support = "disable"

  vpc_id     = var.attachVpcId
  subnet_ids = var.attachVpcSubnetIds
  tags = {
    Name = var.vpcAttachTagName
  }

  depends_on = [aws_ec2_transit_gateway.tgw]
}

# Create vpn connection
resource "aws_vpn_connection" "vpn_cnn" {
  customer_gateway_id = aws_customer_gateway.cgw.id
  transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
  type                = aws_customer_gateway.cgw.type
  static_routes_only  = true

  tags = {
    Name = var.vpnConnTagName
  }

  depends_on = [aws_ec2_transit_gateway.tgw, aws_customer_gateway.cgw]
}

# resource "aws_ec2_transit_gateway_route" "tgr" {
#   destination_cidr_block        = "192.168.0.0/21"
#   route_table_id                = aws_ec2_transit_gateway.tgw.id
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id

#   depends_on = [aws_vpn_connection.vpn_cnn]
# }

# Update routing table
resource "aws_route" "tgw_route" {
  route_table_id         = var.rtbId
  destination_cidr_block = var.destinationCIDR
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.vpc_attach, aws_vpn_connection.vpn_cnn]
}
