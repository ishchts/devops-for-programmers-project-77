terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

variable "yc_token" {}

variable "folder_id" {}

provider "yandex" {
  token = var.yc_token
  folder_id = var.folder_id
  zone  = "ru-central1-a"
}
