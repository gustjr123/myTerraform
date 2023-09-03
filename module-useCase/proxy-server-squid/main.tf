module "squid" {
  source = "./modules/proxy-server-squid"

  IP       = "127.0.0.1"
  user     = "user"
  password = "userpw"
}
