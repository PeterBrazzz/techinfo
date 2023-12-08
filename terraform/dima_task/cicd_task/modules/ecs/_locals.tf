locals {
  name_prefix = "${var.name_prefix}-ecs"
  cluster_name = "${local.name_prefix}-cluster"
  service_name = "${local.name_prefix}-service"
  sg_service = "${local.service_name}-sg"
}