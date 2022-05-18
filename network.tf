module "vpc" {
  source = "git@ssh.dev.azure.com:v3/MC1Infra/IaC/terraform_module_foundation"

  vpc_cidr             = var.vpc_cidr
  name                 = var.vpc_name
  env                  = var.env
  public_subnets_cidr  = var.pub_subnets
  private_subnets_cidr = var.pri_subnets
  availability_zones   = var.az
  cluster_name         = var.cluster_name

  providers = {
    aws = aws.us-east-1
  }

}