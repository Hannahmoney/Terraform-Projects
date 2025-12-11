# 23 ec launch template
resource "aws_launch_template" "ec2_launch_template" {
  name_prefix = var.name_prefix
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_name
  
  vpc_security_group_ids               = [var.ec2_sg_id]
  
  iam_instance_profile {
    arn = var.instance_profile_arn
  }


  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "ec2-instance"
    }
  }
}

# 24 create asg for the ec2 instances that will be spun from the launch template
resource "aws_autoscaling_group" "ec2_asg" {
  desired_capacity     = 1
  max_size             = 5
  min_size             = 1
  vpc_zone_identifier  = var.private_subnets_ids
  launch_template {
    id      = aws_launch_template.ec2_launch_template.id
    version = "$Latest"
  }

  target_group_arns = var.target_group_arns
  
    lifecycle {
    create_before_destroy = true
  }
}