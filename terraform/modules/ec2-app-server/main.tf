resource "aws_instance" "this" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = false
  iam_instance_profile        = var.iam_instance_profile_name
  key_name                    = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    sudo yum update -y
    sudo yum install -y docker
    sudo service docker start
    sudo usermod -a -G docker ec2-user

    # Login to ECR
    aws ecr get-login-password --region ${var.aws_region} | docker login --username AWS --password-stdin ${var.ecr_repository_url}

    # Pull and run your Docker image using the specific tag
    docker pull ${var.ecr_repository_url}:${var.image_tag}
    docker stop $(docker ps -aq --filter "ancestor=${var.ecr_repository_url}:${var.image_tag}") || true # Stop any existing container if it's running
    docker rm $(docker ps -aq --filter "ancestor=${var.ecr_repository_url}:${var.image_tag}") || true # Remove any existing container
    docker run -d -p ${var.app_port}:${var.app_port} ${var.ecr_repository_url}:${var.image_tag}
  EOF

  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.app_name}-app-server"
    }
  )
}

resource "aws_eip" "app_server_eip" {
  tags = merge(
    var.common_tags,
    {
      Name = "${var.environment}-${var.app_name}-app-server-eip"
    }
  )
}

resource "aws_eip_association" "app_server_eip_assoc" {
  instance_id   = aws_instance.this.id
  allocation_id = aws_eip.app_server_eip.id

  depends_on = [
    aws_instance.this
  ]
}
