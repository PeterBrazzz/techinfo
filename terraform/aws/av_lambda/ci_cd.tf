module "ci_cd" {
  source                = "./modules/ci_cd"
  name_prefix           = var.name_prefix
  code_build_vpc_id     = var.vpc_id
  code_build_subnet_ids = var.vpc_subnets.private
  code_pipeline_source  = var.code_pipeline_source
  artifact_bucket_id    = var.artifact_bucket.bucket_id
  artifact_bucket_arn   = var.artifact_bucket.bucket_arn

  av_lambda = aws_lambda_function.this.arn

  code_build_environment_vars = [
    {
      name  = "LAMBDA_IMAGE"
      value = local.lambda_image
    },
    {
      name  = "LAMBDA_FUNCTION"
      value = aws_lambda_function.this.function_name
    },
    {
      name  = "REPOSITORY_URI"
      value = aws_ecr_repository.this.repository_url
    },
    {
      name  = "ECR_URI"
      value = local.ecr_url
    }
  ]

  code_build_external_iam_policies = [
    data.aws_iam_policy_document.ecr_read.json,
    data.aws_iam_policy_document.ecr_write.json
  ]
  chatbot_arn = var.chatbot_arn
}
