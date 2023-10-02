resource "aws_s3_bucket" "this" {
  bucket = "${var.prefix}-bucket"

  tags = merge(
    var.tags_bucket,
    {
      Name = "${var.prefix}-bucket"
    },
  )
}

resource "aws_s3_bucket_acl" "this" {
  bucket = aws_s3_bucket.this.id
  acl    = "private"
}
