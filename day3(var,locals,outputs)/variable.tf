variable "enviroment" {
  default = "dev"
  type    = string
}
# export TF_VAR_enviroment=stage <-- in terminal to change the value of enviroment variable

variable "bucket_name" {
  default = "aungsaw-bucket-50"
  type    = string
}

variable "region" {
  default = "ap-southeast-1"
  type    = string

}
