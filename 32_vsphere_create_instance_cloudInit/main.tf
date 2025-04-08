
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
  extra_config = {
    "efi.bootOrder.1" = "cdrom"
    "guestinfo.userdata"     = base64encode(cloudinit_config.config.rendered)
    "guestinfo.userdata.encoding" = "base64"
  }

}


# Configuración de cloud-init
resource "cloudinit_config" "config" {
  gzip          = false
  base64_encode = true

  part {
    content_type = "text/cloud-config"
    content = yamlencode({
      hostname = "mi-ubuntu-server"

      users = [
        {
          name        = "miusuario"
          passwd      = "$6$example$xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
          sudo        = ["ALL=(ALL) NOPASSWD:ALL"]
          groups      = ["sudo", "users"]
          shell       = "/bin/bash"
        }
      ]

      package_update = true
      package_upgrade = true
      packages       = ["openssh-server", "curl"]

      runcmd = [
        "systemctl enable --now ssh",
      ]

      locale   = "es_ES.UTF-8"
      keyboard = ["es", "es"]
      timezone = "Europe/Madrid"
    })
  }
}