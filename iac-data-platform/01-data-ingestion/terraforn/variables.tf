variable "username" {
  description = "The username for the DB master user"
  type        = string
  sensitive   = true
}
variable "password" {
  description = "The password for the DB master user"
  type        = string
  sensitive   = true
}

variable "region" {
  description = "aws region"
  default     = "us-east-2"
}

variable "account_id" {
  description = "aws account id"
  default = 182201007062
}

variable "environment" {
  default = "dev"
}

variable "prefix" {
  description = "objects prefix"
  default     = "teamadpb"
}

# Prefix configuration and project common tags
locals {
  prefix = var.prefix
  common_tags = {
    Environment = "dev"
    Project     = "data_platform_aws"
  }
}

variable "bucket_names" {
  description = "s3 bucket names"
  type        = list(string)
  default = [
    "landing-zone",
   # "bronze-layer",
   # "silver-layer",
   # "gold-layer",
   # "kinesis-logs",
   # "scripts"
  ]
}