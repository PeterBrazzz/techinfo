module "ci_cd" {
  source                = "./modules/ci_cd"
  name_prefix           = var.name_prefix
  code_build_vpc_id     = var.vpc_id
  code_build_subnet_ids = var.vpc_subnets
  code_pipeline_source  = var.code_pipeline_source
  artifact_bucket_id    = var.artifact_bucket.bucket_id
  artifact_bucket_arn   = var.artifact_bucket.bucket_arn

  code_build_environment_vars = [
    {
      name  = "REPOSITORY_NAME"
      value = "brazovsky-task-repository"
    },
    {
      name  = "REPOSITORY_URI"
      value = var.ecr_repo_url
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
  ecs_cluster_name = var.ecs_cluster_name
  ecs_service_name = var.ecs_service_name
}
