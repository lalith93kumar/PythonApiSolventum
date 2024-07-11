resource "aws_lb" "applicationLoadBalancer" {
  load_balancer_type = "application"
  name = "${var.clusterName}-applicationLoadBalancer"
  internal = false
  subnets            = var.public_subnet_ids
  security_groups    = [var.security_group_ids]
    tags = {
        Environment = var.clusterName
    }
}