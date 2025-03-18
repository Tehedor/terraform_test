# Crear la VM en vSphere
resource "vsphere_virtual_machine" "vm" {
  name             = var.vm_name
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = var.vm_cpus
  memory   = var.vm_memory

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = var.vm_disk_size
    thin_provisioned = true
  }

  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  # Configuración básica con cloud-init
  customization {
    linux_options {
      host_name = var.vm_hostname
      domain    = var.vm_domain
    }
    user_data = <<-EOF
              #cloud-config
              users:
                - name: ${var.vm_user}
                  sudo: ['ALL=(ALL) NOPASSWD:ALL']
                  ssh-authorized-keys:
                    - ${var.ssh_public_key}
              EOF
  }
}