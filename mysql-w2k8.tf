resource "aws_instance" "mysql-w2k8" {
  ami           = "ami-0499f7700e0d63cf7"  # Microsoft Windows Server 2008 R2 Base
  instance_type = "t3.medium"  # 2 vCPU, 4 GB RAM
  key_name = "${aws_key_pair.mysql-tf.id}"
  subnet_id = "${var.subnet_id}"

  depends_on = ["aws_security_group.sg_externo"]
  vpc_security_group_ids = ["${aws_security_group.sg_externo.id}",]

  associate_public_ip_address = true
  user_data = "${file("./startup-script.ps1")}"

  tags {
    Name = "mysql-w2k"
  }

}
