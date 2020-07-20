+++
draft = true
date = 2020-07-17T12:56:33+02:00
title = "Creating This Blog"
description = ""
slug = "" 
tags = ["hugo","terraform","gcp"]
categories = []
externalLink = ""
series = []
+++

## What is Hugo?

Hugo is a static site generator with fast building times. It allows for pages to be written as Markdown and compiles these documents down to html. The reason I choose this framework is that it is fast, under active development and written in Go, a language I really like.

## Install Hugo

First install Hugo, for MacOS this can be done using [homebrew](https://brew.sh/):

``` sh
brew install hugo
```

## Create Website

The [Hugo Quickstart Guide](https://gohugo.io/getting-started/quick-start/) gives commands to create an initial website called "blog":

``` sh
hugo new site blog
```

adding a theme

``` sh
cd blog
git init
git submodule add <theme-repository> themes/<theme-name>
```

Copy `theme.toml` from the theme folder into `config.toml` in the main folder of the project.

Add a new post

``` sh
hugo new posts/<name-of-post>.md
```

When done editing the posts, run the following command to build the website:

``` sh
hugo
```

Hugo can move the static files to the bucket for you by using the `deploy` command. To configure this, add a deployment section to your `config.toml`:

``` toml
[deployment]
order = [".jpg$", ".gif$"]

[[deployment.targets]]
name = "gcp-deployment"
URL = "gs://<bucket-name>"

[[deployment.matchers]]
#  Cache static assets for 1 year.
pattern = "^.+\\.(js|css|svg|ttf)$"
cacheControl = "max-age=31536000, no-transform, public"
gzip = true

[[deployment.matchers]]
pattern = "^.+\\.(png|jpg)$"
cacheControl = "max-age=31536000, no-transform, public"
gzip = false

[[deployment.matchers]]
pattern = "^.+\\.(html|xml|json)$"
gzip = true
```

## Use terraform to publish blog to GCP

First make sure the `gcloud` the GCP-SDK is installed on your machine. Then run:

``` sh
gcloud auth login
```

Create a project on your personal GCP page by going to the GCP console and clicking on the project dropdown in the top left corner. Make sure you remember the project ID (which will be the project name, a dash and a number).

* Create service account key, this can be done by creating a service account for your project and downloading the kay as a `.json` .
* set the `GOOGLE_APPLICATION_CREDENTIALS` environment variable:

``` sh
export GOOGLE_APPLICATION_CREDENTIALS=<path-to-service-account-key>
```

## Terraform

``` terraform
provider "google" {
    project = var.project_id
    region = var.region
}

resource "google_storage_bucket" "blog_bucket" {
    name = var.bucket_name
    location = var.region
}
```

``` sh
terraform init
```

Plan the steps to create the resources:

``` sh
terraform plan --out 1.plan
```

Apply the steps, creating the resources.

``` sh
terraform apply 1.plan
```

Remove all created resources by:

``` sh
terraform destroy
```

# Deploy website

To finally deploy your website:

``` sh
hugo deploy
```