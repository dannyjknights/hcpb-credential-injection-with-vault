# Data block to grab current IP and add into SG rules
data "http" "current" {
  url = "https://api.ipify.org"
}

# These SG rules need tidying up!
resource "aws_security_group" "static_target_sg" {
  name        = "SG for Boundary Public Static Target"
  description = "SG for Boundary Public Static Target"
  vpc_id      = aws_vpc.boundary_ingress_worker_vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_all"
  }
}

resource "aws_security_group" "boundary_ingress_worker_ssh" {
  name        = "boundary_ingress_worker_allow_ssh_9202"
  description = "SG for Boundary Ingress Worker"
  vpc_id      = aws_vpc.boundary_ingress_worker_vpc.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${data.http.current.response_body}/32"]
  }

  ingress {
    from_port   = 9202
    to_port     = 9202
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}

