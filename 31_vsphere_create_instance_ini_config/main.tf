# Creación de las Máquinas Virtuales
resource "vsphere_virtual_machine" "vm" {
  for_each   = var.vms
  name       = each.value.name
  resource_pool_id = data.vsphere_resource_pool.custom_pool.id
  datastore_id     = data.vsphere_datastore.datastore.id

  num_cpus         = var.vm_vcpu
  memory           = var.vm_memory
  guest_id         = "ubuntu64Guest"
  firmware         = var.vm_firmware
  efi_secure_boot_enabled = false

  network_interface {
    network_id   = data.vsphere_network.network.id
    adapter_type = "vmxnet3"
  }

  disk {
    label            = var.vm_disk_label
    size             = var.vm_disk_size
    thin_provisioned = var.vm_disk_thin
  }

  cdrom {
    datastore_id = data.vsphere_datastore.iso_datastore.id
    path         = var.vsphere_iso_path
  }

    # Segundo CD-ROM: Archivo Preseed Local
  cdrom {
    client_device = true
    path          = "preseed.cfg"
    datastore_id  = null # No se usa porque es un archivo local
    content       = file("${path.module}/pressed/preseed.cfg") # Lee el archivo local
  }

  # Configuración adicional para usar Preseed
  extra_config = {
    "efi.bootOrder.1" = "cdrom"
    "bios.bootDevice" = "cdrom"
    "kernelopt"       = "auto"
  }

}