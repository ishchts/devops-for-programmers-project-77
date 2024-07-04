resource "yandex_compute_instance" "vm-1" {
  name        = "web-prject-3-01"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa"
      size     = 30
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-project-3.id
    ip_address = "192.168.10.8"
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.admin_ssh_key}"
  }
}

resource "yandex_compute_instance" "vm-2" {
  name        = "web-prject-3-02"
  platform_id = "standard-v1"

  resources {
    cores         = 2
    memory        = 1
    core_fraction = 5
  }

  boot_disk {
    initialize_params {
      image_id = "fd80o2eikcn22b229tsa"
      size     = 30
    }
  }

  network_interface {
    subnet_id  = yandex_vpc_subnet.subnet-project-3.id
    ip_address = "192.168.10.9"
    nat        = true
  }

  metadata = {
    ssh-keys = "ubuntu:${var.admin_ssh_key}"
  }
}
