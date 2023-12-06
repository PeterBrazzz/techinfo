module "ci_cd" {
  source                                          = "./modules/ci_cd"
  name_prefix                                     = local.name_prefix

  code_pipeline_source                            = 
  code_pipeline_deploy_bucket_arn                 = aws_s3_bucket.this.arn
  code_pipeline_output_artifact_format            = var.code_pipeline_output_artifact_format
  code_pipeline_detect_changes                    = var.code_pipeline_detect_changes
  code_build_vpc_id                               = var.vpc_id
  code_build_subnet_ids                           = var.vpc_subnet_ids
  code_build_environment_vars                     = var.code_build_environment_vars
  code_build_app_environment_vars_secrets_manager = local.code_build_app_environment_vars_secrets_manager
  code_build_source_buildspec                     = var.code_build_source_buildspec
}