resource "boundary_target" "aws" {
  type                     = "ssh"
  name                     = "aws-ec2"
  description              = "AWS EC2 Targets"
  egress_worker_filter     = " \"sm-ingress-upstream-worker1\" in \"/tags/type\" "
  scope_id                 = boundary_scope.project.id
  session_connection_limit = -1
  default_port             = 22
  host_source_ids = [
    boundary_host_set_plugin.aws-db.id,
    boundary_host_set_plugin.aws-dev.id,
    boundary_host_set_plugin.aws-prod.id,
  ]
  injected_application_credential_source_ids = [boundary_credential_library_vault_ssh_certificate.vault_ssh_cert.id]
  //injected_application_credential_source_ids = [boundary_credential_library_vault.vault_cred_lib.id]
}