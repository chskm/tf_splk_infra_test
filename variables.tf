variable "ami_id" {}
variable "splk_hf_instance_type" {}
variable "instance_count" {}
variable "profile" {
  type    = string
  default = "default"
}
variable "tags" {
  type    = list
  default = ["HF1", "HF2"]
}
variable "region" {
  type    = string
  default = "us-east-1"
}
variable "subnet_1" {}
variable "subnet_2" {}
variable "vpc" {}
variable "rt_igw" {}
variable "external_ip" {}
variable "az_mapping" {
  description = "Mapping Availability zones"
  default = {
    "us-east-1" = "us-east-1a,us-east-1b"
  }
}
variable "hf_count" {}
variable "idx_count" {}
variable "key_name" {}