# -------------------- ------------------ ---------------------

# set instance name
variable "name" {
  description = "A unique name for the NAT instance"
  type        = string
  default     = "nat-instance"
}

# set ami, default use the 'Amazon Linux 2' 
variable "ami_id" {
  description = "ID of the AMI to use (Amazon Linux 2 AMI)"
  type        = string
  default     = "ami-0ea4d4b8dc1e46212"
}

# -------------------- Need to set follows ---------------------

# your vpc id
variable "vpc_id" {
  description = "ID of the VPC the NAT instance will be created in (vpc id)"
  type        = string
  default     = "vpc-010c17f3908d854a2"
}

# your cidr of vpc
variable "vpc_cidr_ipv4" {
  description = "VPC CIDR (IPV4)"
  type        = string
  default     = "10.0.0.0/16"
}

# Subnet on which the nat instance is created, your public subnet
variable "subnet_id" {
  description = "ID of the subnet the instance will be created in (public subnet)"
  type        = string
  default     = "subnet-029458fbf69cd0184"
}

# private subnet to be associated with a nat instance
variable "pvt_subnet_ids" {
  description = "ID of the subnet (private subnet)"
  type        = list(string)
  default     = ["subnet-0ec2abc8782992df4", "subnet-044e00cc2601039ba"]
}

# set ssh key name, tag name
variable "ssh_key" {
  description = "Name of the SSH key for the NAT instance"
  type        = string
}
