---
title: "Creating This Blog"
date: 2020-07-17T12:56:33+02:00
draft: true
---

## What is Hugo?

Hugo is a static site generator with fast building times. It allows for pages to be written as Markdown and compiles these documents down to html. The reason I choose this framework is that it is fast, under active development and written in Go, a language I really like.

## Install Hugo

First install Hugo, for MacOS this can be done using [homebrew](https://brew.sh/):

``` sh
brew install hugo
```

## Create Website

The [Hugo Quickstart Guide](https://gohugo.io/getting-started/quick-start/) gives commands to create an initial website:

``` sh
hugo new site blog
```

adding a theme

``` sh
cd blog
git init
git submodule add <theme-repository> themes/<theme-name>
```

Copy `theme.toml` into `config.toml` .

Add a new post

``` sh
hugo new posts/<name-of-post>.md
```
