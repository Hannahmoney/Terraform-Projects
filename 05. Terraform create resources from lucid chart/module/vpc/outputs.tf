output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public_subnets_ids" {
  value = [
    aws_subnet.public_subnet_a.id,
    aws_subnet.public_subnet_b.id
  ]
  
}

output "private_subnets_ids" {
  value = [
    aws_subnet.private_subnet_a.id,
    aws_subnet.private_subnet_b.id
  ]
}

output "public_routetable_id" {
  value = aws_route_table.publicrt.id

}

output "private_routetable_id" {
  value = aws_route_table.privatert
}