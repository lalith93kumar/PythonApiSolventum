variable "region" {
    description = "aws region needs to be set "
    default = "us-east-1"
}

variable "projectList" {
  default = [{"name"="ADockerBuild","specfile"="pipeline/buildspec_build.yml"},
  {"name"="BTerraformPlan","specfile"="pipeline/buildspec_plan.yml"},
  {"name"="CTerraformApply","specfile"="pipeline/buildspec_apply.yml"},
  {"name"="DMannual-approval"},
  {"name"="DTerraformDestroy","specfile"="pipeline/buildspec_destroy.yml"}]
}

variable "clusterName" {
    description = "Cluster Name"
    default = "pt1"
}