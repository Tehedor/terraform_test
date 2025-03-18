output "vsphere_connection_status" {
  description = "Estado de la conexión a vSphere"
  value       = "Conexión exitosa al datacenter: ${data.vsphere_datacenter.dc.name}"
}