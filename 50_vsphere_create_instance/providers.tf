# terraform {
#   required_providers {
#     vsphere = {
#       source  = "hashicorp/vsphere"
#       version = "~> 2.20.0" # Versión estable
#     }
#   }
# }

# Configuración del proveedor de VMware
provider "vsphere" {
  user           = var.vsphere_user
  password       = var.vsphere_password
  vsphere_server = var.vsphere_server
  # allow_unverified_ssl = true # Solo si usas certificados autofirmados
}