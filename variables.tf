variable "aws_region" {
  description = "AWS region for deploying infrastructure"
  type        = string
  default     = "eu-north-1"
}
variable "project_name" {
  description = "Project name"
  type        = string
  default     = "aws-secure-static-website"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}