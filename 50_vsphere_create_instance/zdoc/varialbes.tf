variable "vsphere_user" {
  description = "Usuario de vSphere"
  type        = string
}

variable "vsphere_password" {
  description = "Contraseña de vSphere"
  type        = string
  sensitive   = true
}

variable "vsphere_server" {
  description = "URL del servidor vSphere (ej: vcenter.local)"
  type        = string
}

variable "vsphere_datacenter" {
  description = "Nombre del datacenter en vSphere"
  type        = string
  default     = "Datacenter"
}

variable "vsphere_datastore" {
  description = "Nombre del datastore en vSphere"
  type        = string
  default     = "datastore1"
}

variable "vsphere_network" {
  description = "Nombre de la red en vSphere"
  type        = string
  default     = "VM Network"
}

variable "vsphere_resource_pool" {
  description = "Nombre del resource pool en vSphere"
  type        = string
  default     = "Resources"
}

variable "vm_template" {
  description = "Nombre de la plantilla Ubuntu en vSphere"
  type        = string
  default     = "ubuntu-template"
}