module "ecs_cluster" {
  source = "./modules/ecs"
  name_prefix = local.name_prefix

  vpc_id = data.aws_vpc.this.id
  vpc_subnets = ["subnet-27967a5e"]

  ecr_repo_url = aws_ecr_repository.this.repository_url
  ecr_repo_arn = aws_ecr_repository.this.arn
}