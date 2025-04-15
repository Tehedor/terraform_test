output "datastore_id" {
  value       = data.vsphere_datastore.datastore.id
  description = "ID del datastore principal"
}

output "vm_ips" {
  value       = { for vm_name, vm in vsphere_virtual_machine.vm : vm_name => vm.default_ip_address }
  description = "Direcciones IP de las máquinas virtuales"
}