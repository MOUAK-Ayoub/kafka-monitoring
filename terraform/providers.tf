provider "aws" {

  region  = var.region-monitoring
  //profile = var.profile
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  alias   = "region-monitoring"
}

