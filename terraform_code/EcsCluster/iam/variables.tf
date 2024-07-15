variable "region" {
    description = "aws region needs to be set "
}
variable "clusterName" {
    description = "Cluster Name"
}
variable "accountID" {
    default = "xxxxx"
    description = "AWS AccountID to form Docker ARN"
}
variable "repositoryName" {
    default = "xxxx"
    description = "ECR repository name to form Docker ARN"
}