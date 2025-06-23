output "role_arn" {
  description = "The ARN of the EC2 IAM role."
  value       = aws_iam_role.this.arn
}

output "instance_profile_name" {
  description = "The name of the EC2 instance profile."
  value       = aws_iam_instance_profile.this.name
}