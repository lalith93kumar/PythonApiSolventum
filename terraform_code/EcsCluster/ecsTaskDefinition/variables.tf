variable "region" {
    description = "aws region needs to be set "
}

variable "clusterName" {
    default = "pt1"
    description = "The name of the ECS cluster"
    type        = string
}

variable "iam_arm" {
}

variable "repositoryVersion" {
    default = "1.2.9"
    description = "The version of the service"
    type        = string
}

variable "accountID" {
    default = "208383029138"
    description = "aws region needs to be set "
}

variable "repositoryName" {
    default = "PythonApiSolventum"
    description = "aws region needs to be set "
}