resource "aws_appautoscaling_target" "apiServiceAutoscalingTarget" {
  max_capacity = 5
  min_capacity = 1
  resource_id = "service/${var.clusterName}/${var.serviceName}"
  scalable_dimension = "ecs:service:DesiredCount"
  service_namespace = "ecs"
}

resource "aws_appautoscaling_policy" "apiServiceAutoscalingByMemory" {
  name               = join("-", [var.clusterName,"apiServiceAutoscalingByMemory",replace(var.repositoryName,".","-")])
  policy_type        = "TargetTrackingScaling"
  resource_id        = aws_appautoscaling_target.apiServiceAutoscalingTarget.resource_id
  scalable_dimension = aws_appautoscaling_target.apiServiceAutoscalingTarget.scalable_dimension
  service_namespace  = aws_appautoscaling_target.apiServiceAutoscalingTarget.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageMemoryUtilization"
    }

    target_value       = 80
  }
}

resource "aws_appautoscaling_policy" "apiServiceAutoscalingByCPU" {
  name = join("-", [var.clusterName,"apiServiceAutoscalingByCPU",replace(var.repositoryName,".","-")])
  policy_type = "TargetTrackingScaling"
  resource_id = aws_appautoscaling_target.apiServiceAutoscalingTarget.resource_id
  scalable_dimension = aws_appautoscaling_target.apiServiceAutoscalingTarget.scalable_dimension
  service_namespace = aws_appautoscaling_target.apiServiceAutoscalingTarget.service_namespace

  target_tracking_scaling_policy_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ECSServiceAverageCPUUtilization"
    }

    target_value = 60
  }
}