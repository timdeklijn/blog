---
title: "Creating This Blog"
date: 2020-07-17T12:56:33+02:00
draft: true
---

## What is Hugo?

## Install Hugo

``` sh
brew install hugo
```

create site

``` sh
hugo new site blog
```

adding a theme

``` sh
cd blog
git init
git submodule add <github-page-of-theme> themes/<theme-name>
```

Copy `theme.toml` into `config.toml` .

Add a new post

``` sh
hugo new posts/<name-of-post>.md
```
