vsphere_user     = "your_user@vsphere.local"  # Reemplaza con tu usuario
vsphere_password = "your_password"           # Reemplaza con tu contraseña
vsphere_server   = "your_vsphere_server"     # Reemplaza con tu servidor vSphere

# Vsphere
vsphere_datacenter          = "your_datacenter"          # Reemplaza con tu datacenter
vsphere_compute_cluster     = "your_compute_cluster"     # Reemplaza con tu cluster
vsphere_resource_pool       = "your_resource_pool"       # Reemplaza con tu resource pool
vsphere_datastore           = "your_datastore"           # Reemplaza con tu datastore
vsphere_network             = "your_network"             # Reemplaza con tu red

# Template
vsphere_template_folder_name = "your_template_folder"    # Reemplaza con tu carpeta de templates
vsphere_template_name        = "your_template_name"      # Reemplaza con tu template

# VM
vm_firmware                = "efi"                       # Configuración del firmware
vm_vcpu                    = "4"                         # Número de CPUs
vm_memory                  = "4096"                      # Memoria en MB
domain                     = "your_domain.local"         # Reemplaza con tu dominio
vm_dns_servers             = ["8.8.8.8", "8.8.4.4"]      # Servidores DNS
vm_ipv4_netmask            = "24"                        # Máscara de red
vm_ipv4_gateway            = "your_gateway"              # Reemplaza con tu gateway
vm_disk_label              = "disk0"                     # Etiqueta del disco
vm_disk_size               = "30"                        # Tamaño del disco en GB
vm_disk_thin               = "true"                      # Thin provisioning (true/false)

vms = {
  example_vm = {
    name  = "your_vm_name"                               # Reemplaza con el nombre de la VM
    vm_ip = "your_vm_ip"                                 # Reemplaza con la IP de la VM
  },
}