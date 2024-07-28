output "vpcId" {
  value = module.vpc.vpc_id
  description = "VPC ID"
}

output "private_subnet_ids" {
  value = [for subnet in module.vpc.private_subnets : subnet]
  description = "VPC ID"
}

output "public_subnet_ids" {
  value = [for subnet in module.vpc.public_subnets : subnet]
  description = "VPC ID"
}

output "subnet_name" {
  value = module.vpc.database_subnet_group_name
  description = "VPC ID"
}