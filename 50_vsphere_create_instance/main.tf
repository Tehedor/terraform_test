# Datos de vSphere (datacenter, datastore, red)
data "vsphere_datacenter" "dc" {
  name = var.vsphere_datacenter
}

data "vsphere_datastore" "ds" {
  name          = var.vsphere_datastore
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_network" "network" {
  name          = var.vsphere_network
  datacenter_id = data.vsphere_datacenter.dc.id
}

data "vsphere_resource_pool" "pool" {
  name          = var.vsphere_resource_pool
  datacenter_id = data.vsphere_datacenter.dc.id
}

# Crear la máquina virtual
resource "vsphere_virtual_machine" "haproxy_vm" {
  name             = "haproxy-vm"
  resource_pool_id = data.vsphere_resource_pool.pool.id
  datastore_id     = data.vsphere_datastore.ds.id

  num_cpus = 2
  memory   = 2048 # 2GB RAM

  network_interface {
    network_id = data.vsphere_network.network.id
  }

  disk {
    label            = "disk0"
    size             = 20 # 20GB
    eagerly_scrub    = false
    thin_provisioned = true
  }

  # Configuración de cloud-init para Ubuntu
  clone {
    template_uuid = data.vsphere_virtual_machine.template.id
  }

  # Script de cloud-init para instalar y configurar HAProxy + Keepalived
  customization {
    linux_options {
      host_name = "haproxy"
      domain    = "local"
    }

    user_data = <<-EOF
              #cloud-config
              package_upgrade: true
              packages:
                - haproxy
                - keepalived

              # Configuración de HAProxy
              write_files:
                - path: /etc/haproxy/haproxy.cfg
                  content: |
                    global
                      log /dev/log    local0
                      log /dev/log    local1 notice

                    defaults
                      log     global
                      mode    http
                      option  httplog
                      option  dontlognull
                      timeout connect 5000ms
                      timeout client 50000ms
                      timeout server 50000ms

                    frontend http_front
                      bind *:80
                      default_backend http_back

                    backend http_back
                      balance roundrobin
                      server server1 192.168.1.10:80 check
                      server server2 192.168.1.11:80 check

                # Configuración de Keepalived
                - path: /etc/keepalived/keepalived.conf
                  content: |
                    vrrp_instance VI_1 {
                      state MASTER
                      interface eth0
                      virtual_router_id 51
                      priority 100
                      advert_int 1
                      authentication {
                        auth_type PASS
                        auth_pass 1111
                      }
                      virtual_ipaddress {
                        192.168.1.200
                      }
                    }

              # Habilitar servicios
              runcmd:
                - systemctl enable haproxy
                - systemctl start haproxy
                - systemctl enable keepalived
                - systemctl start keepalived
              EOF
  }
}

# Referencia a la plantilla de Ubuntu
data "vsphere_virtual_machine" "template" {
  name          = var.vm_template
  datacenter_id = data.vsphere_datacenter.dc.id
}