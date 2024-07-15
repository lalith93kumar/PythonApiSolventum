output "application_lb_arn" {
  value = aws_lb.applicationLoadBalancer.arn
  description = "Applictaion Load Balancer ARN"
}

output "api_lb_listener" {
  value = aws_alb_listener.apiServiceListener
  description = "Applictaion Load Balancer Listener"
}

output "api_lb_target_group_arn" {
  value = aws_alb_target_group.apiServiceTargetGroup.arn
  description = "Applictaion Load Balancer Target Group ARN"
}