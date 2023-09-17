variable "leftid" {
  description = "Left ID"
  type        = string
}

variable "right1" {
  description = "Right IP for Tunnel1"
  type        = string
}

variable "right2" {
  description = "Right IP for Tunnel2"
  type        = string
}

variable "leftsubnet" {
  description = "Left Subnet"
  type        = string
}

variable "rightsubnet1" {
  description = "Right Subnet for Tunnel1"
  type        = string
}

variable "rightsubnet2" {
  description = "Right Subnet for Tunnel2"
  type        = string
}

variable "psk1" {
  description = "Pre-shared key for Tunnel1"
  type        = string
}

variable "psk2" {
  description = "Pre-shared key for Tunnel2"
  type        = string
}
