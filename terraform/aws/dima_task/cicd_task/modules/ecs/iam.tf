# resource "aws_iam_role" "this" {
#   name               = "ECS-service-role-ecr-read-access"
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Effect": "Allow",
#       "Principal": {
#         "Service": "ecs-task.amazonaws.com"
#       },
#       "Action": "sts:AssumeRole"
#     }
#   ]
# }
# EOF
# }

# resource "aws_iam_role_policy" "ecr_read" {
#   name   = "ecr-read"
#   role   = aws_iam_role.this.id
#   policy = data.aws_iam_policy_document.ecr_read.json
# }
