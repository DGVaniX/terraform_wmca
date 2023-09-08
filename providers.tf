provider "aws" {
  region     = var.the_region
  access_key = data.vault_generic_secret.instance_key.data["access_key"]
  secret_key = data.vault_generic_secret.instance_key.data["secret_key"]
}

provider "vault" {
    address = "https://terraform-demo-public-vault-c486b767.49bfad53.z1.hashicorp.cloud:8200"
    token = "hvs.CAESIAvrGvn28rjlsBY66Mw_RvCc47o-qHp7jvQr4QBHt21ZGicKImh2cy5RbXFMM0lPY01ETzQwd2ZyV0hiczFMUkIucHVqdWYQjgI"
}