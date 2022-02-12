terraform {

  required_version = ">= 0.12"

}

resource "aws_lb_target_group" "alb-tg" {
  name        = "${var.alb_name}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = var.target_type
  health_check {
    path = var.health_check_path
    port = var.instance_target_port
  }
}

resource "aws_lb_target_group_attachment" "target-attach" {
  target_group_arn = aws_lb_target_group.alb-tg.arn
  target_id        = var.target_id
  port             = var.instance_target_port
}

resource "aws_lb" "app-load-balancer" {
  
  name                             = var.alb_name
  internal                         = var.is_internal
  load_balancer_type               = "application"
  security_groups                  = [aws_security_group.app-load-balancer-sg.id]
  subnets                          = var.load_balancer_subnet_ids
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing

}

resource "aws_lb_listener" "alb-listener" {

  load_balancer_arn = aws_lb.app-load-balancer.arn
  port              = 80
  protocol          = "HTTP"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}

resource "aws_security_group" "app-load-balancer-sg" {

  name        = "${var.alb_name}-lb-sg"
  description = "SG for application load balancer"
  vpc_id      = var.vpc_id
  ingress {
    description = "Exposing load balancer to the internet "
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "${var.alb_name}-lb-sg"
  }

}