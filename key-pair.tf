resource "aws_key_pair" "mysql-tf" {
  key_name = "key-pair-mysql"
  public_key = "${file("${var.ssh_key}")}"
}
