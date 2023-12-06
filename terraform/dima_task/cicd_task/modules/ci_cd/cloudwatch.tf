resource "aws_cloudwatch_log_group" "code_build" {
  name       = local.code_build_cloudwatch_log_group
  kms_key_id = var.code_build_cloudwatch_kms_key_id
  tags       = local.code_build.cloudwatch_tags
}
