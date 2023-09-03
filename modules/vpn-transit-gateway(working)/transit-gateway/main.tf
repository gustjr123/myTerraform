provider "aws" {
  region = "ap-northeast-2"
}

resource "aws_customer_gateway" "cgw" {
  bgp_asn    = 65000
  ip_address = "106.253.56.124"
  type       = "ipsec.1"

  tags = {
    Name = "cgw"
  }
}

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

resource "aws_vpn_connection" "vpn_cnn" {
  customer_gateway_id = aws_customer_gateway.cgw.id
  transit_gateway_id  = aws_ec2_transit_gateway.tgw.id
  type                = aws_customer_gateway.cgw.type
  static_routes_only  = true

  tags = {
    Name = "vpn_attach"
  }

  depends_on = [aws_ec2_transit_gateway.tgw, aws_customer_gateway.cgw]
}

# resource "aws_ec2_transit_gateway_route" "tgr" {
#   destination_cidr_block        = "192.168.0.0/21"
#   route_table_id                = aws_ec2_transit_gateway.tgw.id
#   transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.example.id

#   depends_on = [aws_vpn_connection.vpn_cnn]
# }

resource "aws_ec2_transit_gateway_vpc_attachment" "vpc_attach" {
  transit_gateway_id = aws_ec2_transit_gateway.tgw.id

  dns_support            = "enable"
  ipv6_support           = "disable"
  appliance_mode_support = "disable"

  vpc_id     = "vpc-0ecd0783983c8993b"
  subnet_ids = ["subnet-05d8194821321ea23", "subnet-0d1d9fc02e1a1a319", "subnet-09a22874db963b25e", "subnet-0b850ea87cb2a9a1f"]
  tags = {
    Name = "tgw_vpc"
  }

  depends_on = [aws_ec2_transit_gateway.tgw]
}

resource "aws_route" "tgw_route" {
  route_table_id         = "rtb-028c514eaa7f666ef"
  destination_cidr_block = "192.168.0.0/21"
  transit_gateway_id     = aws_ec2_transit_gateway.tgw.id

  depends_on = [aws_ec2_transit_gateway_vpc_attachment.vpc_attach, aws_vpn_connection.vpn_cnn]
}
