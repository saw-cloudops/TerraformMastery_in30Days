# resource "aws_s3_bucket" "ash_bucket" {
#   bucket = local.formatted_project_name

#   #acl    = "private"


#   tags = merge(local.tags, { Name = upper("aungsawhein") })
# }

resource "aws_instance" "ash_ec2" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = var.instance_type

  tags = {
    Name = "ash-ec2"
  }
}



