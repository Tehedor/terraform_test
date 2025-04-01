#Variables de las VMs
variable "vm_template_name" {
  description = "Template que vamos a utilizar para el despliegue de las VMs"
}

variable "vms" {
  type = map(any)
  description = "Lista de VMs que vamos a desplegar"
}

variable "vm_firmware" {
  description = "Firmware de las VMs"
}

variable "vm_vcpu" {
  description = "La cantidad de procesadores que se asignarán a las VMs"
  default = "2"
}

variable "vm_memory" {
  description = "La cantidad de memoria que se asignaran a las VMs (MB) "
  default = "1024"
}

variable "domain" {
  description = "Nombre de Dominio"
}

variable "vm_dns_servers" {
  description = "Lista de servidores DNS"
}

variable "vm_ipv4_netmask" {
  description = "Mascara de subred IPv4"
}

variable "ipv4_gateway" {
  description = "Gateway de las VMs"
}

variable "vm_disk_label" {
  description = "Etiqueta para los discos de las VMs"
}

variable "vm_disk_size" {
  description = "Tamano de discos de las VMs (GB)"
}

variable "vm_disk_thin" {
  description = "Tipo de disco de las VMs"
}