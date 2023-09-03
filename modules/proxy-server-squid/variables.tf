variable "IP" {
  description = "access IP"
  type        = string
  default     = "127.0.0.1"

  validation {
    condition     = can(regex("^((25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.){3}(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.IP))
    error_message = "Input is not a valid IPv4 address."
  }
}

variable "user" {
  description = "access Account user"
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.user))
    error_message = "Invalid input. Only lowercase letters and numbers are allowed."
  }
}

variable "password" {
  description = "access Account password"
  type        = string
  default     = "default"

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.password))
    error_message = "Invalid input. Only lowercase letters and numbers are allowed."
  }
}

