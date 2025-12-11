provider "aws" {
    region = "us-east-1"
  
}

# Vpc module
module "vpc" {
  source = "../modules/vpc"
  thevpc_cidr = var.vpc_cidrz
  thepublicsubnet_cidr = var.public_subnet_cidrz
}

# Security group module
module "sec-grp" {
  source = "../modules/sec-grp"
  thevpc_id = module.vpc.thevpc_id
}

# EC2 instance module
module "ec2" {
  source = "../modules/ec2"
  ami_id = var.ami_idz
  instance_type = var.instance_typez
  thepublicsubnet_id = module.vpc.publicsubnet_id
  security_group_id = module.sec-grp.secgrp_id
  public_key_path = var.public_key_pathz

}

# S3 bucket module
module "s3" {
  source = "../modules/s3"
  bucket_name = var.bucket_namez
}


