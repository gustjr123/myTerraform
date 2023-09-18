variable "iam_policy_name" {
  description = "AWS IAM Policy name"
  type        = string
}

variable "iam_role_name" {
  description = "AWS IAM Role name"
  type        = string
}

variable "custom_policy_json_path" {
  description = "Path to custom JSON policy file"
  type        = string
}

variable "role_trust_policy_json_path" {
  description = "Path to custom JSON role trust policy file"
  type        = string
}

# Optional
variable "policy_description" {
  description = "AWS IAM policy description"
  type        = string
  default     = "User Custom IAM Created"
}

# Optional
variable "role_description" {
  description = "AWS IAM role description"
  type        = string
  default     = "User Custom IAM Created"
}
