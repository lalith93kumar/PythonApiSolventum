output "api_task_definition_arn" {
  value = aws_ecs_task_definition.apiTaskDefinition.arn
  description = "security group ID"
}