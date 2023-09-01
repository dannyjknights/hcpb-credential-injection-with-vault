/* Create a static host set for AWS Linux Machines. The hosts to be placed
within this host set are the public and private hosts, defined within the
host-catalog.tf configuration.
*/
# resource "boundary_host_set_static" "aws-linux-machines" {
#   name            = "aws-linux-machines"
#   description     = "Host set for AWS Linux Machines"
#   host_catalog_id = boundary_host_catalog_static.devops.id
#   # host_ids = [
#   #   boundary_host_static.amazon_public_linux.id,
#   #   boundary_host_static.amazon_private_linux.id,
#   # ]
# }

/* The below three resources create dynamic host sets. The attributes_json defines the tags that Boundary
will look for to automatically pull into Boundary as resources to access. The EC2 instances for this currently
reside within the aws-dhc-targets folder. The preferred_endpoints addresses need to be changed to use string
interpolation to reference them properly.
*/
resource "boundary_host_set_plugin" "aws-db" {
  name                  = "AWS DB Host Set Plugin"
  host_catalog_id       = boundary_host_catalog_plugin.aws_plugin.id
  preferred_endpoints   = ["cidr:0.0.0.0/0"]
  attributes_json       = jsonencode({ "filters" = "tag:service-type=database" })
  sync_interval_seconds = 30
}

resource "boundary_host_set_plugin" "aws-dev" {
  name                  = "AWS Dev Host Set Plugin"
  host_catalog_id       = boundary_host_catalog_plugin.aws_plugin.id
  preferred_endpoints   = ["cidr:0.0.0.0/0"]
  attributes_json       = jsonencode({ "filters" = "tag:application=dev" })
  sync_interval_seconds = 30
}

resource "boundary_host_set_plugin" "aws-prod" {
  name                  = "AWS Prod Host Set Plugin"
  host_catalog_id       = boundary_host_catalog_plugin.aws_plugin.id
  preferred_endpoints   = ["cidr:0.0.0.0/0"]
  attributes_json       = jsonencode({ "filters" = "tag:application=production" })
  sync_interval_seconds = 30
}
