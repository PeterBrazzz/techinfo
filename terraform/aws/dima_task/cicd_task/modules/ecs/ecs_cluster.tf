resource "aws_ecs_cluster" "this" {
  name = var.name_prefix

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}

resource "aws_ecs_task_definition" "new" {
  family                = "task"
  execution_role_arn       = data.aws_iam_role.ecs-task.arn
  container_definitions = jsonencode([
    {
      name   = "task-container"
      image  = "${var.ecr_repo_url}:latest"
      cpu    = 256
      memory = 512
      # portMappings = [
      #   {
      #     containerPort = 5000
      #   }
      # ]
    }
  ])

  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 256
  memory                   = 512
  runtime_platform {
    operating_system_family = "LINUX"
    cpu_architecture        = "X86_64"
  }
}
