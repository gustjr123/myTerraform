variable "cgwIP" {
  description = "customer gateway of public ip (IPv4)"
  type        = string

  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.cgwIP))
    error_message = "Input is not a valid IPv4 address."
  }
}

variable "cgwASN" {
  description = "customer gateway of BGP ASN"
  type        = number
  default     = 65000

  validation {
    condition     = var.cgwASN >= 1 && var.cgwASN <= 2147483647
    error_message = "BGP ASN must be a number between 1 and 2147483647."
  }
}

# ------------------------------------------------------------------------

variable "attachVpcId" {
  description = "vpc id for attachment"
  type        = string
}

variable "attachVpcSubnetIds" {
  description = "vpc subnet list for attachment"
  type        = list(string)
}

# ------------------------------------------------------------------------

variable "rtbId" {
  description = "your rtb for updating"
  type        = string
}

variable "destinationCIDR" {
  description = "destination cidr (customer private network cidr)"
  type        = string
}

# ------------------------------------------------------------------------

variable "cgwTagName" {
  description = "customer gateway of Tag name"
  type        = string
  default     = "myCGW"
}

variable "cgwType" {
  description = "customer gateway of Type"
  type        = string
  default     = "ipsec.1"
}

variable "vpnConnTagName" {
  description = "vpn connection of Tag Name"
  type        = string
  default     = "vpn_attach"
}

variable "vpcAttachTagName" {
  description = "tgw to vpc Attachment of Tag Name"
  type        = string
  default     = "tgw_vpc"
}
