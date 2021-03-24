#!/bin/bash

bq query --use_legacy_sql=false \
'SELECT * 
    FROM `'${GOOGLE_CLOUD_PROJECT}'.dataset.dataset_table` LIMIT 100
'