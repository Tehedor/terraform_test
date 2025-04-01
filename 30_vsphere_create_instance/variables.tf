variable "vsphere_user" {
  description = "Usuario para conectarse a vSphere"
  type        = string
}

variable "vsphere_password" {
  description = "Contraseña para conectarse a vSphere"
  type        = string
  sensitive   = true
}


variable "vsphere_server" {
  description = "Dirección del servidor vSphere"
  type        = string
  
}

variable "vsphere_datacenter" {
  description = "Nombre del datacenter en vSphere"
  type        = string
}

variable "vsphere_computer_cluster" {
  description = "Nombre del clúster de computadoras en vSphere"
  type        = string
}

variable "vsphere_resource_pool" {
  description = "Nombre del pool de recursos en vSphere"
  type        = string
}

variable "vsphere_datastore" {
  description = "Nombre del datastore en vSphere"
  type        = string
}

variable "vsphere_network" {
  description = "Nombre de la red en vSphere"
  type        = string
}