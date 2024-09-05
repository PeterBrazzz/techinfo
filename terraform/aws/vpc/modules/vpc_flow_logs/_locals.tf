locals {
  flow_logs = "${var.name_prefix}-flow-logs"
  s3        = "${local.flow_logs}-bucket"
}

locals {
  s3_tags = merge(
    {
      "Name" = local.s3
    },
    var.s3_tags
  )

}
