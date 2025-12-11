variable "name_prefix" {
  type = string
}

variable "ami_id" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "key_name" {
  type = string
}

variable "ec2_sg_id" {
  type = string
}

variable "instance_profile_arn" {
  type = string
}

variable "private_subnets_ids" {
  type = list(string)
}

variable "target_group_arns" {
  type = list(string)
}

 