variable "yandex_token" {
  type      = string
  sensitive = true
}
variable "yandex_cloud_id" {
  type      = string
  sensitive = true
}
variable "yandex_folder_id" {
  type      = string
  sensitive = true
}

variable "app_port" {
  type    = number
  default = 3000
}

variable "db_name" {
  type    = string
  default = "redmine"
}

variable "db_user" {
  type    = string
  default = "redmine"
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "admin_ssh_key" {
  type = string
}

variable "datadog_api_key" {
  type      = string
  sensitive = true
}
variable "datadog_app_key" {
  type      = string
  sensitive = true
}
variable "yandex_s3_key_id" {
  type      = string
  sensitive = true
}
variable "yandex_s3_secret_key" {
  type      = string
  sensitive = true
}
