resource "yandex_compute_instance" "vm1-instance" {
  folder_id    = var.folder_id
  name         = "vm1"
  platform_id  = "standard-v1"
  zone         = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.vm1-default-disk.id
  }

  network_interface {
    # index  = 0
    subnet_id = yandex_vpc_subnet.default.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "yandex_compute_disk" "vm1-default-disk" {
  folder_id = var.folder_id
  name      = "vm1-disk-name"
  type     = "network-hdd"
  zone      = "ru-central1-a"
  image_id  = "fd83s8u085j3mq231ago"
  size = 10
  labels = {
    environment = "disk-vm-1"
  }
}

resource "yandex_compute_instance" "vm2-instance" {
  folder_id    = var.folder_id
  name         = "vm2"
  platform_id  = "standard-v1"
  zone         = "ru-central1-a"

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    disk_id = yandex_compute_disk.vm2-default-disk.id
  }

  network_interface {
    # index  = 0
    subnet_id = yandex_vpc_subnet.default.id
    nat = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }

  scheduling_policy {
    preemptible = true
  }

  timeouts {
    create = "30m"
    update = "30m"
    delete = "30m"
  }
}

resource "yandex_compute_disk" "vm2-default-disk" {
  folder_id = var.folder_id
  name      = "vm2-disk-name"
  type     = "network-hdd"
  zone      = "ru-central1-a"
  image_id  = "fd83s8u085j3mq231ago"
  size = 10
  labels = {
    environment = "disk-vm-2"
  }
}