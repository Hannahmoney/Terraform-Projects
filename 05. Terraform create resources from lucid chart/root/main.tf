provider "aws" {
  region = var.region
}

# VPC
module "vpc" {
  source = "../module/vpc"
  
  vpc_cidr               = var.vpc_cidr
  public_subnet_a_cidr   = var.public_subnet_a_cidr
  public_subnet_b_cidr   = var.public_subnet_b_cidr
  private_subnet_a_cidr  = var.private_subnet_a_cidr
  private_subnet_b_cidr  = var.private_subnet_b_cidr
}

# Security Groups
module "scg" {
  source = "../module/scg"
  vpc_id = module.vpc.vpc_id
}

# IAM
module "iam" {
  source = "../module/iam"
  stack_name = var.stack_name
}

# ALB
module "alb" {
  source = "../module/alb"
  vpc_id               = module.vpc.vpc_id
  public_subnets_ids   = module.vpc.public_subnets_ids
  alb_sg_id            = module.scg.alb_sg_id
  alb_name             = var.alb_name
  alb_tg_name          = var.alb_tg_name
} 

# ec2/asg
module "ec2" {
  source = "../module/ec2"
  private_subnets_ids    = module.vpc.private_subnets_ids
  ec2_sg_id              = module.scg.ec2_sg_id
  name_prefix = var.name_prefix
  instance_profile_arn = module.iam.instance_profile_arn
  instance_type = var.instance_type
  ami_id = var.ami_id
  key_name = var.key_name
  target_group_arns     = [module.alb.target_group_arn]
}

# S3
module "s3" {
  source = "../module/s3"
  bucket_name = var.bucket_name
  
} 

