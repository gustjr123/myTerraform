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
}

# your cidr of vpc
variable "vpc_cidr_ipv4" {
  description = "VPC CIDR (IPV4)"
  type        = string
}

# Subnet on which the nat instance is created, your public subnet
variable "subnet_id" {
  description = "ID of the subnet the instance will be created in (public subnet)"
  type        = string
}

# private subnet to be associated with a nat instance
variable "pvt_subnet_ids" {
  description = "ID of the subnet (private subnet)"
  type        = list(string)
}

# set ssh key name, tag name
variable "ssh_key" {
  description = "Name of the SSH key for the NAT instance"
  type        = string
}
