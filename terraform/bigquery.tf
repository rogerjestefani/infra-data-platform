resource "google_bigquery_table" "dataset_table" {
  deletion_protection = false
  dataset_id = google_bigquery_dataset.dataset.dataset_id
  table_id   = "dataset_table"
  schema = <<EOF
[
  {
    "name": "id",
    "type": "STRING",
    "mode": "NULLABLE"
  },
  {
    "name": "contents",
    "type": "STRING",
    "mode": "NULLABLE"
  }
]
EOF
}

resource "google_bigquery_dataset" "dataset" {
  depends_on = [
    null_resource.upload_folder_content
  ]

  dataset_id                  = "dataset"
  friendly_name               = "dataset"
  description                 = "This is a dataset description"
  location                    = "US"

  access {
    role          = "OWNER"
    user_by_email = google_service_account.bigquery_sa.email
  }

  access {
    role          = "roles/bigquery.admin"
    user_by_email = var.infra_sa
  }
}

resource "google_bigquery_job" "job_load" {
  depends_on = [
    google_bigquery_dataset.dataset,
    google_bigquery_table.dataset_table
  ]

  job_id     = "job_load_v1"

  load {
    source_uris = [
      "gs://${google_storage_bucket.raw_data.name}/raw_data.jsonl",
    ]

    source_format = "NEWLINE_DELIMITED_JSON"

    destination_table {
      project_id = google_bigquery_table.dataset_table.project
      dataset_id = google_bigquery_table.dataset_table.dataset_id
      table_id   = google_bigquery_table.dataset_table.table_id
    }

    create_disposition = "CREATE_IF_NEEDED"
    write_disposition = "WRITE_TRUNCATE"
    autodetect = true
  }
}