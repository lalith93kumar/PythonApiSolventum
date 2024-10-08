locals {
  repositoryName = strcontains(basename(abspath("${path.module}/../..")),"src")? "PythonApiSolventum" : basename(abspath("${path.module}/../..")) 
}

module "currentAccount" {
    source = "./account"
}

module "vpc_details" {
    source = "./vpc"
    region = var.region
    clusterName = var.clusterName
}

module "cluster" {
    source = "./cluster"
    clusterName = var.clusterName
}

module "iam" {
    source = "./iam"
    region = var.region
    clusterName = var.clusterName
    accountID = module.currentAccount.accountId
    repositoryName = local.repositoryName
}

module "logGroup" {
    source = "./logGroups"
    clusterName = var.clusterName
}

module "securityGroup" {
    source = "./securityGroup"
    clusterName = var.clusterName
    vpc_id = module.vpc_details.vpcId
}

module "rds" {
    source = "./rds"
    security_group_ids = module.securityGroup.security_group_ids
    public_subnet_name =  module.vpc_details.public_subnet_ids
}

module "ecsTaskDefinition" {
    source = "./ecsTaskDefinition"
    clusterName = var.clusterName
    iam_arm = module.iam.iam_arm
    repositoryVersion = var.repositoryVersion
    region = var.region
    accountID = module.currentAccount.accountId
    repositoryName = local.repositoryName
    rds_endpoint = module.rds.rds_endpoint
}


module "loadBalancer" {
    source = "./loadBalancer"
    clusterName = var.clusterName
    vpc_id =  module.vpc_details.vpcId
    public_subnet_ids =  module.vpc_details.public_subnet_ids
    security_group_ids = module.securityGroup.security_group_ids
}

module "ecsService" {
    source = "./ecsService"
    clusterName = var.clusterName
    private_subnet_ids = module.vpc_details.private_subnet_ids
    clusterId = module.cluster.clusterId
    application_security_group_ids = module.securityGroup.security_group_ids
    api_task_definition_id = module.ecsTaskDefinition.api_task_definition_arn
    api_lb_target_group_arn = module.loadBalancer.api_lb_target_group_arn
    application_lb_arn = module.loadBalancer.api_lb_listener
    repositoryVersion = var.repositoryVersion
}

module "auto_scaling" {
    source = "./autoScaling"
    clusterName = module.cluster.clusterName
    serviceName = module.ecsService.apiServiceID
    repositoryName = local.repositoryName
}