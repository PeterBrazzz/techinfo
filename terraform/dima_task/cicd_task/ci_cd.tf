module "ecs_cicd" {
  source      = "./modules/ecs_cicd"
  name_prefix = "ecs-cicd"

  artifact_bucket = {
    bucket_arn = aws_s3_bucket.artifact.arn
    bucket_id  = aws_s3_bucket.artifact.id
  }

  vpc_id = data.aws_vpc.this.id
  vpc_subnets = ["subnet-27967a5e"]

  code_pipeline_source = {
    codestar_connection_arn = "arn:aws:codestar-connections:eu-west-1:225050420367:connection/be2ef9c8-f754-4872-a48d-c7cee57e54a6"
    repository_id           = "PeterBrazzz/jenkins"
    repository_branch       = "main"
  }

  ecs_cluster_name = module.ecs_cluster.cluster_name
  ecs_service_name = module.ecs_cluster.service_name
  ecr_repo_url = aws_ecr_repository.this.repository_url
  ecr_repo_arn = aws_ecr_repository.this.arn
}
