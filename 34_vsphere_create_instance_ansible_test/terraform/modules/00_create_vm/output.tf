module "00_create_vm" {
  source      = "./modules/00_create_vm"
  data = data
  vars = var
}

module "05_create_ansible_inventory" {
  source    = "./modules/05_create_ansible_inventory"
  data = data
  vars = var
}