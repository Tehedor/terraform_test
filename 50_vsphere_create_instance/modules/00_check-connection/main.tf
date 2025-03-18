
# Data source para verificar acceso al datacenter
data "vsphere_datacenter" "dc" {
  name = "Datacenter" # Ajusta si tu datacenter tiene otro nombre
}