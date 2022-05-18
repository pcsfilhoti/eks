module "eks" {
  source = "git@ssh.dev.azure.com:v3/MC1Infra/IaC/terraform_module_eks"

  cluster_name       = var.cluster_name
  kubernetes_version = var.k8s_version

  private_subnet_1a = element(module.vpc.private_subnet_id, 0)
  private_subnet_1b = element(module.vpc.private_subnet_id, 1)
  public_subnet_1a  = element(module.vpc.public_subnet_id, 0)
  public_subnet_1b  = element(module.vpc.public_subnet_id, 1)

  providers = {
    aws = aws.us-east-1
  }
}

module "node" {
  source = "git@ssh.dev.azure.com:v3/MC1Infra/IaC/terraform_module_nodeGroup"

  cluster_name = module.eks.cluster_name
  node_name    = var.node

  private_subnet_1a = element(module.vpc.private_subnet_id, 0)
  private_subnet_1b = element(module.vpc.private_subnet_id, 1)

  key = var.key
  
  desired_size = 2
  min_size     = 1
  max_size     = 2

  providers = {
    aws = aws.us-east-1
  }
}