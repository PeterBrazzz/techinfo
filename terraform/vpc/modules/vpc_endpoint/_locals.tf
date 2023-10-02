locals {
  vpc_endpoint_prefix = "com.amazonaws.${data.aws_region.current.name}"
  vpc_endpoint_name   = "${local.vpc_endpoint_prefix}.${var.service_name}"
  endpoint_name       = "${var.name_prefix}-vpc-endpoint-${var.service_name}"
  sg_name             = "${local.endpoint_name}-sg"
}

locals {
  endpoint_tags = merge(
    {
      "Name" = local.endpoint_name
    },
    var.endpoint_tags
  )
  sg_tags = merge(
    {
      "Name" = local.sg_name
    },
    var.sg_tags
  )
}
