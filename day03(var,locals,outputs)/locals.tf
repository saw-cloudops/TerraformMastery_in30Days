locals {
  bucket_name = "${var.bucket_name}-bucket-${var.enviroment}"
}

locals {
  tag_name = var.enviroment
}
