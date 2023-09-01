//Create a periodic, orphan token for Boundary with the attached policies
resource "vault_token" "boundary_vault_token" {
  display_name = "boundary-token"
  policies     = ["boundary-controller", "ssh-policy"]
  no_parent    = true
  renewable    = true
  ttl          = "24h"
  period       = "24h"
}

//Credential Library for Brokered Credentials
resource "boundary_credential_library_vault" "vault_cred_lib" {
  name                = "boundary-vault-credential-library"
  description         = "Vault SSH private key credential"
  credential_store_id = boundary_credential_store_vault.vault_cred_store.id
  path                = "kv/data/credentials/ssh_injection"
  http_method         = "GET"
  credential_type     = "ssh_private_key"
}

//Credential store for Vault
resource "boundary_credential_store_vault" "vault_cred_store" {
  name        = "boudary-vault-credential-store"
  description = "Vault Credential Store"
  address     = var.vault_addr
  token       = vault_token.boundary_vault_token.client_token
  namespace   = "admin"
  scope_id    = boundary_scope.project.id

  depends_on = [vault_token.boundary_vault_token]
}

//Credential library for SSH injected credentials
resource "boundary_credential_library_vault_ssh_certificate" "vault_ssh_cert" {
  name                = "ssh-certs"
  description         = "Vault SSH Cert Library"
  credential_store_id = boundary_credential_store_vault.vault_cred_store.id
  path                = "ssh-client-signer/sign/boundary-client"
  username            = "ec2-user"
}

# resource "boundary_credential_library_vault_ssh_certificate" "vault_ssh_cert_danny" {
#   name                = "ssh-certs-danny"
#   description         = "Vault SSH Cert Library"
#   credential_store_id = boundary_credential_store_vault.vault_cred_store.id
#   path                = "ssh-client-signer/sign/boundary-client"
#   username            = "danny"
# }

//A native Boundary static credential store
resource "boundary_credential_store_static" "static_cred_store" {
  name        = "static_credential_store"
  description = "Boundary Static Credential Store"
  scope_id    = boundary_scope.project.id
}

//A native username/password in Boundary
resource "boundary_credential_username_password" "static_cred_userpass" {
  name                = "username_password"
  description         = "Boundary username password credential"
  credential_store_id = boundary_credential_store_static.static_cred_store.id
  username            = "username"
  password            = "supersafepassword"
}