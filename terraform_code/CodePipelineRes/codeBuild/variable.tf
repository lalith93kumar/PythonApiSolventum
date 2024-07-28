variable "repositoryName" {
    description = "repository name"
    type = string
}

variable "codeBuildIamArn" {
  description = "code build Iam role -> arn"
  type = string
}

variable "branch" {
  description = "Repository branch name"
  type = string
}

variable "cloudWatchLogGroup" {
  description = "cloud watch log Group"
  type = string
}

variable "projectList" {
  default = []
}