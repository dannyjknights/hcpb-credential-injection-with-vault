resource "aws_instance" "boundary_public_target" {
  ami               = "ami-09ee0944866c73f62"
  instance_type     = "t2.micro"
  availability_zone = "eu-west-2b"
  user_data_base64  = data.cloudinit_config.ssh_trusted_ca.rendered
  //key_name          = aws_key_pair.ec2_key.key_name
  //key_name = "boundary"


  network_interface {
    network_interface_id = aws_network_interface.boundary_public_target_ni.id
    device_index         = 0
  }
  tags = {
    Name         = "boundary-1-dev",
    service-type = "database",
    application  = "dev",
  }
}

resource "aws_network_interface" "boundary_public_target_ni" {
  subnet_id               = aws_subnet.boundary_ingress_worker_subnet.id
  security_groups         = [aws_security_group.static_target_sg.id]
  private_ip_list_enabled = false

}

//Configure the EC2 host to trust Vault as the CA
data "cloudinit_config" "ssh_trusted_ca" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/x-shellscript"
    content      = <<-EOF
    sudo curl -o /etc/ssh/trusted-user-ca-keys.pem \
    --header "X-Vault-Namespace: admin" \
    -X GET \
    ${var.vault_addr}/v1/ssh-client-signer/public_key
    sudo echo TrustedUserCAKeys /etc/ssh/trusted-user-ca-keys.pem >> /etc/ssh/sshd_config
    sudo systemctl restart sshd.service
    EOF

  }
}
