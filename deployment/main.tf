# Set terraform provider
provider "google" {
    project = var.project_id
    region = var.region
    # Service account credentials file
    credentials = "./cred.json"
}

# Create the bucket to save the static site in
resource "google_storage_bucket" "blog_bucket" {
    name = var.bucket_name
    location = var.region
    # We can use terraform to remove the bucket, even if there
    # are currently files in the bucket.
    force_destroy = true

    website {
        main_page_suffix = "index.html"
        not_found_page = "404.html"
    }
}


# Set the permissions of the bucket to public
resource "google_storage_bucket_iam_binding" "binding" {
  bucket = google_storage_bucket.blog_bucket.name
  role = "roles/storage.objectViewer"
  members = ["allUsers"]
}
