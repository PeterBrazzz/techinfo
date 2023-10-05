resource "kubernetes_config_map" "example" {
  metadata {
    name = "configmap"
  }

  data = {
    MYSQL_ROOT_PASSWORD = "petclinic"
    MYSQL_DATABASE = "petclinic"
  }
}
