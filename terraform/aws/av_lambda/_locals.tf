locals {
  lambda_function                  = "${var.name_prefix}-lambda"
  lambda_role                      = "${local.lambda_function}-role"
  lambda_function_s3_policy        = "${local.lambda_function}-s3-policy"
  lambda_function_sqs_queue_policy = "${local.lambda_function}-sqs-queue-policy"
  ecr                              = "${var.name_prefix}-repository"
  lambda_image                     = "${local.lambda_function}-image"
  alarm                            = "${local.lambda_function}-alarm"
  ecr_url                          = "${data.aws_caller_identity.this.account_id}.dkr.ecr.${data.aws_region.this.name}.amazonaws.com"
}

locals {
  cloudwatch_log_group              = "/aws/lambda/${local.lambda_function}"
  lambda_function_cloudwatch_policy = "${local.lambda_function}-cloudwatch-policy"
  cloudwatch_logs_encrypted         = var.cloudwatch_kms_key != null ? true : false
}

locals {
  lambda_tags = merge(
    {
      "Name" = local.lambda_function
    },
    var.lambda_tags
  )

  ecr_tags = merge(
    {
      "Name" = local.ecr
    },
    var.ecr_tags
  )

  cloudwatch_log_group_tags = merge(
    {
      "Name" = local.cloudwatch_log_group
    },
    var.cloudwatch_tags
  )
}
