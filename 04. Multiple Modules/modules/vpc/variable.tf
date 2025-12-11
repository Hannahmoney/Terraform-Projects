# This list all the vpc variables, cidr, subnet cidr
variable "thevpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
#   default     = "10.0.0.0/16"
}

variable "thepublicsubnet_cidr" {
  description = "CIDR block for the public subnet"
  type        = string
#   default     = "0.0.0.0/24"
}