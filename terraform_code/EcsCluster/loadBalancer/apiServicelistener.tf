resource "aws_alb_listener" "api_service_listener" {
  load_balancer_arn = aws_lb.applicationLoadBalancer.arn
  port              = 5000
  protocol          = "HTTP"

  default_action {
    type = "forward"
    forward {
        target_group {
          arn = aws_alb_target_group.apiServiceTargetGroup.arn
          weight = 1
        }
    }
  }
  tags = {
    Environment = var.clusterName
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.applicationLoadBalancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "5000"
      protocol    = "HTTP"
      status_code = "HTTP_301"
    }
  }
}
