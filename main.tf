# AWS Provider Configuration
provider "aws" {
  region     = var.region
  # IMPORTANT: Hardcoding credentials is not secure for production.
  # Use environment variables or AWS credentials file for real projects.
  
}

# Terraform Provider Requirements
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  # Optional: Set remote backend (S3, etc.) for state storage in production
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "state/terraform.tfstate"
  #   region = "eu-west-3"
  # }
}

# Networking Module
module "networking" {
  source    = "./modules/networking"
  namespace = var.namespace
}

# EC2 Module
module "ec2" {
  source      = "./modules/ec2"
  namespace   = var.namespace
  vpc         = module.networking.vpc
  sg_pub_id   = module.networking.sg_pub_id
  sg_priv_id  = module.networking.sg_priv_id
  key_name    = "Datascientest"
}

# RDS Module
module "rds" {
  source      = "./modules/rds"
  namespace   = var.namespace
  vpc_id      = module.networking.vpc.vpc_id
  subnet_ids  = module.networking.vpc.private_subnets
  db_name     = "wordpress_db"
  db_username = "datascientest-student"
  db_password = "Datascientest@2024"
}


module "ebs" {
  source             = "./modules/ebs"
  namespace          = var.namespace
  availability_zone  = module.ec2.ec2_public_az
  size               = 10
  type               = "gp2"
}
resource "aws_volume_attachment" "ebs_attach" {
  device_name = "/dev/sdh"
  volume_id   = module.ebs.volume_id
  instance_id = module.ec2.ec2_public_id
}

