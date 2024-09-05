resource "aws_s3_bucket" "artifact" {
  bucket        = "${local.bucket}-artifact"
  force_destroy = var.s3_force_destroy

  tags = local.s3.tags
}

resource "aws_s3_bucket_server_side_encryption_configuration" "artifact" {
  bucket = aws_s3_bucket.artifact.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = local.s3.sse_algorithm
      kms_master_key_id = var.s3_sse_kms_key_id
    }
  }
}
