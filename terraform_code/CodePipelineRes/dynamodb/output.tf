output "terraformLockDynmodbARN" {
  value = data.aws_dynamodb_table.tableName.arn
}