resource "aws_s3_bucket" "ash_bucket" {
  bucket = local.formatted_project_name
  #acl    = "private"


  tags = merge(local.tags, { Name = upper("aungsawhein") })
}

