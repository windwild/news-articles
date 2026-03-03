---
title: "January 2020 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-january-2020"
date: "2020-01-01"
scraped_at: "2026-03-02T10:07:16.885917492+00:00"
language: "en"
translated: false
description: "Vercel's changelog for January 2020"
---




Jan 1, 2020

## Deployments

- New deployments will now automatically receive the latest Node.js version [available on Vercel](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version) at that point in time.


## Domains

- When deleting a project, all of its Production Domains will now made unavailable as well (no content will be served from them anymore).

- Domains that are never properly configured will now be automatically deleted after 7 days, instead of 3.

- When creating a new project, its default Production Domain is now made one word shorter if the combination is available.


## Other

- Adding support for a new framework to Vercel is now only a matter of creating a single Pull Request for the [zeit/now](https://github.com/zeit/now) repository.

- As of Now CLI 16.7.3, all files starting with `.env` are not uploaded. Previously, only files specifically named `.env` were not uploaded.

- New endpoints for retrieving a [realtime stream of all requests for a deployment](https://zeit.co/docs/api/#endpoints/logs/stream-serverless-function-logs) and retrieving all [failed requests](https://zeit.co/docs/api/#endpoints/logs/fetch-failed-requests-for-serverless-function) are now available.