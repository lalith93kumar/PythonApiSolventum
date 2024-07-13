variable "region" {
    default = "us-east-1"
    description = "aws region needs to be set "
}

variable "accountID" {
    default = "208383029138"
    description = "aws region needs to be set "
}

variable "repositoryName" {
    default = "PythonApiSolventum"
    description = "aws region needs to be set "
}

variable "projectList" {
  default = [{"name"="DockerBuild","specfile"="pipeline/buildspec_build.yml"},
  {"name"="TerraformPlan","specfile"="pipeline/buildspec_plan.yml"},
  {"name"="TerraformApply","specfile"="pipeline/buildspec_apply.yml"}
  ]
}

