data "aws_ami" "ami_number" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023*-kernel-*-x86_64"]
  }
}

data "vault_generic_secret" "instance_key" {
  path = "kv/aws_instance_key"
}

data "vault_generic_secret" "instance_size_demo" {
  path = "kv/instance_sizes"
}