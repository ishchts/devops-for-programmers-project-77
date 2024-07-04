resource "yandex_vpc_network" "network-project-3" {
  name = "network-project-3"
}

resource "yandex_vpc_subnet" "subnet-project-3" {
  name           = "subnet-project-3"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-project-3.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

