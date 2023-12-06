output "vpc_id" {
  description = "Output of vpc id for peering."
  value       = aws_vpc.this.id
}

# output "public_subnet_id" {
#   description = "Output of vpc id for peering."
#   value       = aws_subnet.public.id
# }
