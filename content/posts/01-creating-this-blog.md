+++
draft = false
date = 2020-08-05T15:16:33+02:00
title = "Creating This Blog"
description = ""
slug = "" 
tags = ["hugo","github"]
categories = ["tutorials"]
externalLink = ""
series = []
+++

While building this website I documented the steps and decided that how to publish this website should be the first blog 
post on this site. The tools used for building this website and discussed in this post are: [Hugo](https://gohugo.io/) 
and [Github Pages](https://pages.github.com/).

## What is Hugo?

Hugo is a static site generator with fast building times. It allows for content to be written in Markdown and translates 
these documents to html. Reasons to choose this framework are that it is fast, customizable and under active 
development.

## Installing Hugo

On MacOS, Hugo can be installed using [homebrew](https://brew.sh/). In the terminal the following commands downloads and
install Hugo:

``` sh
brew install hugo
```

## Creating a Website

To create a static website, a simple hugo template can be created, content can be added, and finally a theme can be 
applied. The [Hugo Quickstart Guide](https://gohugo.io/getting-started/quick-start/) supplies commands to create an 
initial framework of a website called 'blog':

``` sh
hugo new site blog
```

Then a theme can be found on a [theme gallery](https://themes.gohugo.io/). Generally, on the theme website there is a
good explanation on how to install the theme for a hugo website. It will be something like:

``` sh
cd blog
git init
git submodule add <theme-repository> themes/<theme-name>
```

Since each themae has a different configuration and setup, the easiest way to apply the theme is to copy `theme.toml`
from the `themes` folder to `config.toml` in the main folder of the project.

``` shell script
cp themes/theme.toml config.toml
```

Add a new post

``` sh
hugo new posts/<name-of-post>.md
```

When done editing the posts, run the following command to build the website:

``` sh
hugo server -D
```

If the site looks good enough to be published, close the server using `CTRL-C`.

## What is Github Pages?

[Github Pages](https://pages.github.com/) is a tool from github that builds and publishes a website from a github
repository. The setup is easy and because it is serving a website from a repository it makes version controlling a 
website really easy.

## Publish the blog on github.io

First, create a repository for you blog files (call it `blog` for example). Make sure that in your `.gitignore` you
ignore the `public/` forlder. We will later on push this folder to another repoisory to publish the website. 

Go to [github](www.github.com) and create a new repository with the name `<YOURUSERNAME>.github.io`. Your html files
will be saved in this repository. Before we push our website to github, we need to remove the `public/` folder:

``` shell script
rm -rf public
```

In `config.toml` change the line setting the baseurl to: `baseurl = "https://<YOURUSERNAME>.github.io/"
`.

Now we need to add a git submodule in your `blog` folder that has a remote in you newly created 
`<YOURUSERNAME>.github.io`:

``` shell script
git submodule add -b master https://github.com/<YOURUSERNAME>/<YOURUSERNAME>.github.io.git public
```

The website can be build using the 'hugo' command:

``` shell script
hugo
```

Now go into the public folder, add and commit the changes and push the files to the 
remote repository:

``` shell script
cd public
git add .
git commit -m "initial commit"
git push
```

On github, in the `<YOURUSERNAME>.github.io` repository, go to settings and scroll down. There should be a section
called 'Github Pages'. Here, it should say: 'Your site is published at https://<YOURUSERNAME>.github.io/'. The site
might take a few minutes to show up, this also applies to changes being visible when updating the site.

On the Hugo website the authors suggest automating the deployment of the website to github.io using a simple shell 
[script](https://gohugo.io/hosting-and-deployment/hosting-on-github/). Once the script is copy-pasted into a bash 
scripted called deploy.sh, the following command can be used to make the script an executable:

``` shell script
chmod +x deploy.sh
```

Finally, the changes made to the blog repository should be commited to allow working on the blog from other devices.

## Links

- [Hugo quickstart](https://gohugo.io/getting-started/quick-start/)
- [Hugo tutorial on how to publish a site to github.io](https://gohugo.io/hosting-and-deployment/hosting-on-github/)