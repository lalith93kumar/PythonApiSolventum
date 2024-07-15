output "containerRepositoryUrl" {
  value = aws_ecr_repository.apiServiceRepository.repository_url
  description = "Container ECR Repository Url"
}