locals {
  bucket                              = "${var.name_prefix}-artifact-bucket"
  code_build_project                  = "${var.name_prefix}-code-build"
  code_build_sg                       = "${local.code_build_project}-sg"
  code_build_cloudwatch_log_group     = "${local.code_build_project}-log"
  code_build_iam_role                 = "${local.code_build_project}-role"
  code_build_iam_secret_policy        = "${local.code_build_project}-secret-policy"
  code_build_iam_cloudwatch_policy    = "${local.code_build_project}-cloudwatch-policy"
  code_build_iam_artifact_policy      = "${local.code_build_project}-artifact-policy"
  code_build_iam_vpc_policy           = "${local.code_build_project}-vpc-policy"
  code_build_iam_external_policy      = "${local.code_build_project}-external-policy"
  code_build_iam_lambda_update_policy = "${local.code_build_project}-lambda-updating-policy"

  code_pipeline_project             = "${var.name_prefix}-code-pipeline"
  code_pipeline_iam_role            = "${local.code_pipeline_project}-role"
  code_pipeline_iam_artifact_policy = "${local.code_pipeline_project}-artifact-policy"
  code_pipeline_iam_source_policy   = "${local.code_pipeline_project}-source-policy"
  code_pipeline_iam_build_policy    = "${local.code_pipeline_project}-build-policy"

  code_star_notification = "${local.code_pipeline_project}-notification"

  code_pipeline_scheduler        = "${var.name_prefix}-code-pipeline-schedule"
  code_pipeline_scheduler_role   = "${local.code_pipeline_scheduler}-role"
  code_pipeline_scheduler_policy = "${local.code_pipeline_scheduler}-policy"

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
  code_build_projects = [
    aws_codebuild_project.this.arn
  ]
  code_build = {
    environment_secrets_manager = flatten([
      for secret in var.code_build_environment_vars_secrets_manager : [
        for key in secret.keys :
        {
          name  = key
          value = "${secret.arn}:${key}"
        }
      ]
    ])
    environment_secrets_manager_arns = distinct(flatten([var.code_build_environment_vars_secrets_manager[*].arn]))
    environment_ssm_arns             = distinct(flatten([var.code_build_environment_vars_ssm[*].arn]))
    environment_kms                  = distinct(concat(compact(flatten([var.code_build_environment_vars_ssm[*].kms])), compact(flatten([var.code_build_environment_vars_secrets_manager[*].kms]))))
    create_secret_policy             = length(concat(var.code_build_environment_vars_secrets_manager, var.code_build_environment_vars_ssm)) > 0 ? true : false
    cloudwatch_encrypted             = var.code_build_cloudwatch_kms_key_id != null ? true : false
    tags = merge(
      {
        "Name" = local.code_build_project
      },
      var.code_build_tags
    )
    iam_role_tags = merge(
      {
        "Name" = local.code_build_iam_role
      },
      var.code_build_iam_role_tags
    )
    sg_tags = merge(
      {
        "Name" = local.code_build_sg
      },
      var.code_build_sg_tags
    )
    cloudwatch_tags = merge(
      {
        "Name" = local.code_build_cloudwatch_log_group
      },
      var.code_build_cloudwatch_tags
    )
  }
}


locals {
  code_pipeline = {
    source_artifact = "source_artifact"
    build_artifact  = "build_artifact"
    tags = merge(
      {
        "Name" = local.code_pipeline_project
      },
      var.code_pipeline_tags
    )
    iam_role_tags = merge(
      {
        "Name" = local.code_pipeline_iam_role
      },
      var.code_pipeline_iam_role_tags
    )
  }
}

locals {
  code_pipeline_scheduler_tags = {
    tags = merge(
      {
        "Name" = local.code_pipeline_scheduler
      },
      var.code_pipeline_scheduler_tags
    )
    iam_role_tags = merge(
      {
        "Name" = local.code_pipeline_scheduler_role
      },
      var.code_pipeline_scheduler_iam_role_tags
    )
  }
}
