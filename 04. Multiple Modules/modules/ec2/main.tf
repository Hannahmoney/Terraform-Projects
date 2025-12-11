# Module with 2 resources
#7 Define key pairs
resource "aws_key_pair" "sshkeyp" {
  key_name   = "myssh-key"
  public_key = file(var.public_key_path)
}

#8 Creatin ec2 instance module
resource "aws_instance" "theinstance" {
    ami           = var.ami_id
    instance_type = var.instance_type
    subnet_id     = var.thepublicsubnet_id
    vpc_security_group_ids = [var.security_group_id]
    key_name = aws_key_pair.sshkeyp.key_name

    associate_public_ip_address = true

    tags = {
        Name = "theinstance"
    }
  
}

