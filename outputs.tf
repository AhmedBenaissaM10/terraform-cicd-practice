output "vpc_id" {
  value = module.vpc.vpc_id
}
output "public_subnet_id" {
  value = module.vpc.public_subnet_id
}

output "public_route_table_id" {
  value = module.networking.public_route_table_id
}

output "igw_id" {
  value = module.networking.igw_id
}
output "public_sg_id" {
  value = module.security_group.public_sg_id
}

output "public_instance_ip" {
  value = module.ec2.public_instance_ip
}

output "public_instance_id" {
  value = module.ec2.public_instance_id
}
