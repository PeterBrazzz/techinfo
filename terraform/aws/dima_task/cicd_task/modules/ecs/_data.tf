
data "aws_iam_policy_document" "ecr_read" {
  statement {
    actions = [
      "ecr:GetAuthorizationToken",
    ]
    resources = ["*"]
  }
  statement {
    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
    ]
    resources = [var.ecr_repo_arn]
  }
}

data "aws_iam_role" "ecs-task" {
  name = "ecsTaskExecutionRole"
}