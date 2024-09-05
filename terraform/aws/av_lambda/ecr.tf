resource "aws_ecr_repository" "this" {
  name                 = local.ecr
  image_tag_mutability = var.ecr_tag_mutability

  image_scanning_configuration {
    scan_on_push = var.ecr_scan_on_push
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  tags = local.ecr_tags
}
