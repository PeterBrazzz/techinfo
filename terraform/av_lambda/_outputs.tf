output "name" {
  description = "Lambda function name."
  value       = aws_lambda_function.this.function_name
}

output "arn" {
  description = "Lambda function ARN."
  value       = aws_lambda_function.this.arn
}

output "role_arn" {
  description = "Lambda function ARN."
  value       = aws_iam_role.this.arn
}
