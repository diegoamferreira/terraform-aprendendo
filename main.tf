terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias = "us-east-2" # Definindo um apelido para o provider/regiao
  region = "us-east-2"
}


# Create Bucker S3

resource "aws_s3_bucket" "dev4" {
  bucket = "buckettest-dev4"

  tags = {
    Prop = "Terraform"
    Name = "bucket_test-dev4"
  }
}


