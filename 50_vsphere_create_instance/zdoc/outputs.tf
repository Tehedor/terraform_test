output "vm_ip" {
  description = "IP de la máquina virtual"
  value       = vsphere_virtual_machine.haproxy_vm.default_ip_address
}

output "vip" {
  description = "IP virtual configurada en Keepalived"
  value       = "192.168.1.200"
}