variable "repositoryName" {
    description = "repository name"
    type = string
}

variable "s3BucketArn" {
    description = "arn s3 bucket for pipeline"
    type = string
}

variable "cloudWatchLogGroupArn" {
    description = "arn cloudWatch Arn for pipeline"
    type = string
}


variable "s3BucketTerraformBackupArn" {
    description = "arn s3 Arn for Terraform BackUp"
    type = string
}
variable "terraformLockDynmodbARN" {
    description = "arn s3 Arn for Terraform BackUp"
    type = string
}