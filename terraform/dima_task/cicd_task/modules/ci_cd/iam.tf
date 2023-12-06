resource "aws_iam_role" "code_build" {
  name               = substr(local.code_build_iam_role, 0, 64)
  tags               = local.code_build.iam_role_tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codebuild.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "code_build_secret" {
  count  = local.code_build.create_app_secret_policy ? 1 : 0
  name   = local.code_build_iam_secret_policy
  role   = aws_iam_role.code_build.id
  policy = data.aws_iam_policy_document.code_build_secret[0].json
}

resource "aws_iam_role_policy" "code_build_cloudwatch" {
  name   = local.code_build_iam_cloudwatch_policy
  role   = aws_iam_role.code_build.id
  policy = data.aws_iam_policy_document.code_build_cloudwatch.json
}

resource "aws_iam_role_policy" "code_build_artifact" {
  name   = local.code_build_iam_artifact_policy
  role   = aws_iam_role.code_build.id
  policy = data.aws_iam_policy_document.artifact.json
}

resource "aws_iam_role_policy" "code_build_vpc" {
  name   = local.code_build_iam_vpc_policy
  role   = aws_iam_role.code_build.id
  policy = data.aws_iam_policy_document.code_build_vpc.json
}

resource "aws_iam_role_policy" "code_build_external" {
  count  = length(var.code_build_external_iam_policies)
  name   = "${local.code_build_iam_external_policy}-${count.index}"
  role   = aws_iam_role.code_build.id
  policy = element(var.code_build_external_iam_policies, count.index)
}

resource "aws_iam_role" "code_pipeline" {
  name               = substr(local.code_pipeline_iam_role, 0, 64)
  tags               = local.code_pipeline.iam_role_tags
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "codepipeline.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_role_policy" "code_pipeline_artifact" {
  name   = local.code_pipeline_iam_artifact_policy
  role   = aws_iam_role.code_pipeline.id
  policy = data.aws_iam_policy_document.artifact.json
}

resource "aws_iam_role_policy" "code_pipeline_source" {
  name   = local.code_pipeline_iam_source_policy
  role   = aws_iam_role.code_pipeline.id
  policy = data.aws_iam_policy_document.code_pipeline_source.json
}

resource "aws_iam_role_policy" "code_pipeline_build" {
  name   = local.code_pipeline_iam_build_policy
  role   = aws_iam_role.code_pipeline.id
  policy = data.aws_iam_policy_document.code_pipeline_build.json
}

resource "aws_iam_role_policy" "code_pipeline_deploy" {
  name   = local.code_pipeline_iam_deploy_policy
  role   = aws_iam_role.code_pipeline.id
  policy = data.aws_iam_policy_document.code_pipeline_deploy.json
}

# resource "aws_iam_role_policy" "code_pipeline_lambda" {
#   name   = local.code_pipeline_iam_lambda_policy
#   role   = aws_iam_role.code_pipeline.id
#   policy = data.aws_iam_policy_document.code_pipeline_lambda.json
# }
