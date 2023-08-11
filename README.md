# HashiCorp Vault Dynamic SSH Credential Injection for Boundary sessions

![HashiCorp Boundary Logo](https://www.hashicorp.com/_next/static/media/colorwhite.997fcaf9.svg)

## Overview

This repo demonstrates the integration between HashiCorp Vault and Boundary, which shows how dynamic, ephemeral SSH certifcates can be injected into SSH sessions, without there being any manual intervention.

## SSH Credential Injection using HCP Boundary & Vault

The SSH Credential Injection example in this repo has been setup as follows:

1. Configure HCP Boundary.
2. Configure HCP Vault.
3. Deploy a Boundary Worker in a public network.
4. Establish a connection between the Boundary Controller and the Boundary Worker.
5. Deploy a server instance in a public subnet and to trust Vault as the CA.
6. Configure Boundary to allow access to resources in the public network.
7. Create all the requisite Vault policies

<Note>The fact that this repo has a server resource residing in an public subnet and therefore having a public IP attached is not supposed to mimic a production environment. This is purely to demonstrate the integration between Boundary and Vault.</Note>

Your HCP Boundary and Vault Clusters needs to be created prior to executing the Terraform code. For people new to HCP, a trial can be utilised, which will give $50 credit to try, which is ample to test this solution.

## tfvars Variables

The following tfvars variables have been defined in a terraform.tfvars file.

- `boundary_addr`: The HCP Boundary address, e.g. "https://xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.boundary.hashicorp.
cloud"
- `auth_method_id`: "ampw_xxxxxxxxxx"                 
                 
- `password_auth_method_login_name`: = ""
- `password_auth_method_password`:   = ""
- `private_vpc_cidr`:                = ""
- `private_subnet_cidr`:             = ""
- `aws_vpc_cidr`:                    = ""
- `aws_subnet_cidr`:                 = ""
- `aws_access`:                      = ""
- `aws_secret`:                      = ""
