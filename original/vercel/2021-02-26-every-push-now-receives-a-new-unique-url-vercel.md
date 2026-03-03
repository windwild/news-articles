---
title: "Every push now receives a new unique URL - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/every-push-now-receives-a-unique-url"
date: "2021-02-26"
scraped_at: "2026-03-02T10:05:52.241516303+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 26, 2021

![](images/every-push-now-receives-a-new-unique-url-vercel/img_001.jpg)

Today, we're announcing that **every Git push and Vercel CLI invocation will result in a new unique URL and a new immutable Deployment**.

Existing Deployments will no longer be re-used if you try to create a new one.

This change will likely not impact you in a meaningful way. On November 20th 2020, we [enabled automatic System Environment Variables](https://vercel.com/changelog/system-environment-variables-are-now-available-by-default) by default. If that option is enabled, a new immutable Deployment will already be created every time.

Vercel always strives to give you real-time feedback on every change you push. To this end, we are working on leveraging smart incremental computation techniques to **avoid redoing work that’s already been done**.