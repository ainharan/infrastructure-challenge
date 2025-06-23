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
