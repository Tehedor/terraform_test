module "check_vsphere" {
  source = "../../modules/check-vsphere"

  vsphere_user     = var.vsphere_user
  vsphere_password = var.vsphere_password
  vsphere_server   = var.vsphere_server
}

# Crear la VM usando el módulo
module "vm_ubuntu" {
  source = "../../modules/vm-ubuntu"

  vm_name        = "haproxy-vm"
  vm_cpus        = 2
  vm_memory      = 2048
  vm_disk_size   = 20
  vm_hostname    = "haproxy"
  vm_domain      = "local"
  vm_user        = "ubuntu"
  ssh_public_key = file("~/.ssh/id_rsa.pub")
}

# Configurar HAProxy/Keepalived usando el módulo
module "configuracion" {
  source = "../../modules/configuracion"

  vm_ip            = module.vm_ubuntu.vm_ip
  vm_user          = "ubuntu"
  ssh_private_key  = "~/.ssh/id_rsa"
  backend_server1  = "192.168.1.10"
  backend_server2  = "192.168.1.11"
  keepalived_state = "MASTER"
  keepalived_priority = "100"
  keepalived_password = "secure_password"
  vip_address       = "192.168.1.200"
}

