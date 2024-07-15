output "repositoryUrl" {
  value = data.aws_codecommit_repository.repo.clone_url_http
  description = "Repository Url from codeCommit"
}

output "repositoryName" {
  value = data.aws_codecommit_repository.repo.repository_name
  description = "Repository Name from codeCommit"
}