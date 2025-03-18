vrrp_instance VI_1 {
  state ${keepalived_state}
  interface eth0
  virtual_router_id 51
  priority ${keepalived_priority}
  advert_int 1
  authentication {
    auth_type PASS
    auth_pass ${keepalived_password}
  }
  virtual_ipaddress {
    ${vip_address}
  }
}