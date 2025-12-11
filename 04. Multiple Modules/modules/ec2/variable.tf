variable "public_key_path" {
  description = "path to public key file"
  type = string
}

variable "instance_type" {
  description = "EC2 Instance Type"
  type        = string
  
}

variable "ami_id" {
  description = "AMI ID for the EC2 Instance"
  type        = string
  
}

variable "thepublicsubnet_id" {
    description = "Public Subnet ID where the EC2 Instance will be launched"
    type        = string
}

variable "security_group_id" {
  description = "id of sec grop to attach to ec2"
}