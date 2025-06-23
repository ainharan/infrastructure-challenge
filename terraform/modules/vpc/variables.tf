variable "name" {
  description = "A unique name for the VPC, used in resource naming."
  type        = string
}

variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
  default     = []
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-southeast-2"
}

variable "azs" {
  description = "List of availability zone suffixes to use (e.g., ['a', 'b'])."
  type        = list(string)
  default     = ["a", "b", "c"] # Use up to 3 AZs by default
}

variable "app_port" {
  description = "The main port your application listens on, for SG ingress."
  type        = number
  default     = 80
}