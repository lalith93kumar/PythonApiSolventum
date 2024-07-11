output "application_lb_arn" {
  value = aws_lb.applicationLoadBalancer.arn
  description = "cluster ID"
}

output "api_lb_listener" {
  value = aws_alb_listener.api_service_listener
  description = "cluster ID"
}

output "api_lb_target_group_arn" {
  value = aws_alb_target_group.apiServiceTargetGroup.arn
  description = "cluster ID"
}