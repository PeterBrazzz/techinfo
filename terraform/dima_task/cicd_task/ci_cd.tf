module "ecs_cicd" {
  source      = "./modules/ecs_cicd"
  name_prefix = "ecs-cicd"

  artifact_bucket = {
    bucket_arn = aws_s3_bucket.artifact.arn
    bucket_id  = aws_s3_bucket.artifact.id
  }
  code_build_vpc_id = data.aws_vpc.this.id
  code_build_subnet_ids = [aws_subnet.privat.id]

  code_build_environment_vars = [
    {
      name  = "REPOSITORY_NAME"
      value = "brazovsky-task-repository"
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

  code_pipeline_source = {
    codestar_connection_arn = "arn:aws:codestar-connections:eu-west-1:225050420367:connection/be2ef9c8-f754-4872-a48d-c7cee57e54a6"
    repository_id           = "PeterBrazzz/jenkins"
    repository_branch       = "main"
  }

  
  code_build_external_iam_policies = [
    data.aws_iam_policy_document.ecr_read.json,
    data.aws_iam_policy_document.ecr_write.json
  ]

  ecs_cluster_name = module.ecs_cluster.cluster_name
  ecs_service_name = module.ecs_cluster.service_name
}
