 resource "aws_s3_bucket" "ash-first-bucket" {
  count  = var.counter #instance of var.counter-->#2 #count = length(var.bucket_name)
  bucket = var.bucket_name1[count.index] #<-- var.bucket_name[0], var.bucket_name[1]
  region = var.region
  tags = local.common_tags
} 

resource "aws_s3_bucket" "ash-second-bucket" {
  #for_each = toset(var.bucket_name) #<-- var.bucket_name[0], var.bucket_name[1]
  for_each = var.bucket_name2
  bucket   = each.value             #<-- var.bucket_name[0], var.bucket_name[1]
  region   = var.region
  tags     = local.common_tags
  depends_on = [ aws_s3_bucket.ash-first-bucket ]
}

/* resource "aws_s3_bucket" "prod_buckets" {
  for_each = var.buckets
  bucket   = each.value

  tags = {
    Name = each.key
  }
} */

