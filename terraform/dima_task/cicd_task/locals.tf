locals {
  name_prefix = "cicd-task"
  bucket      = "${local.name_prefix}-bucket"
  secret      = "${local.name_prefix}-secret"
}

locals {
  secret_data = {
    for entry in var.secret_data :
    entry.name => entry.value
  }
  code_build_app_environment_vars_secrets_manager = flatten([
    {
      keys = keys(local.secret_data)
      arn  = aws_secretsmanager_secret.this.arn
      kms  = try(aws_secretsmanager_secret.this.kms_key_id, null)
    },
    [
      for secret in var.code_build_app_environment_extra_secrets :
      {
        keys = secret.keys
        arn  = secret.arn
        kms  = secret.kms
      }
    ]
  ])
}

