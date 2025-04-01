terraform {
  required_providers {
    vsphere = {
      source  = "hashicorp/vsphere"
      version = "~> 2.9" # La notación "~>" significa que cualquier versión a partir de la 5.69 es válida.
    }
    vault = {
      source  = "hashicorp/vault"
      version = "~> 4.4"
    }
  }
  required_version = "~> 1.9"
}

provider "vsphere" {
  user                 = data.vault_generic_secret.vsphere_secrets.data["user"]
  password             = data.vault_generic_secret.vsphere_secrets.data["password"]
  vsphere_server       = data.vault_generic_secret.vsphere_secrets.data["vsphere_server"]
  allow_unverified_ssl = true
}