terraform {

  backend "s3" {
    bucket         = "terraform-bucket-1"
    key            = "terraform/consul/terraform.tfstate"
    region         = "ca-central-1"
    dynamodb_table = "terraform-table-1"
    encrypt        = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "ca-central-1"
}

resource "aws_route53_zone" "primary" {
  name = "kylestrongterraform.com"
}


variable "db_pass" {
  description = "password for database"
  type        = string
  sensitive   = true
}

locals {
  environment_name = "production"
}

module "web_app" {
  source = "../../main-module/web-app-module"

  # Input Variables
  bucket_prefix    = "web-app-data-${local.environment_name}"
  domain           = "kylestrongterraform.com"
  environment_name = local.environment_name
  instance_type    = "t2.micro"
  create_dns_zone  = false
  db_name          = "${local.environment_name}mydb"
  db_user          = "foo"
  db_pass          = var.db_pass
}

