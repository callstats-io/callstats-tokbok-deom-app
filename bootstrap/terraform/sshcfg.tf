####################
## Generate ssh.cfg
####################

# Generate ../ssh.cfg
data "template_file" "ssh_cfg" {
  template = "${file("${path.module}/template/ssh.cfg")}"
  depends_on = ["aws_instance.example"]
  vars {
    user = "ubuntu"

    example_ip = "${aws_instance.example.public_ip}"
  }
}

resource "null_resource" "ssh_cfg" {
  triggers {
    template_rendered = "${ data.template_file.ssh_cfg.rendered }"
  }
  provisioner "local-exec" {
    command = "echo '${ data.template_file.ssh_cfg.rendered }' > ./ssh.cfg"
  }
}
