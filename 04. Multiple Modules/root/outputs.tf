output "thevpc_id" {
  description = "ID of the created VPC"
  value       = module.vpc.thevpc_id
}

output "publicsubnet_id" {
  description = "ID of the public subnet"
  value       = module.vpc.publicsubnet_id
}