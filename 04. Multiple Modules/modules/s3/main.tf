# Module with 2 resources 
resource "aws_s3_bucket" "thebucket" {
  bucket = var.bucket_name

  tags = {
    Name = "thebucket"
  }
}