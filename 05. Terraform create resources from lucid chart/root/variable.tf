variable "region" {
  type = string
}

# vpc
variable "vpc_cidr" {
  type    = string
  default = "172.16.0.0/16"
}

# public subnet a
variable "public_subnet_a_cidr" {
  type    = string
}   

# public subnet b
variable "public_subnet_b_cidr" {
  type    = string
}   

# private subnet a
variable "private_subnet_a_cidr" {  
  type    = string
}

# private subnet b
variable "private_subnet_b_cidr" {
  type    = string
}   

# IAM
variable "stack_name" {
  type    = string
  # default = "lucid-terraform-stack"
}

# alb
variable "alb_name" {
  type    = string
  # default = "lucid-alb"
}

variable "alb_tg_name" {
  type    = string
  # default = "lucid-alb-tg"
  
}

# EC2/asg
variable "name_prefix" {
  type    = string
  # default = "lucid-ec2"
}

variable "instance_type" {
  type    = string
  # default = "t2.micro"
}

variable "ami_id" {
  type    = string
  # default = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI (HVM), SSD Volume Type
}

variable "key_name" {
  type    = string
  # default = "lucid-ec2-keypair"
}

# S3
variable "bucket_name" {
  type    = string
  # default = "lucid-terraform-bucket-123456"
}