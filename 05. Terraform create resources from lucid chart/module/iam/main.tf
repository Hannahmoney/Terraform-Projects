# 17 iam role for ec2 to assume to connect or make ip calls to ssm
resource "aws_iam_role" "ec2" {
  name = "${var.stack_name}-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "role-ec2"
  }
}

# 18 attch ssm policy to iam role
resource "aws_iam_role_policy_attachment" "ssm" {
  role       = aws_iam_role.ec2.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

# 19 instance profile for ec2 to use the iam role
resource "aws_iam_instance_profile" "ec2" {
  name = "${var.stack_name}-ec2-instance-profile"
  role = aws_iam_role.ec2.name
}
