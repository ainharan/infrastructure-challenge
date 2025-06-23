data "aws_ami" "selected" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = [var.ami_name_filter]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

module "app_vpc" {
  source = "../../modules/vpc"

  name                 = "${var.app_name}-${var.environment}"
  cidr_block           = var.vpc_cidr_block
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  environment          = var.environment
  app_name             = var.app_name
}

module "ec2_iam_role" {
  source = "../../modules/iam-ec2-role"

  environment = var.environment
  app_name    = var.app_name
}

module "app_ecr_repo" {
  source      = "../../modules/ecr-repository"
  app_name    = var.app_name
  environment = var.environment
}

module "app_server" {
  source = "../../modules/ec2-app-server"

  environment           = var.environment
  app_name              = var.app_name
  ami_id                = data.aws_ami.selected.id
  instance_type         = var.instance_type
  subnet_id             = module.app_vpc.public_subnet_ids[0]
  security_group_id     = module.app_vpc.security_group_id
  iam_instance_profile_name = module.ec2_iam_role.instance_profile_name
  ecr_repository_url    = module.app_ecr_repo.repository_url
  aws_region            = var.aws_region
  app_port              = var.app_port
  common_tags = {
    ManagedBy = "Terraform"
    Project   = "challengeapp"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = "${var.app_name}-${var.environment}-tg"
  port     = var.app_port
  protocol = "HTTP"
  vpc_id   = module.app_vpc.vpc_id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    port                = "traffic-port"
    healthy_threshold   = 3
    unhealthy_threshold = 3
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-tg"
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type = "redirect"
    redirect {
      status_code = "HTTP_301"
      protocol    = "HTTPS"
      port        = "443"
    }
  }
}

resource "aws_acm_certificate" "this" {
  domain_name       = var.domain_name
  validation_method = "DNS"

  subject_alternative_names = [
    "*.${var.domain_name}"
  ]

  lifecycle {
    create_before_destroy = true
  }

  tags = {
    Name        = "${var.app_name}-${var.environment}-cert"
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_lb" "app_lb" {
  name               = "${var.app_name}-${var.environment}-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.app_vpc.alb_security_group_id]
  subnets            = module.app_vpc.public_subnet_ids

  tags = {
    Name        = "${var.app_name}-${var.environment}-lb"
    Environment = var.environment
    Application = var.app_name
  }
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 443
  protocol          = "HTTPS"
  certificate_arn   = aws_acm_certificate_validation.this.certificate_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_tg.arn
  }

  depends_on = [aws_acm_certificate_validation.this]
}

resource "aws_lb_target_group_attachment" "app_tg_attachment" {
  target_group_arn = aws_lb_target_group.app_tg.arn
  target_id        = module.app_server.instance_id
  port             = var.app_port
}

resource "aws_route53_record" "app_www_domain" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = "www.${var.domain_name}"
  type    = "A"
  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "app_root_domain" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = var.domain_name
  type    = "A"
  alias {
    name                   = aws_lb.app_lb.dns_name
    zone_id                = aws_lb.app_lb.zone_id
    evaluate_target_health = true
  }
}

data "aws_route53_zone" "main" {
  name = "${var.domain_name}."
}

resource "aws_route53_record" "acm_validation" {
  for_each = {
    for dvo in aws_acm_certificate.this.domain_validation_options : dvo.domain_name => {
      name    = dvo.resource_record_name
      type    = dvo.resource_record_type
      records = [dvo.resource_record_value]
      ttl     = 60
    }
  }

  zone_id = data.aws_route53_zone.main.zone_id
  name    = each.value.name
  type    = each.value.type
  records = each.value.records
  ttl     = each.value.ttl
}

resource "aws_acm_certificate_validation" "this" {
  certificate_arn         = aws_acm_certificate.this.arn
  validation_record_fqdns = [for record in aws_route53_record.acm_validation : record.fqdn]
}