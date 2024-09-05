resource "aws_cloudwatch_log_group" "this" {
  name       = local.cloudwatch_log_group
  kms_key_id = var.cloudwatch_kms_key
  tags       = local.cloudwatch_log_group_tags
}

resource "aws_cloudwatch_metric_alarm" "this" {
  alarm_name          = local.alarm
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "Errors"
  namespace           = "AWS/Lambda"
  period              = 60
  datapoints_to_alarm = 1

  statistic = "Average"
  threshold = 0

  alarm_description = "When in alarm, send message to SNS topic"
  actions_enabled   = "true"
  alarm_actions     = [module.chatbot.sns_topic]

  dimensions = {
    FunctionName = aws_lambda_function.this.id
  }
}
