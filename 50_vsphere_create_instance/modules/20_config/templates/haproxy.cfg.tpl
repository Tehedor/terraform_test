global
  log /dev/log    local0
  log /dev/log    local1 notice

defaults
  log     global
  mode    http
  option  httplog
  timeout connect 5000ms
  timeout client 50000ms
  timeout server 50000ms

frontend http_front
  bind *:80
  default_backend http_back

backend http_back
  balance roundrobin
  server server1 ${backend_server1}:80 check
  server server2 ${backend_server2}:80 check