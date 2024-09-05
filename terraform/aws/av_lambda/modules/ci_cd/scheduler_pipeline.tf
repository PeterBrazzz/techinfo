resource "aws_scheduler_schedule" "this" {
  name        = local.code_pipeline_scheduler
  group_name  = "default"
  description = "Executing AV-Pipeline onec a week."
  flexible_time_window {
    mode                      = "FLEXIBLE"
    maximum_window_in_minutes = 5
  }

  schedule_expression          = "cron(00 01 ? * SAT *)"
  schedule_expression_timezone = "Asia/Tbilisi"
  target {
    arn      = aws_codepipeline.this.arn
    role_arn = aws_iam_role.event_bridge_scheduler.arn
  }
}
