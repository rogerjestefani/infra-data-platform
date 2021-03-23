resource "kubernetes_deployment" "postgres_db" {

  depends_on = [
    kubernetes_config_map.postgres_configmap
  ]

  metadata {
    name = "postgres"
  }
  spec {
    replicas = 1
    selector {
      match_labels = {
        app = "postgres"
      }
    }
    template {
      metadata {
        labels = {
          app = "postgres"
        }
      }
      spec {
        container {
          image = "postgres:12"
          name  = "postgres"
          port {
            container_port = 5432
          }
          env_from {
            config_map_ref {
              name = "postgres-config"
            }
          }

          resources {
            limits = {
              cpu    = "2"
              memory = "4096Mi"
            }
            requests = {
              cpu    = "2"
              memory = "4096Mi"
            }
          }
        }
      }
    }
  }
}
