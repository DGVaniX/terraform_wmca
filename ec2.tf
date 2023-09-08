resource "aws_instance" "first_instance" {
  count           = var.instance_count
  ami             = data.aws_ami.ami_number.id
  instance_type   = var.instance_type
  security_groups = ["allow_tls"]
  tags = {
    Name        = "Instance_${count.index + 1}"
    Environment = lower(var.is_dev) == "yes" ? "Dev" : "Production"
  }

  key_name = "terraform_ssh_access" 
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = data.vault_generic_secret.instance_key.data["terraform_ssh_access"]
    host        = self.public_ip
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",         
      "sudo yum upgrade -y",       
      "sudo yum install nginx -y",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]
  }
}

resource "aws_eip" "fixed_ip" {
  count  = var.instance_count
  domain = "vpc"
}

resource "aws_eip_association" "eip_assoc" {
  count         = var.instance_count
  instance_id   = aws_instance.first_instance[count.index].id
  allocation_id = aws_eip.fixed_ip[count.index].id
}

resource "aws_security_group" "allow_tls" {
  name        = "allow_tls"
  description = "Allow SSH and HTTP/HTTPS traffic"

  dynamic "ingress" {
    for_each = var.ports_list
    content {
      description = ingress.value.name
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
      cidr_blocks = [var.cidr_block_for_ingress]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = [var.cidr_block_for_ingress]
    ipv6_cidr_blocks = ["::/0"]
  }
}

resource "local_file" "vault_test_output_file" {
  filename = "vault_test_output.txt"
  content  = data.vault_generic_secret.instance_size_demo.data_json
}