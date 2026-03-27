# # ၁။ IPAM Scope အရင်ဆောက်မယ်
# resource "aws_vpc_ipam" "main" {
#   operating_regions {
#     region_name = var.region
#   }
# }

# # ၂။ Top-level Pool ဆောက်မယ်
# resource "aws_vpc_ipam_pool" "top_level" {
#   address_family = "ipv4"
#   ipam_scope_id  = aws_vpc_ipam.main.private_default_scope_id
# }

# # ၃။ အဲဒီ Pool ထဲကို IP Range ထည့်မယ်
# resource "aws_vpc_ipam_pool_cidr" "top_level_cidr" {
#   ipam_pool_id = aws_vpc_ipam_pool.top_level.id
#   cidr         = var.cidr_block[0]
# }

# # ၄။dev Environmentအတွက် Sub-pool (Pool အသေး) ထပ်ခွဲမယ်
# resource "aws_vpc_ipam_pool" "dev_pool" {
#   address_family      = "ipv4"
#   ipam_scope_id       = aws_vpc_ipam.main.private_default_scope_id
#   source_ipam_pool_id = aws_vpc_ipam_pool.top_level.id # Top pool ကနေ ခွဲယူတာ
#   description         = "dev Environment Pool"
# }

# #creating_vpc_from_ipam
# resource "aws_vpc" "dev_vpc" {
#   # CIDR Block ကို လက်နဲ့ မပေးတော့ဘူး
#   ipv4_ipam_pool_id    = aws_vpc_ipam_pool.dev_pool.id
#   ipv4_netmask_length  = 24 # "ငါ့ကို /24 range တစ်ခု အလွတ်ပေးပါ" လို့ ခိုင်းတာ
#   enable_dns_hostnames = true
#   enable_dns_support   = true
#   tags = {
#     Name = "dev-vpc-from-ipam"
#   }
# }



