resource "yandex_alb_target_group" "foo" {
  name = "my-target-group"

  target {
    ip_address = yandex_compute_instance.vm1-instance.network_interface.0.ip_address
    subnet_id = "${yandex_vpc_subnet.default.id}"
  }

  target {
    ip_address = yandex_compute_instance.vm2-instance.network_interface.0.ip_address
    subnet_id = "${yandex_vpc_subnet.default.id}"
  }
}

resource "yandex_alb_backend_group" "test-backend-group" {
  name = "my-backend-group"

  http_backend {
    name = "test-http-backend"
    target_group_ids = ["${yandex_alb_target_group.foo.id}"]
    weight = 1
    port = 3000
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout  = "1s"
      interval = "1s"
      http_healthcheck {
        path = "/"
      }
    }
  }
}

resource "yandex_alb_http_router" "tf-router" {
  name      = "my-http-router"
  # labels {
  #   tf-label    = "tf-label-value"
  #   empty-label = "s"
  # }
}

resource "yandex_alb_virtual_host" "lb-virtual-host" {
  name           = "project-3-virtual-host"
  http_router_id = yandex_alb_http_router.tf-router.id
  route {
    name = "project-3"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.test-backend-group.id
        timeout          = "3s"
      }
    }
  }
}


resource "yandex_alb_load_balancer" "test-balancer" {
  name        = "my-load-balancer"
  network_id  = yandex_vpc_network.default.id
  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.default.id 
    }
  }

  listener {
    name = "my-listener"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }
}