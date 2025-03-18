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