output "vpc_id" {
  description = "Output of vpc id for peering"
  value       = aws_vpc.this.id
}

output "privat_subnet_id" {
  description = "Output of vpc id for peering"
  value       = aws_subnet.privat.id
}

output "public_subnet_id" {
  description = "Output of vpc id for peering"
  value       = aws_subnet.public.id
}

data "aws_region" "current" {}

output "region" {
  description = "Output of region name for peering"
  value       = data.aws_region.current.name
}
