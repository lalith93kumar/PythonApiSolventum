data "aws_dynamodb_table" "tableName" {
  name = "terraform-ecs-state"
}