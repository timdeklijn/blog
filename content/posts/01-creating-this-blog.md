+++
draft = false
date = 2020-08-05T15:16:33+02:00
title = "Create and publish a website using Hugo and github pages"
description = ""
slug = "" 
tags = ["hugo","github pages"]
categories = ["tutorials"]
externalLink = ""
series = []
+++

Creating a personal website or blog enables people to communicate findings and opinions easily and unfiltered. Websites
let people to showcase their projects can serve as a resume when looking for a job. Not everyone can and wants to spend 
time to build up a personal website from scratch. In this blogpost a quick and simple way to create a customizable 
website is described. The tools used for building this website and discussed in this post are: 
[Hugo](https://gohugo.io/) and [Github Pages](https://pages.github.com/).

Hugo is a static site generator with fast building times. It allows for content to be written in Markdown and translates 
these documents to html. Reasons to choose this framework are: it is fast, customizable and under active development.


Github Pages is a tool from github that builds and publishes a website from a github repository. The setup is easy and 
because it is serving a website from a repository it makes version controlling a website really easy.

## Installing Hugo

On MacOS, Hugo can be installed using [homebrew](https://brew.sh/). In the terminal the following command downloads and
installs Hugo:

``` sh
brew install hugo
```

The installation instructions for other operating systems can be found 
[here](https://gohugo.io/getting-started/installing/).

## Create a minimal website

The [Hugo Quickstart Guide](https://gohugo.io/getting-started/quick-start/) explains how to generate a minimal website
with a simple commands: 

``` sh
hugo new site blog
```

This creates a folder called `blog/` with files that Hugo can convert to a website. The `content/` folder will contain
all posts and pages in Markdown format. The configurations of the websites can be found and edited in `config.toml`.

Themes can be found in the [theme gallery](https://themes.gohugo.io/). Depending on the goal of the website, it might be
useful to look for math and code support when picking a theme. Generally, explanation on how to install the theme for a 
site can be found on the theme website. The instructions will be similar to the following:

``` sh
cd blog/
git init
git submodule add <theme-repository> themes/<theme-name>
```

The directory is changed into our newly created website folder, the root of the project. A git repository is created, 
and the theme repository is downloaded and added as a submodule. When the theme repository is updated, the changes can 
be synchronised by moving into the theme folder (`cd themes/<theme-name>`) and run `git pull`. Most themes repositories 
contain an exampleSite folder. In this folder a `config.toml` can be found. The easiest method to apply the theme is to
copy this file to the root folder of the project:

``` shell script
cp themes/<theme-name>/exampleSite/config.toml config.toml
```

A new post can be added by manually creating a Markdown file, but a faster method is to use this Hugo command:

``` sh
hugo new posts/<name-of-post>.md
```

This ensures that a header containing metadata is added to the Markdown file. The template for this file can be found
and edited in the `archetypes/` folder in the project root. Notice the `draft = true` flag. This signals hugo to not 
include this markdown file into the build that will be published. These draft files will be visible in a development 
server.

When the post is finished, the following command will build the website and run a development server:

``` sh
hugo server -D
```

The website can be viewed in the browser on [http://localhost:1313](http://localhost:1313).

The development server shows a website created from the hugo templates and all files in the `content/` folder of the 
website, including files with `draft` set to `true` in the header. The draft files van be ignored by removing `-D` from
the command. When making changes to files, the server will rebuild the website when the files are saved.

When the site is ready to be published, close the server using `CTRL-C`.

## Publish the blog on github pages

A `.gitignore` file will prevent unwanted files to be added to version control. For the current project the file should
contain the following folders:

```
public/
resources/
```

The `public/` folder we will add as a submodule with a different remote location later. The main repository can now be 
committed to version control.

Go to [github](http://www.github.com) and create a new repository with the name `<YOURUSERNAME>.github.io`. The files
for the websites will be saved into this repository and github pages will read these when publishing the website. Before 
we push our website to github, we need to remove the `public/` folder:

``` shell script
rm -rf public/
```

In `config.toml` the baseurl should be set to: `baseurl = "https://<YOURUSERNAME>.github.io/"`. This will ensure all the 
links and styles are applied correctly when publishing the site.

A git submodule in your `blog/` folder called `public/` with a remote in the new `<YOURUSERNAME>.github.io` repository 
can be created with the following command:

``` shell script
git submodule add -b master https://github.com/<YOURUSERNAME>/<YOURUSERNAME>.github.io.git public/
```

Before publishing the website hugo should build the files into html and minimized css:

``` shell script
hugo
```

The `public/` folder now contains all files and is ready to be published to github pages.

After changing directory to the `public/` folder. The changes to this folder, a git submodule, can be committed and
pushed to the  remote repository:

``` shell script
cd public/
git add .
git commit -m "initial commit"
git push
```

On github, in the `<YOURUSERNAME>.github.io` repository, go to settings and scroll down until the section 
'Github Pages'. Here, it should say: `Your site is published at https://<YOURUSERNAME>.github.io/`. It might
take a few minutes for the site to appear online, which also applies to updates to the site.

On the Hugo website the authors suggest automating the deployment of the website to github.io using a [simple bash 
script](https://gohugo.io/hosting-and-deployment/hosting-on-github/). The script can be copy-pasted into a bash 
file called `deploy.sh` in the root folder of the project. The following commands can be used to make the script 
executable and execute it:

``` shell script
chmod +x deploy.sh
./deploy.sh
```

Finally, the changes made to the main repository should be committed to make it possible to work on the website from 
other devices.

## Links

- [Hugo quickstart](https://gohugo.io/getting-started/quick-start/)
- [Hugo tutorial on how to publish a site to github.io](https://gohugo.io/hosting-and-deployment/hosting-on-github/)