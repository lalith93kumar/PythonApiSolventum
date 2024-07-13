module "vpc_details" {
    source = "./vpc"
    region = var.region
    clusterName = var.clusterName
}

module "cluster" {
    source = "./cluster"
    region = var.region
    clusterName = var.clusterName
}

module "iam" {
    source = "./iam"
    region = var.region
    clusterName = var.clusterName
    accountID = var.accountID
    repositoryName = var.repositoryName
}

module "logGroup" {
    source = "./logGroups"
    region = var.region
    clusterName = var.clusterName
}

module "ecsTaskDefinition" {
    source = "./ecsTaskDefinition"
    clusterName = var.clusterName
    iam_arm = module.iam.iam_arm
    repositoryVersion = var.repositoryVersion
    region = var.region
    accountID = var.accountID
    repositoryName = var.repositoryName
}

module "securityGroup" {
    source = "./securityGroup"
    region = var.region
    clusterName = var.clusterName
    vpc_id = module.vpc_details.vpcId
}

module "loadBalancer" {
    source = "./loadBalancer"
    region = var.region
    clusterName = var.clusterName
    vpc_id =  module.vpc_details.vpcId
    public_subnet_ids =  module.vpc_details.public_subnet_ids
    security_group_ids = module.securityGroup.security_group_ids
}


module "ecsService" {
    source = "./ecsService"
    region = var.region
    clusterName = var.clusterName
    private_subnet_ids = module.vpc_details.private_subnet_ids
    clusterId = module.cluster.cluster_id
    application_security_group_ids = module.securityGroup.security_group_ids
    api_task_definition_id = module.ecsTaskDefinition.api_task_definition_arn
    api_lb_target_group_arn = module.loadBalancer.api_lb_target_group_arn
    application_lb_arn = module.loadBalancer.api_lb_listener
    repositoryVersion = var.repositoryVersion
}

module "auto_scaling" {
  source = "./autoScaling"
  clusterName = module.cluster.clusterName
  repositoryName = module.ecsService.apiServiceID
}