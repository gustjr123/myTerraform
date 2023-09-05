
# set cluster name
variable "cluster_name" {
  description = "Cluster name"
  type        = string
  default     = "my-project-cluster"
}

# set security group cidr, your cidr of vpc
variable "security_group_ingress_cidr_ipv4" {
  description = "Security group ingress (IPV4)"
  type        = string
  default     = "0.0.0.0/0"
}

# set ssh key name, tag name
variable "ssh_key_name" {
  description = "Name of the SSH key for the NAT instance"
  type        = string
  default     = "ssh-key"
}

variable "subnet_ids" {
  description = "IDs of the subnet"
  type        = list(string)
  default     = ["subnet-07043ee58aa8189fc", "subnet-055c484eb3c706edd", "subnet-05d8194821321ea23", "subnet-09a22874db963b25e"]
}
# public : "subnet-07043ee58aa8189fc", "subnet-055c484eb3c706edd"
# private : "subnet-05d8194821321ea23", "subnet-09a22874db963b25e"

variable "pvt_subnet_ids" {
  description = "ID of the subnet (private subnet)"
  type        = list(string)
  default     = ["subnet-05d8194821321ea23", "subnet-09a22874db963b25e"]
}

# your vpc id
variable "vpc_id" {
  description = "ID of the VPC the NAT instance will be created in (vpc id)"
  type        = string
  default     = "vpc-0ecd0783983c8993b"
}

# security group for cluster (sg-web)
variable "cluster_security_group" {
  description = "security group for cluster"
  type        = list(string)
  default     = ["sg-0f66b9c29fec72f13"]
}

#------------------------------------ NAT -----------------------------------
# set instance name
variable "nat_name" {
  description = "A unique name for the NAT instance"
  type        = string
  default     = "eks-NAT"
}

# set ami, default use the 'Amazon Linux 2'
variable "nat_ami_id" {
  description = "ID of the AMI to use (Amazon Linux 2 AMI)"
  type        = string
  default     = "ami-0ea4d4b8dc1e46212"
}

variable "nat_rtb_id" {
  description = "ID of PVT-RTB"
  type        = string
  default     = "rtb-028c514eaa7f666ef"
}
# mfx-pvt-rtb : "rtb-028c514eaa7f666ef"

# Subnet on which the nat instance is created, your public subnet
variable "nat_subnet_id" {
  description = "ID of the subnet the instance will be created in (public subnet)"
  type        = string
  default     = "subnet-07043ee58aa8189fc"
}
# mfx-pub-2a : "subnet-07043ee58aa8189fc"
#-----------------------------------------------------------------------------

