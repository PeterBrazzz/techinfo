resource "aws_lambda_function" "this" {
  function_name = local.lambda_function
  description   = var.description
  publish       = var.publish
  runtime       = var.runtime

  filename         = data.archive_file.function.output_path
  source_code_hash = data.archive_file.function.output_base64sha256
  handler          = var.lambda_handler

  role   = aws_iam_role.this.arn
  layers = var.layers

  memory_size = var.memory_size
  timeout     = var.timeout

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = [aws_security_group.this.id]
  }

  environment {
    variables = var.environment_variables
  }

  tags = local.tags
}
