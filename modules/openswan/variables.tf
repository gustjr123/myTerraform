variable "leftid" {
  description = "Left ID"
  type        = string
  default     = "106.253.56.124"
}

variable "right1" {
  description = "Right IP for Tunnel1"
  type        = string
  default     = "3.34.151.216"
}

variable "right2" {
  description = "Right IP for Tunnel2"
  type        = string
  default     = "15.165.192.64"
}

variable "leftsubnet" {
  description = "Left Subnet"
  type        = string
  default     = "192.168.0.0/21"
}

variable "rightsubnet1" {
  description = "Right Subnet for Tunnel1"
  type        = string
  default     = "10.4.0.0/16"
}

variable "rightsubnet2" {
  description = "Right Subnet for Tunnel2"
  type        = string
  default     = "10.4.0.0/16"
}

variable "psk1" {
  description = "Pre-shared key for Tunnel1"
  type        = string
  default     = "<key값>"
}

variable "psk2" {
  description = "Pre-shared key for Tunnel2"
  type        = string
  default     = "<key값>"
}
