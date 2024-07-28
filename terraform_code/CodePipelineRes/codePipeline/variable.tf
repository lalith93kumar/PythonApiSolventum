variable "codePipelineIamArn" {
  description = "code build Iam role -> arn"
  type = string
}

variable "repositoryUrl" {
  description = "Repository Url from codeCommit"
  type = string
}

variable "branch" {
  description = "Repository branch name"
  type = string
}


variable "repositoryName" {
  description = "Repository name"
  type = string
}


variable "DockerBuildProjectName" {
  description = "Code Build Project Name list"
  type = string
}

variable "s3BucketId" {
  description = "s3 artifact bucket ID"
}


variable "accountID" {
    description = "AWS AccountID"
}

variable "region" {
    description = "aws region needs to be set"
    type = string
}

variable "clusterName" {
    description = "Cluster Name"
    type = string
}