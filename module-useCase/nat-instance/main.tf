module "nat_instance" {
  source = "./modules/nat"

  name           = "nat-instance"
  vpc_id         = "vpc-010c17f3908d854a2"
  vpc_cidr_ipv4  = "10.0.0.0/16"
  subnet_id      = "subnet-029458fbf69cd0184"
  pvt_subnet_ids = ["subnet-0ec2abc8782992df4", "subnet-044e00cc2601039ba"]
  ssh_key        = "AWSkoreaKey"
}
