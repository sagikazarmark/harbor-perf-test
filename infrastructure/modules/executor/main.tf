data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["679593333241"]

  filter {
    name   = "name"
    values = ["ubuntu-minimal/images/hvm-ssd/ubuntu-focal-20.04-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_security_group" "this" {
  name_prefix = "${var.name}-test-executor"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

module "this" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.1"

  name = "${var.name}-test-executor"

  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_type
  key_name      = var.key_name
  subnet_id     = var.subnet_id

  vpc_security_group_ids = [aws_security_group.this.id]

  user_data = <<-EOT
#!/bin/bash

set -e

apt update
apt install -y git make dnsutils screen

# OS fine-tuning
# See https://k6.io/docs/misc/fine-tuning-os/
echo "ubuntu soft nofile 100000" >> /etc/security/limits.conf
echo "net.ipv4.ip_local_port_range=16384 65000" >> /etc/sysctl.conf

# Install Go
wget https://golang.org/dl/go${var.go_version}.linux-amd64.tar.gz -O /tmp/go.tar.gz
rm -rf /usr/local/go && tar -C /usr/local -xzf /tmp/go.tar.gz
export PATH=$PATH:/usr/local/go/bin
echo "export PATH=$PATH:/usr/local/go/bin" >> /home/ubuntu/.bashrc
echo "export PATH=$PATH:/usr/local/go/bin" >> /root/.bashrc

# Install k6
wget https://github.com/heww/xk6-harbor/releases/download/${var.k6_version}/k6-${var.k6_version}-linux-amd64.tar.gz -O /tmp/k6.tar.gz
tar -C /usr/local/bin -xzf /tmp/k6.tar.gz
chmod +x /usr/local/bin/k6

# Checkout the perf test repository
cd /home/ubuntu
git clone https://github.com/goharbor/perf.git
chown -R ubuntu.ubuntu perf/
cd -

# Setup test environment
echo 'export HARBOR_URL="${var.harbor_scheme}://${var.harbor_user}:${var.harbor_password}@${var.harbor_host}"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_SIZE="${var.harbor_size}"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_SCHEME="${var.harbor_scheme}"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_HOST="${var.harbor_host}"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_USERNAME="${var.harbor_user}"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_PASSWORD="${var.harbor_password}"' >> /home/ubuntu/.bashrc
echo 'export K6_CSV_OUTPUT="true"' >> /home/ubuntu/.bashrc
echo 'export K6_JSON_OUTPUT="true"' >> /home/ubuntu/.bashrc
echo 'export HARBOR_REPORT="true"' >> /home/ubuntu/.bashrc
EOT
}
