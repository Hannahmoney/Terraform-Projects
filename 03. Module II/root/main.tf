provider "aws" {
    region = "us-east-1"
  
}

module "s3_bucket" {
  source      = "../modules/s3"
  bucket_name_child = var.bucket_name_root
  bucket_name_child2 = var.bucket_name_root2

}

# module "instance" {
#   source      = "./modules/ec2"
#   instance_type = var.instance_type
#   ami_id        = var.ami_id
  
# }