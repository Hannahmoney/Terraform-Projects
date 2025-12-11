provider "aws" {
    region = "us-east-1"
  
}

module "s3_bucket" {
  source      = "./modules"
  bucket_name = "my-unique-bucket-name-12345x"
  instance_type = "t2.micro"
  ami_id        = "ami-0fa3fe0fa7920f68e" 
}

