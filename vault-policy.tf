resource "vault_policy" "boundary_controller_policy" {
  name   = "boundary-controller"
  policy = <<EOT
path "auth/token/lookup-self" {
  capabilities = ["read"]
}

path "auth/token/renew-self" {
  capabilities = ["update"]
}

path "auth/token/revoke-self" {
  capabilities = ["update"]
}

path "sys/leases/renew" {
  capabilities = ["update"]
}

path "sys/leases/revoke" {
  capabilities = ["update"]
}

path "sys/capabilities-self" {
  capabilities = ["update"]
}
EOT
}

//This isn't required for injected credentials, but would be required for brokered
resource "vault_policy" "kv-policy" {
  name   = "kv-read"
  policy = <<EOT
path "kv/*" {
  capabilities = ["create", "read", "update", "delete", "list", "sudo"]
}
EOT
}

resource "vault_policy" "ssh-policy" {
  name   = "ssh-policy"
  policy = <<EOT
  path "ssh-client-signer/issue/boundary-client" {
  capabilities = ["create", "update"]
}

path "ssh-client-signer/sign/boundary-client" {
  capabilities = ["create", "update"]
}
EOT
}