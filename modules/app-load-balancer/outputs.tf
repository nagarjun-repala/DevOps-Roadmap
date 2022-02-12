output "lb_sg_id" {
    value = aws_security_group.app-load-balancer-sg.id
}

output "endpoint" {
    value = aws_lb.app-load-balancer.dns_name
  
}