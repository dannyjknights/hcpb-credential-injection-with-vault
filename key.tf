# RSA key of size 4096 bits
resource "tls_private_key" "rsa_4096_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "ec2-key"
  public_key = trim("${tls_private_key.rsa_4096_key.public_key_openssh}", "\n")


  provisioner "local-exec" {
    command = <<-EOT
    echo '${tls_private_key.rsa_4096_key.private_key_pem}' > ec2-key.pem
      chmod 400 ec2-key.pem
    EOT
  }
}