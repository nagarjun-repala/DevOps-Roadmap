output "secrets_manager_arn" {
    value = aws_secretsmanager_secret_version.db-secrets-manager.arn
  
}