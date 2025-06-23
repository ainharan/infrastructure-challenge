resource "aws_iam_role" "this" {
  name = "${var.app_name}-${var.environment}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })

  tags = {
    Name        = "${var.app_name}-${var.environment}-ec2-role"
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_iam_role_policy_attachment" "ecr_readonly" {
  role       = aws_iam_role.this.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

# Attach any additional policies
resource "aws_iam_role_policy_attachment" "additional_policies" {
  count      = length(var.additional_policy_arns)
  role       = aws_iam_role.this.name
  policy_arn = var.additional_policy_arns[count.index]
}

resource "aws_iam_instance_profile" "this" {
  name = "${var.app_name}-${var.environment}-ec2-profile"
  role = aws_iam_role.this.name

  tags = {
    Name        = "${var.app_name}-${var.environment}-ec2-profile"
    Environment = var.environment
    Application = var.app_name
  }
}