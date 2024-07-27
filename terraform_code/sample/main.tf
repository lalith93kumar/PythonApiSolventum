resource "random_password" "master"{
  length           = 16
  special          = true
  override_special = "_!%^"
}

resource "aws_secretsmanager_secret" "password" {
  name = "test-db-password"
}

resource "aws_secretsmanager_secret_version" "password" {
  secret_id = aws_secretsmanager_secret.password.id
  secret_string = random_password.master.result
}

data "aws_secretsmanager_secret" "password" {
  depends_on = [ aws_secretsmanager_secret.password ]
  name = "test-db-password"
}

data "aws_secretsmanager_secret_version" "password" {
  depends_on = [ aws_secretsmanager_secret.password ]
  secret_id = data.aws_secretsmanager_secret.password.id
}