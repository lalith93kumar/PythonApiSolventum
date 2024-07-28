variable "region" {
    description = "aws region needs to be set "
    default = "us-east-1"
}

variable "projectList" {
  default = [{"name"="ADockerBuild","specfile"="pipeline/buildspec_build.yml","inputArtifacts"="source_artifact","outputArtifact"="build_artifacts"},
  {"name"="BTerraformPlan","specfile"="pipeline/buildspec_plan.yml","inputArtifacts"="build_artifacts","outputArtifact"="plan_artifacts"},
  {"name"="CTerraformApply","specfile"="pipeline/buildspec_apply.yml","inputArtifacts"="plan_artifacts","outputArtifact"="apply_artifacts"},
  {"name"="DMannualapproval"},
  {"name"="DTerraformDestroy","specfile"="pipeline/buildspec_destroy.yml","inputArtifacts"="apply_artifacts","outputArtifact"="destroy_artifacts"}]
}

variable "clusterName" {
    description = "Cluster Name"
    default = "pt1"
}