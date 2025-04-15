module "create_vm" {
  source = "./modules/00_create_vm"

  # Variables necesarias para el módulo
  vms                  = var.vms
  vm_vcpu              = var.vm_vcpu
  vm_memory            = var.vm_memory
  vm_disk_label        = var.vm_disk_label
  vm_disk_size         = var.vm_disk_size
  vm_disk_thin         = var.vm_disk_thin
  domain               = var.domain
  vm_ipv4_netmask      = var.vm_ipv4_netmask
  vm_dns_servers       = var.vm_dns_servers
  vm_ipv4_gateway      = var.vm_ipv4_gateway
  vsphere_template_name = var.vsphere_template_name
  vsphere_template_folder_name = var.vsphere_template_folder_name

  # Datos obtenidos de los data blocks
  vsphere_datacenter_id = data.vsphere_datacenter.dc01.id
  vsphere_cluster_id    = data.vsphere_compute_cluster.cluster.id
  vsphere_datastore_id  = data.vsphere_datastore.datastore.id
  vsphere_network_id    = data.vsphere_network.network.id
  vsphere_resource_pool_id = data.vsphere_resource_pool.custom_pool.id
}

module "create_ansible_inventory" {
  source = "./modules/05_create_ansible_inventory"

  # Variables necesarias para el módulo
  network_name = var.network_name
  subnet       = var.subnet

  # Datos obtenidos de los data blocks
  vsphere_network_id = data.vsphere_network.network.id
}