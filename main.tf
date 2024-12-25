provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "data_bucket" {
  bucket = "my-data-bucket71189"
}

resource "aws_glue_catalog_database" "example" {
  name = "example_db"
}


resource "aws_glue_crawler" "example" {
  name          = "example-crawler"
  database_name = aws_glue_catalog_database.example.name
  role          = "arn:aws:iam::985539789378:role/AWSGlueServiceRole"
  s3_target {
    path = "s3://${aws_s3_bucket.data_bucket.bucket}/input/"
  }
}
resource "aws_glue_job" "example" {
  name     = "example-job"
  role_arn = "arn:aws:iam::985539789378:role/AWSGlueServiceRole"
  command {
    script_location = "s3://${aws_s3_bucket.data_bucket.bucket}/scripts/example.py"
    name            = "glueetl"
  }
}

