resource "shoreline_notebook" "mysql_service_unreachable_on_node" {
  name       = "mysql_service_unreachable_on_node"
  data       = file("${path.module}/data/mysql_service_unreachable_on_node.json")
  depends_on = [shoreline_action.invoke_start_mysql_service,shoreline_action.invoke_mysql_config_restart]
}

resource "shoreline_file" "start_mysql_service" {
  name             = "start_mysql_service"
  input_file       = "${path.module}/data/start_mysql_service.sh"
  md5              = filemd5("${path.module}/data/start_mysql_service.sh")
  description      = "Try to start mysql service if not already"
  destination_path = "/tmp/start_mysql_service.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_file" "mysql_config_restart" {
  name             = "mysql_config_restart"
  input_file       = "${path.module}/data/mysql_config_restart.sh"
  md5              = filemd5("${path.module}/data/mysql_config_restart.sh")
  description      = "Verify configuration settings: Ensure that the MySQL service is configured correctly on the node. Check the configuration files to ensure that the correct settings are in place."
  destination_path = "/tmp/mysql_config_restart.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_start_mysql_service" {
  name        = "invoke_start_mysql_service"
  description = "Try to start mysql service if not already"
  command     = "`chmod +x /tmp/start_mysql_service.sh && /tmp/start_mysql_service.sh`"
  params      = ["MYSQL_SERVICE_NAME"]
  file_deps   = ["start_mysql_service"]
  enabled     = true
  depends_on  = [shoreline_file.start_mysql_service]
}

resource "shoreline_action" "invoke_mysql_config_restart" {
  name        = "invoke_mysql_config_restart"
  description = "Verify configuration settings: Ensure that the MySQL service is configured correctly on the node. Check the configuration files to ensure that the correct settings are in place."
  command     = "`chmod +x /tmp/mysql_config_restart.sh && /tmp/mysql_config_restart.sh`"
  params      = ["MYSQL_SERVICE_NAME","PATH_TO_MYSQL_CONFIG_FILE"]
  file_deps   = ["mysql_config_restart"]
  enabled     = true
  depends_on  = [shoreline_file.mysql_config_restart]
}

