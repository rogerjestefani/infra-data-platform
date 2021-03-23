# Install RabbitMQ
# https://github.com/rabbitmq/cluster-operator
data "kubectl_file_documents" "rabbitmq_manifest" {
    content = file("./manifests/rabbitmq/rabbitmq-operator.yaml")
}

resource "kubectl_manifest" "rabbitmq_manifest" {
    count     = length(data.kubectl_file_documents.rabbitmq_manifest.documents)
    yaml_body = element(data.kubectl_file_documents.rabbitmq_manifest.documents, count.index)
}

data "kubectl_file_documents" "rabbitmq_cluster" {
    content = file("./manifests/rabbitmq/rabbitmq-cluster.yaml")
}

resource "kubectl_manifest" "rabbitmq_cluster" {
    count     = length(data.kubectl_file_documents.rabbitmq_cluster.documents)
    yaml_body = element(data.kubectl_file_documents.rabbitmq_cluster.documents, count.index)
}
