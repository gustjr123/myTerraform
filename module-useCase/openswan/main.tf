module "myOpenswan" {
  source = "./modules/openswan"

  leftid       = "13.125.80.161"
  right1       = "13.125.185.20"
  right2       = "52.78.204.115"
  leftsubnet   = "172.31.0.0/16"
  rightsubnet1 = "10.0.0.0/16"
  rightsubnet2 = "10.0.0.0/16"
  psk1         = "<key value>"
  psk2         = "<key value>"
}
