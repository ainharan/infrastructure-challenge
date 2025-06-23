variable "environment" {
  description = "The deployment environment (e.g., dev, prod, staging)."
  type        = string
}

variable "state_bucket_name" {
  description = "Name of the S3 bucket to store Terraform state."
  type        = string
}

variable "app_name" {
  description = "Name of the application."
  type        = string
}

variable "aws_region" {
  description = "The AWS region to deploy resources into."
  type        = string
  default     = "ap-southeast-2"
}

variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnet_cidrs" {
  description = "List of CIDR blocks for public subnets."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "List of CIDR blocks for private subnets."
  type        = list(string)
}

variable "instance_type" {
  description = "EC2 instance type for the application server."
  type        = string
}

variable "ami_name_filter" {
  description = "Filter for finding the latest AMI (e.g., Amazon Linux 2)."
  type        = string
}

variable "app_port" {
  description = "Port the application listens on inside the container."
  type        = number
}

variable "domain_name" {
  description = "The main domain name for the application."
  type        = string
}

variable "route53_zone_id" {
  description = "The Route 53 Hosted Zone ID for the domain."
  type        = string
}

variable "additional_domain_names" {
  description = "A list of additional domain names to include in the ACM certificate (e.g., wildcard)."
  type        = list(string)
  default     = []
}