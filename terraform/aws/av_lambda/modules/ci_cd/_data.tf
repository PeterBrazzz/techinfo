data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "code_build_secret" {
  count = local.code_build.create_secret_policy ? 1 : 0
  dynamic "statement" {
    for_each = length(local.code_build.environment_ssm_arns) > 0 ? [true] : []
    content {
      actions   = ["ssm:GetParameters"]
      resources = local.code_build.environment_ssm_arns
    }
  }

  dynamic "statement" {
    for_each = length(local.code_build.environment_secrets_manager_arns) > 0 ? [true] : []
    content {
      actions = [
        "secretsmanager:GetSecretValue",
        "secretsmanager:DescribeSecret"
      ]
      resources = local.code_build.environment_secrets_manager_arns
    }
  }

  dynamic "statement" {
    for_each = length(local.code_build.environment_kms) > 0 ? [true] : []
    content {
      actions   = ["kms:Decrypt"]
      resources = local.code_build.environment_kms
    }
  }
}

data "aws_iam_policy_document" "code_build_cloudwatch" {
  statement {
    actions   = ["logs:CreateLogStream"]
    resources = ["${aws_cloudwatch_log_group.code_build.arn}:*"]
  }

  statement {
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.code_build.arn}:log-stream:*"]
  }

  statement {
    actions   = ["logs:DescribeLogGroups"]
    resources = ["arn:aws:logs:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:log-group:*"]
  }

  dynamic "statement" {
    for_each = local.code_build.cloudwatch_encrypted ? [true] : []
    content {
      actions = [
        "kms:GenerateDataKey",
        "kms:Encrypt"
      ]
      resources = [var.code_build_cloudwatch_kms_key_id]
    }
  }
}

data "aws_iam_policy_document" "code_build_lambda_updating" {
  statement {
    actions = [
      "lambda:UpdateFunctionCode"
    ]
    resources = [var.av_lambda]
  }
}

data "aws_iam_policy_document" "code_build_vpc" {
  statement {
    actions = [
      "ec2:CreateNetworkInterface",
      "ec2:CreateNetworkInterfacePermission",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeVpcs",
      "ec2:DeleteNetworkInterface",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeSubnets",
      "ec2:DescribeSecurityGroups"
    ]
    resources = ["*"]
  }
}

data "aws_iam_policy_document" "code_pipeline_source" {
  statement {
    actions   = ["codestar-connections:UseConnection"]
    resources = [var.code_pipeline_source.codestar_connection_arn]
  }
}

data "aws_iam_policy_document" "code_pipeline_build" {
  statement {
    actions = [
      "codebuild:BatchGetBuilds",
      "codebuild:StartBuild",
      "codebuild:BatchGetBuildBatches",
      "codebuild:StartBuildBatch"
    ]
    resources = local.code_build_projects
  }
}


data "aws_iam_policy_document" "artifact" {
  statement {
    actions = [
      "s3:ListBucket"
    ]
    resources = [var.artifact_bucket_arn]
  }
  statement {
    actions = [
      "s3:GetObject",
      "s3:GetObjectVersion",
      "s3:PutObject",
      "s3:PutObjectAcl",
      "s3:DeleteObject",
      "s3:DeleteObjectVersion"
    ]
    resources = ["${var.artifact_bucket_arn}/*"]
  }
  dynamic "statement" {
    for_each = local.s3.encrypted ? [true] : []
    content {
      actions = [
        "kms:GenerateDataKey",
        "kms:Encrypt",
        "kms:Decrypt"
      ]
      resources = [var.cache_location_kms]
    }
  }
}


data "aws_iam_policy_document" "code_pipeline_scheduler" {
  statement {
    actions = [
      "codepipeline:StartPipelineExecution"
    ]
    resources = [aws_codepipeline.this.arn]
  }
}
