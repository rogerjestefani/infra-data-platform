# Infraestrutura Plataforma de Dados GCP

A arquitetura GCP no diagrama abaixo apresenta uma infraestrutura para aproveitar os melhores recursos e soluções disponíveis para trabalhar com um grande fluxo de dados.

![Diagrama Plataforma de dados na GCP  ](image/gcp-data-platform.png "Diagrama Plataforma de dados na GCP")

O diagrama mostra o fluxo de dados possíveis (com o devido permissões no controle de acessos) apresentando através das flechas (arrows) os caminho que os dados podem percorrer e como podem ser acessados utilizando dos serviços de REST API, stream, batch e Analytics Tools e aonde cada ferramenta acessaria sobre as camadas do Datalake.

Utilizando recursos de segurança de acessos fornecido pela Google (IAM, VPN, IAP) serviços que utilizem poder computacional (VMs, Kubernetes) serão criados dentro de VPCs privadas, seguindo regras de firewall e segmentação da rede, impedindo acesso via IPs externos. Para o acesso desses serviços é necessário uma VPN ou IAP para cada usuário e possivelmente a criação de um Bastion (Controle de acessos via SSH) onde o usuário deve fornecer uma chave publica SSH para infra para poder alcançar serviços internos. Controle de acessos diretos ao Datalake (GCS) e ao BigQuery podem ser garantidos utilizando o próprio Cloud IAM.

## Datalake

| Camada  | Descrição |
| ------- | ----------- |
| Stage   | Dados temporários ou não estruturados que serão ajustados pra camada de "Raw". |
| Raw     | Camada onde esta armazenado dados estruturados e semi estruturados com metadados. |
| Trust   | Camada armazena dados curados da camada de "Raw"com formatos de arquivo otimizado para Big Data. (Parquet, ORC, AVRO) |
| Sandbox | Local onde os usuários possam criar e salvar seus estudos e testes. |
| Refined | Local onde usuários guardam dados refinados, features e resultados de modelos pra alimentar a plataforma. |

## BigQuery

Formatos:

- CSV
- JSON
- PARQUET
- AVRO
- ORC



## Pré-requisito

Para subir o projeto deve ter instalados no seu terminal os seguintes softwares:

- Google Cloud SDK (gcloud, gsutil)
- terraform (Versão: 0.14)
- kubectl 

## Estrutura Projeto (Terraform)

```sh
terraform
├── deployments
│   ├── manifests
│   │   └── rabbitmq
│   │       ├── rabbitmq-cluster.yaml
│   │       └── rabbitmq-operator.yaml
│   ├── helm.tf
│   ├── main.tf
│   ├── postgres-configmap.tf
│   ├── postgres-service.tf
│   ├── postgres.tf
│   ├── rabbitmq.tf
│   ├── roles.tf
├── bastion.tf
├── bigquery.tf
├── datalake.tf
├── firewall.tf
├── gke.tf
├── iam.tf
├── main.tf
├── network.tf
├── terraform.tfvars
└── variables.tf
```
## Criação Da infraestrutura

```sh
$ vi terraform/terraform.tfvars
```

```
# PROJECT ID
project_id="<PROJETO ID>"
```

Entre no console da Google Cloud e crie um Service Account com Perfil "Editor". Ele vai ser responsavel por criar a infraestrutura de seu projeto.

```sh
$ export GOOGLE_CREDENTIALS='infra-sa.json'
```

```sh
$ cd terraform
$ terraform init
```


```sh
$ terraform plan
$ terraform apply
```

## Deploy Serviços

```sh
$ cd terraform/deployments
$ terraform init
```

```sh
$ terraform plan
$ terraform apply
```

# SSH TUNNEL

 $ gcloud beta compute ssh example-instance --zone=us-central1-a -- \
            -vvv -L 80:%INSTANCE%:80

gcloud beta compute ssh --zone "us-east1-b" "bastion" --tunnel-through-iap --project "abiding-window-307913" -- -vnNT -L 8443:10.5.0.2:443


# GKE Credenciais Acesso

gcloud container clusters get-credentials gke-cluster --zone us-east1-b --project abiding-window-307913

kubectl config set-cluster "gke-cluster-local" --insecure-skip-tls-verify=true --server="https://127.0.0.1:8443"
kubectl config set-context "gke-cluster-local" --cluster="gke-cluster-local" --user="gke_abiding-window-307913_us-east1-b_gke-cluster"
kubectl config use-context "gke-cluster-local"

