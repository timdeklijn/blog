variable "project_id" {
    description = "Google Project ID."
    type = string
}

variable "bucket_name" {
    description = "GCS Bucket name"
    type = string
}


variable "region" {
    description = "GCP region"
    type = string
    default = "europe-west4"
}