resource "aws_instance" "example" {
  ami           = "ami-f0768de6"
  instance_type = "t2.micro"

  subnet_id = "${aws_subnet.main-public-0.id}"
  vpc_security_group_ids = ["${aws_security_group.allow-ssh.id}"]
  key_name = "${var.AWS_KEY_PAIR_NAME}"

  tags {
    Owner = "owner"
    Name = "callstats-tokbox-app-1"
    ansibleFilter = "ansible"
    ansibleNodeType = "callstatsTokboxApp"
    ansibleNodeName = "callstats-tokbox-app-1"
  }

  provisioner "remote-exec" {
    inline = [ "sudo apt-get install -y python" ]
    connection {
      user = "ubuntu"
    }
  }
}
