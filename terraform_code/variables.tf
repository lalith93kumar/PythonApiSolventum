variable "region" {
    description = "aws region needs to be set "
    default = "us-east-1"
}

variable "instanceEC2Type" {
    default = "t2.micro"
    description = "size of ec2 instance"
}

variable "clusterName" {
    default = "pt1"
    description = "Cluster Name"
}
