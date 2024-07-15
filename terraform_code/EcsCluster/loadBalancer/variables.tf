variable "clusterName" {
    description = "Cluster Name"
}

variable "vpc_id" {
    description = "Add VPC ID to load balancer"
}

variable "security_group_ids" {
    description = "Add Security group IDS to load balancer"
}

variable "public_subnet_ids" {
    description = "Add Public Subnet IDS to load balancer"
}