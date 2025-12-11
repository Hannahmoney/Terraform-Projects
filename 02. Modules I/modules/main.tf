resource "aws_s3_bucket" "newsbucket" {
  bucket = var.bucket_name

}

resource "aws_instance" "aninastance" {
  instance_type = var.instance_type
  ami           = var.ami_id # Example AMI ID for us-east-1

}

