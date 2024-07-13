resource "aws_ecs_service" "apiService" {
  name            = join("-", [var.clusterName,"apiService",replace(var.repositoryVersion,".","-")])
  cluster         = var.clusterId
  task_definition = var.api_task_definition_id
  desired_count   = "1"
  depends_on = [var.application_lb_arn]
  launch_type     = "FARGATE"
  deployment_maximum_percent = 200
  deployment_minimum_healthy_percent = 100
  propagate_tags = "SERVICE"
  scheduling_strategy = "REPLICA"
  platform_version = "1.4.0"
  deployment_controller {
    type = "ECS"
  }
  network_configuration {
    security_groups = [var.application_security_group_ids]
    subnets         = var.private_subnet_ids
    assign_public_ip = true
  }

  load_balancer {
    target_group_arn = var.api_lb_target_group_arn
    container_name   = "apiService"
    container_port   = 5000
  }
  tags = {
        Environment = var.clusterName
        serviceVersion= var.repositoryVersion
  }
}