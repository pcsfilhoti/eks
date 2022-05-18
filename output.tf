output "cluster_name" {
  value = module.eks.cluster_name
}

#output "region" {
#  value = 
#}

output "sub-priv-a" {
  value = element(module.vpc.private_subnet_id, 0)
}

output "sub-priv-b" {
  value = element(module.vpc.private_subnet_id, 1)
}

output "vpc" {
  value = module.vpc.vpc_id
}