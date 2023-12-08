locals {
  name_prefix = "cicd-task"
  bucket      = "${local.name_prefix}-bucket"
  secret      = "${local.name_prefix}-secret"
  ecr                              = "${local.name_prefix}-repository"
  ecr_url                          = "${data.aws_caller_identity.this.account_id}.dkr.ecr.${data.aws_region.this.name}.amazonaws.com"
}


locals {
  s3 = {
    sse_algorithm    = var.s3_sse_kms_key_id != null ? "aws:kms" : var.s3_sse_algorithm
    encrypted        = var.s3_sse_kms_key_id != null ? true : false
    create_sse_block = var.s3_sse_algorithm != null ? true : false
    tags = merge(
      {
        "Name" = local.bucket
      },
      var.s3_tags
    )
  }
}

locals {
  ecr_tags = merge(
    {
      "Name" = local.ecr
    },
    var.ecr_tags
  )
}
# locals {
#   secret_data = {
#     for entry in var.secret_data :
#     entry.name => entry.value
#   }
#   code_build_app_environment_vars_secrets_manager = flatten([
#     {
#       keys = keys(local.secret_data)
#       arn  = aws_secretsmanager_secret.this.arn
#       kms  = try(aws_secretsmanager_secret.this.kms_key_id, null)
#     },
#     [
#       for secret in var.code_build_app_environment_extra_secrets :
#       {
#         keys = secret.keys
#         arn  = secret.arn
#         kms  = secret.kms
#       }
#     ]
#   ])
# }

