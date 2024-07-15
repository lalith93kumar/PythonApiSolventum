variable "clusterName" {
    description = "ECS cluster Name"
}
variable "clusterId" {
    description = "ECS cluster ID"
}
variable "api_task_definition_id" {
    description = "Api Task Definition ID Flask APP"
}
variable "application_lb_arn" {
    description = "Load Balancer attach to API Service"
}
variable "application_security_group_ids" {
    description = "Attach API service to Security Group."
}
variable "private_subnet_ids" {
    description = "Attach API service to Private Subnet."
}
variable "api_lb_target_group_arn" {
    description = "Load Balancer Target group to listen to port 5000 API Service"
}
variable "repositoryVersion" {
    description = "Docker Tag Or API Version."
}
