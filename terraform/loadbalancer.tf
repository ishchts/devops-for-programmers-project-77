resource "yandex_alb_target_group" "foo" {
  folder_id = var.folder_id
  name = "my-target-group"

  target {
    ip_address = "${yandex_compute_instance.vm1-instance.network_interface.0.ip_address}"
    subnet_id = "${yandex_vpc_subnet.default.id}"
  }

  target {
    ip_address = "${yandex_compute_instance.vm2-instance.network_interface.0.ip_address}"
    subnet_id = "${yandex_vpc_subnet.default.id}"
  }
}

resource "yandex_alb_backend_group" "test-backend-group" {
  folder_id = var.folder_id
  name = "my-backend-group"

  http_backend {
    name = "test-http-backend"
    target_group_ids = ["${yandex_alb_target_group.foo.id}"]
    weight = 1
    port = 80
    load_balancing_config {
      panic_threshold = 50
    }
    healthcheck {
      timeout = "1s"
      interval = "1s"
      http_healthcheck {
        path  = "/"
      }
    }
    http2 = "true"
  }
}

resource "yandex_alb_http_router" "tf-router" {
  name      = "my-http-router"
  folder_id = var.folder_id
  # labels {
  #   tf-label    = "tf-label-value"
  #   empty-label = "s"
  # }
}

resource "yandex_alb_load_balancer" "test-balancer" {
  folder_id = var.folder_id
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
      ports = [ 80 ]
    }    
    http {
      handler {
        http_router_id = yandex_alb_http_router.tf-router.id
      }
    }
  }

  log_options {
    discard_rule {
      http_code_intervals = ["HTTP_2XX"]
      discard_percent = 75
    }
  }
}