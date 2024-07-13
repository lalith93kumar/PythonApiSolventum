output "DockerBuildProjectName" {
  # value = aws_codebuild_project.dockerBuildProject.name
  value = [ for i in aws_codebuild_project.dockerBuildProject: "${i.name}"]
  description = "Repository Url from codeCommit"
}