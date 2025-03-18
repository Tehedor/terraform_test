# Usar provisionador para copiar archivos y ejecutar scripts
resource "null_resource" "config" {
  connection {
    type        = "ssh"
    host        = var.vm_ip
    user        = var.vm_user
    private_key = file(var.ssh_private_key)
  }

  # Copiar archivos de configuración
  provisioner "file" {
    source      = "templates/haproxy.cfg.tpl"
    destination = "/tmp/haproxy.cfg"
  }

  provisioner "file" {
    source      = "templates/keepalived.conf.tpl"
    destination = "/tmp/keepalived.conf"
  }

  # Ejecutar script de configuración
  provisioner "remote-exec" {
    inline = [
      "sudo mv /tmp/haproxy.cfg /etc/haproxy/haproxy.cfg",
      "sudo mv /tmp/keepalived.conf /etc/keepalived/keepalived.conf",
      "sudo systemctl restart haproxy",
      "sudo systemctl restart keepalived",
    ]
  }
}