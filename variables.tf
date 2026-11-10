variable "aws_region" {
  description = "AWS region for deploying infrastructure"
  type        = string
  default     = "eu-north-1"
}
variable "project_name" {
  description = "Name of the project, used as a prefix for resource names"
  type        = string
  default     = "aws-secure-static-website"
}

variable "environment" {
  description = "Deployment environment"
  type        = string
  default     = "dev"
}
