resource "datadog_monitor" "healthcheck" {
  name    = "Devops Project LVL3 healthcheck"
  type    = "service check"
  message = "Healthcheck failed from {{host.name}}"
  query   = "\"http.can_connect\".over(\"instance:devops_lvl3_project_status\").by(\"host\",\"instance\",\"url\").last(2).count_by_status()"
}
