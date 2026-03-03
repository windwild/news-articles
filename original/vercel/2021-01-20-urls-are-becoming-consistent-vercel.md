---
title: "URLs are becoming consistent - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/urls-are-becoming-consistent"
date: "2021-01-20"
scraped_at: "2026-03-02T10:06:05.243220173+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 20, 2021

![](images/urls-are-becoming-consistent-vercel/img_001.jpg)

A lot of feedback we've gathered has shown that the URLs Vercel currently provides you with are too complicated. As part of our strategy for making them simpler, we're starting with applying a consistent format on **February 20th 2021**:

- **Custom Domains and Automatic URLs** ending in `now.sh` will instead end in `vercel.app`.

- **Automatic Deployment URLs** like `project-d418mhwf5.vercel.app` will gain the slug of the owner Vercel scope to match Automatic Branch URLs: `project-d418mhwf5-team.vercel.app`.

- **Automatic Branch URLs** like `project-git-update.team.vercel.app` will lose their second subdomain level in favor of a dash: `project-git-update-team.vercel.app`.

- **Automatic Project URLs** like `project.team.vercel.app` and **Automatic Team Member URLs** like `project-user.team.vercel.app` will be adjusted like Automatic Branch URLs.


It is recommended to not rely on any of the Automatic URLs for Production use cases and instead use [Custom Domains](https://vercel.com/docs/custom-domains) for that. If that's not possible, please ensure any program sending requests to these URLs supports 308 redirects – like modern browsers do.