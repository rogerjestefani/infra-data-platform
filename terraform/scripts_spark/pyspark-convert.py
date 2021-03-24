from pyspark import SparkContext
from pyspark.sql import SparkSession

sc = SparkContext(appName="spark-convert")

sc._jsc.hadoopConfiguration().set("fs.gs.impl", "com.google.cloud.hadoop.fs.gcs.GoogleHadoopFileSystem")
sc._jsc.hadoopConfiguration().set("fs.AbstractFileSystem.gs.impl", "com.google.cloud.hadoop.fs.gcs.GoogleHadoopFS")
sc._jsc.hadoopConfiguration().set("google.cloud.auth.service.account.enable", "true")

spark_session = SparkSession(sc).builder.getOrCreate()

df = spark_session.read.json('gs://dl_raw/raw_data.jsonl')

df.write.parquet('gs://dl_trust/curated.parquet', mode="overwrite")

sc.stop()