# resource "yandex_dns_zone" "zone1" {
#   name   = "project-3-dns-zone"
#   zone   = "botgate.ru."
#   public = true
# }

# resource "yandex_dns_recordset" "rs1" {
#   zone_id = yandex_dns_zone.zone1.id
#   name    = "botgate.ru."
#   type    = "A"
#   ttl     = 200
#   data    = [yandex_alb_load_balancer.lb-1.listener[0].endpoint[0].address[0].external_ipv4_address[0].address]
# }

# resource "yandex_dns_recordset" "rs2" {
#   zone_id = yandex_dns_zone.zone1.id
#   name    = "_acme-challenge.botgate.ru."
#   type    = "CNAME"
#   ttl     = 600
#   data    = ["fpqcihlrj0o9seas10ja.cm.yandexcloud.net."]
# }

# resource "yandex_dns_recordset" "rs3" {
#   zone_id = yandex_dns_zone.zone1.id
#   name    = "_acme-challenge.www.botgate.ru."
#   type    = "CNAME"
#   ttl     = 600
#   data    = ["fpqcihlrj0o9seas10ja.cm.yandexcloud.net."]
# }
