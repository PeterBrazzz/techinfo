module "lambda" {
  source      = "./module"
  name_prefix = local.name_prefix

  vpc_id         = var.vpc_id
  subnet_ids     = var.vpc_subnets.private
  secret_arn     = aws_secretsmanager_secret.this.arn
  secret_name    = aws_secretsmanager_secret.this.name
  secret_kms_key = data.aws_kms_key.secret_kms_key.arn
  url            = var.lambda_new_relic_url
}
