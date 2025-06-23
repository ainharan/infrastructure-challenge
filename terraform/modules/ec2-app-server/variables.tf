
variable "app_name" {
  description = "The name of the application."
  type        = string
}

variable "environment" {
  description = "The deployment environment (e.g., dev, prod)."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the application server."
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet where the EC2 instance will be launched."
  type        = string
}

variable "security_group_id" {
  description = "The ID of the security group to associate with the EC2 instance."
  type        = string
}

variable "iam_instance_profile_name" {
  description = "The name of the IAM instance profile to attach to the EC2 instance."
  type        = string
}

variable "ecr_repository_url" {
  description = "The URL of the ECR repository to pull Docker images from."
  type        = string
}

variable "app_port" {
  description = "The port the application listens on inside the container."
  type        = number
}

variable "aws_region" {
  description = "The AWS region where the EC2 instance is deployed."
  type        = string
}

variable "key_name" {
  description = "The name of the SSH key pair to use for the EC2 instance."
  type        = string
  default     = null
}

variable "image_tag" {
  description = "The specific tag of the Docker image to deploy (e.g., latest, v1.0.0, or a full digest)."
  type        = string
  default     = "latest"
}

variable "common_tags" {
  description = "A map of common tags to apply to all resources."
  type        = map(string)
  default     = {}
}

variable "key_pair_name" {
  description = "The name of the SSH key pair to use for the EC2 instance."
  type        = string
  default     = null
}

