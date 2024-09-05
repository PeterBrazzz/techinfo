output "bucket_arn" {
  description = "Output for iam_role module"
  value       = aws_s3_bucket.this.arn
}
