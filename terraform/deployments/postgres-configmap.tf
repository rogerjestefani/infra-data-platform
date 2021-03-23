resource "kubernetes_config_map" "postgres_configmap" {
  metadata {
    name = "postgres-config"
    labels = {
      "app" = "postgres"
    }
  }

  data = {
    "POSTGRES_DB" = "repodb"
    "POSTGRES_USER" = "admin"
    "POSTGRES_PASSWORD" = "admin123"
  }
}