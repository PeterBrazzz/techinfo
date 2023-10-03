
resource "aws_s3_bucket_notification" "private_bucket_notification" {
  bucket = var.bucket_id["private"]

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:CompleteMultipartUpload", "s3:ObjectCreated:Put"]
  }

  depends_on = [
    aws_lambda_permission.allow_private_bucket
  ]
}

resource "aws_s3_bucket_notification" "public_bucket_notification" {
  bucket = var.bucket_id["public"]

  lambda_function {
    lambda_function_arn = aws_lambda_function.this.arn
    events              = ["s3:ObjectCreated:CompleteMultipartUpload", "s3:ObjectCreated:Put"]
  }

  depends_on = [
    aws_lambda_permission.allow_public_bucket
  ]
}
