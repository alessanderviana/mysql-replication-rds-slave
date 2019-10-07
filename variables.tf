variable "region" {
  default = "us-east-1"
}
variable "aws_profile" {
  default = "alessander"
}
variable "vpc_id" {
  default = "vpc-e8c8cd93"  # VPC default
}
variable "subnet_id" {
  default = "subnet-5beb7c11"  # use1-az4
}
variable "ssh_key" {
  default = "~/repositorios/terraform/alessander-tf.pub"
}
