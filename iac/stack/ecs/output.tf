output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.app.dns_name
}

output "alb_arn" {
  description = "The ARN of the load balancer"
  value       = aws_lb.app.arn
}

output "target_group_port" {
  description = "The port the target group forwards traffic to"
  value       = aws_lb_target_group.app.port
}
