# Install Spark Operator
# https://github.com/GoogleCloudPlatform/spark-on-k8s-operator
resource "helm_release" "spark_operator" {
  name       = "spark-operator"

  repository = "https://googlecloudplatform.github.io/spark-on-k8s-operator"
  chart      = "spark-operator"

  set {
    name  = "image.tag"
    value = "latest"
  }
}
