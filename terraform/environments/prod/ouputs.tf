output "ecr_repository_url" {
  description = "The URL of the ECR repository."
  value       = module.app_ecr_repo.repository_url
}

output "app_server_elastic_ip" {
  description = "The Elastic IP address of the application server."
  value       = module.app_server.eip_public_ip
}

output "app_server_elastic_ip_allocation_id" {
  description = "The allocation ID of the Elastic IP address of the application server."
  value       = module.app_server.eip_allocation_id
}