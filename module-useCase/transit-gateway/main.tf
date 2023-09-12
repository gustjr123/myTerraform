module "tgw-cgw-conn" {
  source = "./modules/transit-gateway"

  # cgw attribute
  cgwIP  = "54.180.121.220"
  cgwASN = 65000

  # attach attribute
  attachVpcId        = "vpc-010c17f3908d854a2"
  attachVpcSubnetIds = ["subnet-0ec2abc8782992df4", "subnet-044e00cc2601039ba"]

  # rtb attribute
  rtbId           = "rtb-0ae106061fb821005"
  destinationCIDR = "172.31.32.0/20"
}
