resource "aws_iam_role" "this" {
  name               = local.lambda_role
  assume_role_policy = data.aws_iam_policy_document.this.json
}

resource "aws_iam_role_policy" "s3_public" {
  name   = "${local.lambda_function_s3_policy}-public"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.s3_public.json
}

resource "aws_iam_role_policy" "s3_private" {
  name   = "${local.lambda_function_s3_policy}-private"
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.s3_private.json
}

resource "aws_iam_role_policy" "sqs_queue_access" {
  name   = local.lambda_function_sqs_queue_policy
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.sqs_queue.json
}

resource "aws_iam_role_policy" "cloudwatch" {
  name   = local.lambda_function_cloudwatch_policy
  role   = aws_iam_role.this.id
  policy = data.aws_iam_policy_document.cloudwatch.json
}

resource "aws_iam_role_policy_attachment" "insights_policy" {
  role       = aws_iam_role.this.id
  policy_arn = "arn:aws:iam::aws:policy/CloudWatchLambdaInsightsExecutionRolePolicy"
}
