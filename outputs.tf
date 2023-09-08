output "instance_ip_addresses" {
  value = aws_instance.first_instance[*].public_ip
}

output "vault_test_output"{
    value = data.vault_generic_secret.instance_size_demo.data_json
    sensitive = true
}