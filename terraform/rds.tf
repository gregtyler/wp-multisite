resource "aws_rds_cluster" "wordpress" {
  cluster_identifier  = "wordpress"
  engine              = "aurora"
  engine_version      = "5.6.10a"
  engine_mode         = "serverless"
  database_name       = "wordpress"
  master_username     = jsondecode(data.aws_secretsmanager_secret_version.database_access.secret_string)["username"]
  master_password     = jsondecode(data.aws_secretsmanager_secret_version.database_access.secret_string)["password"]
  skip_final_snapshot = true
  deletion_protection = true

  scaling_configuration {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 1
    seconds_until_auto_pause = 300
    timeout_action           = "RollbackCapacityChange"
  }
}
