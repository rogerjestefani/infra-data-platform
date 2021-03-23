resource "kubernetes_service_account" "spark_sa" {
  metadata {
    name = "spark-sa"
  }
}

resource "kubernetes_role_binding" "spark_role" {
  depends_on = [
    kubernetes_service_account.spark_sa    
  ]

  metadata {
    name      = "spark-role"
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "edit"
  }
  subject {
    kind      = "ServiceAccount"
    name      = "spark-sa"
    namespace = "default"
  }
}
