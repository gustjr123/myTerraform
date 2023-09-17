module "myOpenswan" {
  source = "./modules/openswan"

  leftid       = "3.34.191.49"
  right1       = "3.39.17.109"
  right2       = "13.209.1.173"
  leftsubnet   = "10.0.0.0/16"
  rightsubnet1 = "172.31.0.0/16"
  rightsubnet2 = "172.31.0.0/16"
  psk1         = "<PSK>"
  psk2         = "<PSK>"
}
