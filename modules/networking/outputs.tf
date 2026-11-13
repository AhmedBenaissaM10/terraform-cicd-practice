output "igw_id" {
  description = "The ID of the Internet Gateway"
  value       = aws_internet_gateway.igw.id
}
output "public_route_table_id" {
  description = "The ID of the Public Route Table"
  value       = aws_route_table.public_rt.id
}

