resource "aws_ecr_repository" "this" {
  name                 = "${var.app_name}-${var.environment}"
  image_tag_mutability = var.image_tag_mutability # MUTABLE for dev, IMMUTABLE for prod

  force_delete = true

  image_scanning_configuration {
    scan_on_push = true
  }
}