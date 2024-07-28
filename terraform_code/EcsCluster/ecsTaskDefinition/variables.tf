variable "region" {
    description = "AWS Region to form Docker link"
    type = string
}
variable "clusterName" {
    description = "The name of the ECS cluster"
    type        = string
}
variable "iam_arm" {
    description = "Iam Execution role ARN attach to task definition"
    type = string
}
variable "repositoryVersion" {
    description = "Docker tag or API Version to form Docker link"
    type        = string
}
variable "accountID" {
    description = "AWS AccountID to form Docker link"
}
variable "repositoryName" {
    description = "ECR repository name to form Docker link"
    type = string
}