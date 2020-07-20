provider "google" {
    project = var.project_id
    region = var.region
}

resource "google_storage_bucket" "blog_bucket" {
    name = var.bucket_name
    location = var.region
    # We can use terraform to remove the bucket, even if there
    # are currently files in the bucket.
    force_destroy = true
}