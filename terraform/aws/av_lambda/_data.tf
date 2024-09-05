data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

data "aws_iam_policy_document" "this" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "s3_private" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObjectTagging",
      "s3:DeleteObject"
    ]
    resources = [
      var.bucket["private"],
      "${var.bucket["private"]}/*"
    ]
  }
}

data "aws_iam_policy_document" "s3_public" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObjectTagging",
      "s3:DeleteObject"
    ]
    resources = [
      var.bucket["public"],
      "${var.bucket["public"]}/*"
    ]
  }
}

data "aws_iam_policy_document" "sqs_queue" {
  statement {
    actions = [
      "sqs:ReceiveMessage",
      "sqs:DeleteMessage",
      "sqs:SendMessage",
      "sqs:ChangeMessageVisibility"
    ]
    resources = [var.sqs_arn]
  }
}

data "aws_iam_policy_document" "cloudwatch" {
  statement {
    actions   = ["logs:CreateLogStream"]
    resources = ["${aws_cloudwatch_log_group.this.arn}:*"]
  }

  statement {
    actions   = ["logs:PutLogEvents"]
    resources = ["${aws_cloudwatch_log_group.this.arn}:log-stream:*"]
  }

  statement {
    actions   = ["logs:DescribeLogGroups"]
    resources = ["arn:aws:logs:${data.aws_region.this.name}:${data.aws_caller_identity.this.account_id}:log-group:*"]
  }

  dynamic "statement" {
    for_each = local.cloudwatch_logs_encrypted ? [true] : []
    content {
      actions = [
        "kms:DescribeKey",
        "kms:GenerateDataKey",
        "kms:Encrypt"
      ]
      resources = [var.cloudwatch_kms_key]
    }
  }
}

data "aws_iam_policy_document" "ecr_write" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload"
    ]
    resources = [aws_ecr_repository.this.arn]
  }
  dynamic "statement" {
    for_each = aws_ecr_repository.this.encryption_configuration[0].kms_key != "" ? [true] : []
    content {
      actions = [
        "kms:GenerateDataKey",
        "kms:Encrypt"
      ]
      resources = [aws_ecr_repository.this.encryption_configuration[0].kms_key]
    }
  }
}

data "aws_iam_policy_document" "ecr_read" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = [aws_ecr_repository.this.arn]
  }
  dynamic "statement" {
    for_each = aws_ecr_repository.this.encryption_configuration[0].kms_key != "" ? [true] : []
    content {
      actions   = ["kms:Decrypt"]
      resources = [aws_ecr_repository.this.encryption_configuration[0].kms_key]
    }
  }
}
