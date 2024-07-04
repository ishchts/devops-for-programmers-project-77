output "webservers_ips" {
  value = [
    yandex_compute_instance.vm-1.network_interface[0].nat_ip_address,
    yandex_compute_instance.vm-2.network_interface[0].nat_ip_address
  ]
}
output "lb_ip" {
  value = yandex_alb_load_balancer.lb-1.listener[0].endpoint[0].address[0].external_ipv4_address[0].address
}

output "database_host" {
  value = yandex_mdb_postgresql_cluster.project-lvl3.host.0.fqdn
}
