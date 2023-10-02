output "peering_id" {
  description = "Peering id for route tables"
  value       = aws_vpc_peering_connection.this.id
}