---
title: "Stale-if-error cache-control directive now supported for all responses - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/stale-if-error-cache-control-header-is-now-supported"
date: "2026-02-13"
scraped_at: "2026-03-02T09:21:32.768447528+00:00"
language: "en"
translated: false
description: "Stale-if-error directive now supported with Cache-control header for all responses, which allows the cache serves a stale response when an error is encountered instead of returning a hard error to the..."
---




Feb 13, 2026

Vercel CDN now supports the `stale-if-error` directive with Cache-Control headers, enabling more resilient caching behavior during origin failures.

You can now use the `stale-if-error` directive to specify how long (in seconds) a stale cached response can still be served if a request to the origin fails. When this directive is present and the origin returns an error, the CDN may serve a previously cached response instead of returning the error to the client. Stale responses may be served for errors like 500 Internal Server Errors, network failures, or DNS errors.

This allows applications to remain available and respond gracefully when upstream services are temporarily unavailable.

Read the [stale-if-error documentation](https://vercel.com/docs/headers/cache-control-headers#stale-if-error) to learn more.