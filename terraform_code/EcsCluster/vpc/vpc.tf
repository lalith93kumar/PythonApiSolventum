module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.7.0"
  name = "Nat-Test"
  cidr = "10.0.0.0/16"
  azs  = ["${var.region}a","${var.region}b"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  enable_nat_gateway = true
  single_nat_gateway = true
  one_nat_gateway_per_az = false
  enable_dns_hostnames = true
  enable_dns_support = true
  public_subnet_tags = {
    Type = "public"
  }
  private_subnet_tags = {
    Type = "private"
  }
  tags = {
    Environment = var.clusterName
  }
}