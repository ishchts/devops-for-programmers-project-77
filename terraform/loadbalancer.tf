resource "yandex_alb_target_group" "lb_target_group" {
  name = "target-group-project-3"

  target {
    subnet_id  = yandex_vpc_subnet.subnet-project-3.id
    ip_address = yandex_compute_instance.vm-1.network_interface.0.ip_address
  }

  target {
    subnet_id  = yandex_vpc_subnet.subnet-project-3.id
    ip_address = yandex_compute_instance.vm-2.network_interface.0.ip_address
  }
}

resource "yandex_alb_backend_group" "lb-backend-group" {
  name = "backend-group-project-3"

  http_backend {
    name             = "project-3-http-backend"
    weight           = 1
    port             = var.app_port
    target_group_ids = [yandex_alb_target_group.lb_target_group.id]
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

resource "yandex_alb_load_balancer" "lb-1" {
  name       = "project-3-lb"
  network_id = yandex_vpc_network.network-project-3.id
  allocation_policy {
    location {
      zone_id   = "ru-central1-a"
      subnet_id = yandex_vpc_subnet.subnet-project-3.id
    }
  }

  listener {
    name = "project-3-listener-http"
    endpoint {
      address {
        external_ipv4_address {
        }
      }
      ports = [80]
    }
    http {
      handler {
        http_router_id = yandex_alb_http_router.lb-router.id
      }
    }
  }

  # listener {
  #   name = "project-3-listener-https"
  #   endpoint {
  #     ports = [443]
  #     address {
  #       external_ipv4_address {
  #       }
  #     }
  #   }

  #   tls {
  #     default_handler {
  #       certificate_ids = ["fpqcihlrj0o9seas10ja"]

  #       http_handler {
  #         http_router_id = yandex_alb_http_router.lb-router.id
  #       }
  #     }
  #   }
  # }
}

resource "yandex_alb_http_router" "lb-router" {
  name = "project-3-http-router"
}

resource "yandex_alb_virtual_host" "lb-virtual-host" {
  name           = "project-3-virtual-host"
  http_router_id = yandex_alb_http_router.lb-router.id
  route {
    name = "project-3"
    http_route {
      http_route_action {
        backend_group_id = yandex_alb_backend_group.lb-backend-group.id
        timeout          = "3s"
      }
    }
  }
}
