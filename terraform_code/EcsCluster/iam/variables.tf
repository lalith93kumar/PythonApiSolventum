variable "region" {
    description = "aws region needs to be set "
    type = string
}
variable "clusterName" {
    description = "Cluster Name"
    type = string
}
variable "accountID" {
    default = "xxxxx"
    description = "AWS AccountID to form Docker ARN"
}
variable "repositoryName" {
    default = "xxxx"
    description = "ECR repository name to form Docker ARN"
    type = string
}