variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
  
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
  
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  
}