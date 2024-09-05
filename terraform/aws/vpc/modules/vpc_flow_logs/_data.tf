data "aws_iam_policy_document" "this" {
  statement {
    sid = "AWSFlowLogsWrite"

    principals {
      type        = "Service"
      identifiers = ["delivery.logs.amazonaws.com"]
    }

    actions = ["s3:PutObject"]

    resources = ["arn:aws:s3:::${local.s3}/AWSLogs/*"]
  }
}
