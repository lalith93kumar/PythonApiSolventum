variable "region" {
    description = "aws region needs to be set "
    default = "us-east-1"
    type = string
}

variable "clusterName" {
    description = "Cluster Name"
    default = "pt1"
    type = string
}

variable "repositoryVersion" {
    description = "Cluster Name"
    type = string
}
