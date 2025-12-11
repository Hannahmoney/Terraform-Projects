output "thevpc_id" {
  description = "ID of the created VPC"
  value       = aws_vpc.thevpc.id
}

output "publicsubnet_id" {
  description = "ID of the public subnet"
  value       = aws_subnet.thepublicsubnet.id
}