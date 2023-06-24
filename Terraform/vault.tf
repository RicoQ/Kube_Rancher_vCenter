provider "vault" {
  address   = var.vault_url
  token     = var.vault_token
  skip_tls_verify = true

  #auth_login {
  #  path = "auth/approle/role/iac"
  #
  #  parameters = {
  #    role_id   = "c22aa8d1-a199-3294-b1a7-e08a90dd6f95"
  #    secret_id = "8de2de4b-04c6-738e-37eb-045734d6160c"
  #  }
  #}
}

data "vault_generic_secret" "vcenter_secret" {
  path = var.vcenter_path
}

data "vault_generic_secret" "esxi_secret" {
  path = var.esxi_path
}

data "vault_generic_secret" "ssh_secret" {
  path = var.ssh_path
}

data "vault_generic_secret" "ftp_secret" {
  path = var.ftp_path
}