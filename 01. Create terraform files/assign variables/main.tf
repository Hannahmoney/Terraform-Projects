
# Define an EC2 instance resource
resource "aws_instance" "examples" {
  ami           = var.ami  # Example AMI ID for Amazon Linux 2
  instance_type = var.instance_type

  tags = {
    Name = "TerraformExampleInstancez"
  }
}
