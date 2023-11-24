output "vpc_id" {
  description = "Output of vpc id for peering."
  value       = aws_vpc.this.id
}

output "privat_subnet_id" {
  description = "Output of vpc id for peering."
  value       = aws_subnet.privat.id
}

# output "public_subnet_id" {
#   description = "Output of vpc id for peering."
#   value       = try(aws_subnet.public[0].id, null)
# }
