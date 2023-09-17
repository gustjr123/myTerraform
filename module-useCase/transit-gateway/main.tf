provider "aws" {
  region = "ap-northeast-2"
}

module "tgw-cgw-conn" {
  source = "./modules/transit-gateway"

  # cgw attribute
  cgwIP  = "3.34.191.49"
  cgwASN = 65000

  # attach attribute
  attachVpcId        = "vpc-02bfceb5febc715cb"
  attachVpcSubnetIds = ["subnet-007c18c53d604e863", "subnet-0c9ae391c8fc441ca", "subnet-08b48d59a5c7e023f", "subnet-032e7aaed7b7a164b"]

  # rtb attribute
  rtbId           = "rtb-0767c2efafac8b5f1"
  destinationCIDR = "10.0.0.0/16"
}
