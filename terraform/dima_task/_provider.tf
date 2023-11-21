terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "eu_london"
  region = "eu-west-2"
}

provider "aws" {
  alias  = "eu_paris"
  region = "eu-west-3"
}