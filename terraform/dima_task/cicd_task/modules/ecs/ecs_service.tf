resource "aws_ecs_service" "this" {
  name            = local.service_name
  cluster         = aws_ecs_cluster.this.id
  task_definition = aws_ecs_task_definition.new.id
  desired_count   = 1
  launch_type = "FARGATE"

  network_configuration {
    subnets          = var.vpc_subnets
    security_groups  = [aws_security_group.ecs_service.id]
    assign_public_ip = true
  }
}