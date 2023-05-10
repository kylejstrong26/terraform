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
