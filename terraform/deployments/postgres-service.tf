resource "kubernetes_service" "postgres-service" {
  metadata {
    name = "postgres-service"
    labels = {
      "app" = "postgres"
    }
  }
  spec {
    selector = {
      app = "postgres"
    }
    port {
      port        = 5432
      target_port = 5432
    }

    type = "NodePort"
  }
}
