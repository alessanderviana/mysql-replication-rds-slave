resource "aws_instance" "mysql-ubuntu" {
  ami           = "ami-07d0cf3af28718ef8"  # Ubuntu Server 18.04 LTS (us-east-1)
  instance_type = "t3.small"  # 2 vCPU, 2 GB RAM
  key_name = "${aws_key_pair.mysql-tf.id}"
  subnet_id = "${var.subnet_id}"

  depends_on = ["aws_security_group.sg_externo"]
  vpc_security_group_ids = ["${aws_security_group.sg_externo.id}",]

  associate_public_ip_address = true
  user_data = "${file("./startup-script.sh")}"

  tags {
    Name = "mysql-ubuntu"
  }

}
