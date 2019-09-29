data "aws_secretsmanager_secret" "database_access" {
  name = "database/access"
}

data "aws_secretsmanager_secret_version" "database_access" {
  secret_id = "${data.aws_secretsmanager_secret.database_access.id}"
}