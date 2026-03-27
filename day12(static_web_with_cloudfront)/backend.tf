terraform {
  backend "s3" {
    bucket = "my-terraform-state-bucket-piyushsachdeva"
    key    = "lessons/day12/terraform.tfstate"
    region = "us-east-1"
  }
}
