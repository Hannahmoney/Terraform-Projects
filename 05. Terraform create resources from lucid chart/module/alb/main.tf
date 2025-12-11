# 20 create alb resource
resource "aws_lb" "alb" {
    name               = var.alb_name
    internal           = false
    load_balancer_type = "application"
    ip_address_type    = "ipv4"
    security_groups    = [var.alb_sg_id]
    subnets            = var.public_subnets_ids
    
    tags = {
        Name = "app-alb"
    }
}

#21 create traget groups for alb
resource "aws_lb_target_group" "alb_tg" {
    name     = var.alb_tg_name
    port     = 80
    protocol = "HTTP"
    vpc_id   = var.vpc_id
    target_type = "instance"

    tags = {
        Name = "app-alb-tg"
    }
}

# 22 create listener for alb binding alb to target group
resource "aws_lb_listener" "alb_listener" {
    load_balancer_arn = aws_lb.alb.arn
    port              = "80"
    protocol          = "HTTP"

    default_action {
        type             = "forward"
        target_group_arn = aws_lb_target_group.alb_tg.arn
    }
}
