variable "myIP" {
  description = "myIP"
  type        = string
  default     = "127.0.0.1"
}

variable "allowed_ips_file" {
  description = "allowed_ips"
  type        = string
  default     = "/etc/squid/allowed_ips.txt"
}

variable "target_conf_file" {
  description = "squid conf file location"
  type        = string
  default     = "/etc/squid/squid.conf"
}
