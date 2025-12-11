resource "aws_s3_bucket" "newsbucket" {
  bucket = var.bucket_name_child

}

resource "aws_s3_bucket" "newsbucg" {
  bucket = var.bucket_name_child2

}