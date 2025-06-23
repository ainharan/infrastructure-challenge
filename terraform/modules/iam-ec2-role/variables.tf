variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "additional_policy_arns" {
  description = "List of additional IAM policy ARNs to attach to the EC2 role."
  type        = list(string)
  default     = []
}
