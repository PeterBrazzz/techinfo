resource "aws_ecs_service" "this" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.this.arn
  desired_count   = 1
  
#   iam_role        = aws_iam_role.this.arn
#   depends_on      = [aws_iam_role_policy.ecr_read]

  network_configuration {
    subnets          = var.vpc_subnets
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = false
  }
}