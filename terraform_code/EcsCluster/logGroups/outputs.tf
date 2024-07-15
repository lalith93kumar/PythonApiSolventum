output "log_groups_arn" {
  value = aws_cloudwatch_log_group.log_name.arn
  description = "Cloud Watch log group ARN"
}