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
    default = "1.2.57"
    type = string
}
