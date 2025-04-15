# Terraform configuration
data "template_file" "cloudinit" {
  template = file("${path.module}/cloud-config.yaml")
}

data "template_cloudinit_config" "config" {
  gzip          = true
  base64_encode = true

  part {
    filename     = "cloud-config.yaml"
    content_type = "text/cloud-config"
    content      = data.template_file.cloudinit.rendered
  }
}

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
    path         = var.vsphere_iso_path  # Asegúrate de usar un ISO con cloud-init
  }

  extra_config = {
    "efi.bootOrder.1" = "cdrom"
    "guestinfo.userdata" = data.template_cloudinit_config.config.rendered
    "guestinfo.userdata.encoding" = "gzip+base64"  # Necesario para decodificar en la VM
  }
}