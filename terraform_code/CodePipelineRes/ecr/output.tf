output "containerRepositoryUrl" {
  value = aws_ecr_repository.apiServiceRepository.repository_url
  description = "Repository Url from codeCommit"
}