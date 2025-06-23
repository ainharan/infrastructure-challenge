output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = module.app_ecr_repo.repository_url
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer."
  value       = aws_lb.app_lb.dns_name
}