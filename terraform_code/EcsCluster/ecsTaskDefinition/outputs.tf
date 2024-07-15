output "api_task_definition_arn" {
  value = aws_ecs_task_definition.apiTaskDefinition.arn
  description = "Api Task Definition ID Flask APP"
}