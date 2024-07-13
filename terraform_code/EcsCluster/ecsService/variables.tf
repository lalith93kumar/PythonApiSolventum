variable "region" {
    description = "aws region needs to be set "
}

variable "clusterName" {
}
variable "clusterId" {
}
variable "api_task_definition_id" {
}
variable "application_lb_arn" {
}
variable "application_security_group_ids" {
}
variable "private_subnet_ids" {
}
variable "api_lb_target_group_arn" {
}

variable "repositoryVersion" {
    default = "1.2.9"
}
