resource "aws_codebuild_project" "this" {
  name           = local.code_build_project
  description    = var.code_build_description
  build_timeout  = var.code_build_build_timeout
  queued_timeout = var.code_build_queued_timeout
  encryption_key = var.s3_sse_kms_key_id
  service_role   = aws_iam_role.code_build.arn

  environment {
    type                        = "LINUX_CONTAINER"
    compute_type                = var.code_build_compute_type
    image                       = var.code_build_image
    image_pull_credentials_type = var.code_build_image_pull_credentials_type
    privileged_mode             = var.code_build_image_privileged_mode

    dynamic "environment_variable" {
      for_each = var.code_build_environment_vars

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = "PLAINTEXT"
      }
    }

    dynamic "environment_variable" {
      for_each = var.code_build_environment_vars_ssm

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.arn
        type  = "PARAMETER_STORE"
      }
    }

    dynamic "environment_variable" {
      for_each = local.code_build.environment_secrets_manager

      content {
        name  = environment_variable.value.name
        value = environment_variable.value.value
        type  = "SECRETS_MANAGER"
      }
    }
  }

  vpc_config {
    vpc_id             = var.code_build_vpc_id
    subnets            = var.code_build_subnet_ids
    security_group_ids = [aws_security_group.code_build.id]
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = var.code_build_source_buildspec
    git_clone_depth = 0
    insecure_ssl    = false
  }

  artifacts {
    type                = "CODEPIPELINE"
    artifact_identifier = var.code_build_artifact_name
    name                = var.code_build_artifact_name
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_SOURCE_CACHE", "LOCAL_DOCKER_LAYER_CACHE"]
  }

  logs_config {
    cloudwatch_logs {
      status     = "ENABLED"
      group_name = aws_cloudwatch_log_group.code_build.name
    }
  }

  tags       = local.code_build.tags
  depends_on = [aws_iam_role.code_build]
}
