output "public_ip" {
  description = "The public IP address of the EC2 instance."
  value       = aws_instance.this.public_ip
}

output "instance_id" {
  description = "The ID of the EC2 instance."
  value       = aws_instance.this.id
}

output "eip_public_ip" {
  description = "The public IP address of the EC2 instance via Elastic IP."
  value       = aws_eip.app_server_eip.public_ip
}

output "eip_allocation_id" {
  description = "The allocation ID of the Elastic IP."
  value       = aws_eip.app_server_eip.id
}