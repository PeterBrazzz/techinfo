resource "aws_lambda_function" "this" {
  function_name                  = local.lambda_function
  timeout                        = 360
  image_uri                      = "${aws_ecr_repository.this.repository_url}:latest"
  package_type                   = "Image"
  reserved_concurrent_executions = 10
  role                           = aws_iam_role.this.arn
  memory_size                    = var.lambda_memory
  environment {
    variables = {
      "ENVIRONMENT" = var.env_name
      "SQS_URL"     = var.sqs_url
    }
  }
  tags = local.lambda_tags
}

resource "aws_lambda_permission" "allow_private_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket-private"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket["private"]
}

resource "aws_lambda_permission" "allow_public_bucket" {
  statement_id  = "AllowExecutionFromS3Bucket-public"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.this.function_name
  principal     = "s3.amazonaws.com"
  source_arn    = var.bucket["public"]
}
