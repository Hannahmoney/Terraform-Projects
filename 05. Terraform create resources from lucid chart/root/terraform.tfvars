region = "us-east-1"

# vpc
vpc_cidr = "172.16.0.0/16"
public_subnet_a_cidr = "172.16.0.0/24"  
public_subnet_b_cidr = "172.16.1.0/24"
private_subnet_a_cidr = "172.16.2.0/24"
private_subnet_b_cidr = "172.16.3.0/24"

# IAM
stack_name = "lucid-terraform-user"

# alb
alb_name = "lucid-alb"
alb_tg_name = "lucid-alb-tg"

# EC2/asg
name_prefix = "lucid-ec2"
instance_type = "t2.micro"
ami_id = "ami-0ff8a91507f77f867" 



# S3
bucket_name = "lucid-terraform-bucket-1234567890"


