locals {
  repositoryName = basename(abspath("${path.module}/../.."))
}

module "currentAccount" {
    source = "./account"
}

module "ecr" {
    source = "./ecr"
    repositoryName = local.repositoryName
}

module "pipelineCloudWatch" {
    source = "./cloudWatch"
    repositoryName = local.repositoryName
}

module "ArtifactoryBucket" {
    source = "./s3"
    repositoryName = local.repositoryName
}

module "iamRole" {
    source = "./iam"
    repositoryName = local.repositoryName
    s3BucketArn = module.ArtifactoryBucket.s3BucketArn
    cloudWatchLogGroupArn = module.pipelineCloudWatch.cloudWatchLogGroupArn
    s3BucketTerraformBackupArn = module.ArtifactoryBucket.s3BucketTerraformBackupArn
}

module "CodeBuildProjectsDockerBuild" {
    source = "./codeBuild"
    branch = "master"
    repositoryName = local.repositoryName
    codeBuildIamArn = module.iamRole.codeBuildIamArn
    cloudWatchLogGroup = module.pipelineCloudWatch.cloudWatchLogGroupName
    projectList = var.projectList
}

module "CodePipelineProjectsDockerBuild" {
    source = "./codePipeline"
    repositoryUrl = "lalith93kumar/${local.repositoryName}"
    branch = "master"
    repositoryName = local.repositoryName
    codePipelineIamArn = module.iamRole.codePipelineIamArn
    s3BucketId = module.ArtifactoryBucket.s3BucketId
    DockerBuildProjectName = toset(module.CodeBuildProjectsDockerBuild.DockerBuildProjectName)
    accountID = module.currentAccount.accountId
    region = var.region
    clusterName = var.clusterName
}