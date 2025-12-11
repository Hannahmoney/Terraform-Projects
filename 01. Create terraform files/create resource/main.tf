
# Define an EC2 instance resource
resource "aws_instance" "examples" {
  ami           = "ami-0fa3fe0fa7920f68e"  # Example AMI ID for Amazon Linux 2
  instance_type = "t2.micro"

  tags = {
    Name = "TerraformExampleInstancez"
  }
}
