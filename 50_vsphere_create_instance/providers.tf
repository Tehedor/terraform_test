# Configuración del proveedor de VMware
provider "vsphere" {
  user     = var.vsphere_user
  password = var.vsphere_password
  vsphere_server = var.vsphere_server
  # allow_unverified_ssl = true # Solo si usas certificados autofirmados
}