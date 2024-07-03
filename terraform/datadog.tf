# provider "datadog" {
#   api_key = "YOUR_DATADOG_API_KEY"
#   app_key = "YOUR_DATADOG_APP_KEY"
# }

# resource "datadog_monitor" "cpu_high" {
#   name    = "CPU usage high on {{host.name}}"
#   type    = "metric alert"
#   query   = "avg(last_5m):avg:system.cpu.user{host:{{host.name}}} > 80"
#   message = "CPU usage is above 80% on {{host.name}}. @ops-team"
#   tags    = ["team:ops", "env:production"]

#   thresholds = {
#     critical = 80
#   }
# }
