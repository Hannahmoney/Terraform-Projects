# vpc variables
variable "vpc_cidrz" {
  description = "VPC CIDR "
}

variable "public_subnet_cidrz" {
  description = "Public Subnet CIDR "
}


# ec2 variables
variable "public_key_pathz" {
  description = "path to public key file"
  type = string
}

variable "instance_typez" {
  description = "EC2 Instance Type"
  type        = string
  
}

variable "ami_idz" {
  description = "AMI ID for the EC2 Instance"
  type        = string
  
}

variable "bucket_namez" { 
  description = "Name of the S3 bucket"
  type        = string
  
}