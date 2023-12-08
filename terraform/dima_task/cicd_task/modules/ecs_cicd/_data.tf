data "aws_region" "this" {}
data "aws_caller_identity" "this" {}

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
    resources = [var.ecr_repo_arn]
  }
  # dynamic "statement" {
  #   for_each = aws_ecr_repository.this.encryption_configuration[0].kms_key != "" ? [true] : []
  #   content {
  #     actions = [
  #       "kms:GenerateDataKey",
  #       "kms:Encrypt"
  #     ]
  #     resources = [aws_ecr_repository.this.encryption_configuration[0].kms_key]
  #   }
  # }
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
    resources = [var.ecr_repo_arn]
  }
  # dynamic "statement" {
  #   for_each = aws_ecr_repository.this.encryption_configuration[0].kms_key != "" ? [true] : []
  #   content {
  #     actions   = ["kms:Decrypt"]
  #     resources = [aws_ecr_repository.this.encryption_configuration[0].kms_key]
  #   }
  # }
}
