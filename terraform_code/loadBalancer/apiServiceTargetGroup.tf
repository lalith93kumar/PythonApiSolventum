resource "aws_alb_target_group" "apiServiceTargetGroup" {
  name        = "${var.clusterName}-apiServiceTargetGroup"
  port        = 5000
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  tags = {
    Environment = var.clusterName
  }

  health_check {
    protocol = "HTTP"
    port     = 5000
  }
}