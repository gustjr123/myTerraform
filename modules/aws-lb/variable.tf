# set instance name
variable "tg-name" {
  description = "Name of Target group"
  type        = string
  default     = "default-TG"
}

variable "lb-name" {
  description = "Name of Load Balancer"
  type        = string
  default     = "default-LB"
}

variable "lb-type" {
  description = "Type of Load Balancer"
  type        = string
  default     = "application"
}

variable "existing_instance_ids" {
  description = "Existing instance IDs"
  type        = list(string)
  default     = []
}

# ==================================

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "lb-vpc_subnet_ids" {
  description = "VPC Subnet IDs of Load Balancer"
  type        = list(string)
}

variable "security_groups" {
  description = "Security groups"
  type        = list(string)
}
