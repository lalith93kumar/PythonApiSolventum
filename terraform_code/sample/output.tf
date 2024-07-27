output "test" {
  value = data.aws_secretsmanager_secret_version.password
   sensitive = true
}