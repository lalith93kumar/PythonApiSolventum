resource "aws_cloudwatch_log_group" "log_name" {
  name = "/log/${var.clusterName}"
  tags = {
    Environment = var.clusterName
  }
}