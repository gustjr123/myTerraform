provider "aws" {
  region = "ap-northeast-2"
}

module "tgw-cgw-conn" {
  source = "./modules/transit-gateway"

  # cgw attribute
  cgwIP  = "13.125.80.161"
  cgwASN = 65000

  # attach attribute
  attachVpcId        = "vpc-010c17f3908d854a2"
  attachVpcSubnetIds = ["subnet-0ec2abc8782992df4", "subnet-044e00cc2601039ba"]

  # rtb attribute
  rtbId           = "rtb-0ae106061fb821005"
  destinationCIDR = "172.31.0.0/16"
}
