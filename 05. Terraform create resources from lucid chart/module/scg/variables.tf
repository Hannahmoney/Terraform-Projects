variable "vpc_id" {
  type = string
}

variable "alb_sg_name" {
  type    = string
  default = "alb-sg"
}

variable "ec2_sg_name" {
  type    = string
  default = "ec2-sg"
}