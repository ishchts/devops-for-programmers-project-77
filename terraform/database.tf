resource "yandex_mdb_postgresql_cluster" "project-lvl3" {
  name        = "hexlet-project-lvl3-db"
  environment = "PRESTABLE"
  network_id  = yandex_vpc_network.network-project-3.id

  config {
    version = 12
    resources {
      resource_preset_id = "b2.micro"
      disk_type_id       = "network-ssd"
      disk_size          = 10
    }
    postgresql_config = {
      max_connections                   = 100
      enable_parallel_hash              = true
      vacuum_cleanup_index_scale_factor = 0.2
      autovacuum_vacuum_scale_factor    = 0.34
      default_transaction_isolation     = "TRANSACTION_ISOLATION_READ_COMMITTED"
      shared_preload_libraries          = "SHARED_PRELOAD_LIBRARIES_AUTO_EXPLAIN,SHARED_PRELOAD_LIBRARIES_PG_HINT_PLAN"
    }
  }

  maintenance_window {
    type = "WEEKLY"
    day  = "SAT"
    hour = 12
  }

  host {
    zone      = "ru-central1-a"
    subnet_id = yandex_vpc_subnet.subnet-project-3.id
  }
}

resource "yandex_mdb_postgresql_database" "project-lvl3" {
  cluster_id = yandex_mdb_postgresql_cluster.project-lvl3.id
  name       = var.db_name
  owner      = yandex_mdb_postgresql_user.redmine.name
  lc_collate = "en_US.UTF-8"
  lc_type    = "en_US.UTF-8"
}

resource "yandex_mdb_postgresql_user" "redmine" {
  cluster_id = yandex_mdb_postgresql_cluster.project-lvl3.id
  name       = var.db_user
  password   = var.db_password
}
