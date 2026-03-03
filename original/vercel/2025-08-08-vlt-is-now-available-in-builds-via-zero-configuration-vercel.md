---
title: "vlt is now available in builds via zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vlt-is-now-available-in-builds-via-zero-configuration"
date: "2025-08-08"
scraped_at: "2026-03-02T09:30:09.014309695+00:00"
language: "en"
translated: false
description: "The package manager vlt is now available as a zero-config option, auto detected based on the presence of a lockfile in your build."
---




Aug 8, 2025

![](images/vlt-is-now-available-in-builds-via-zero-configuration-vercel/img_001.jpg)![](images/vlt-is-now-available-in-builds-via-zero-configuration-vercel/img_002.jpg)

Vercel now supports the `vlt` package manager for builds with zero configuration in builds.

Starting today, Projects that contain a `vlt-lock.json` file will automatically run `vlt install` as the default [Install Command](https://vercel.com/docs/concepts/deployments/build-step#install-command) using `vlt`.

`vlt` requires node `20.x` to run and is only available in the modern [build image](https://vercel.com/docs/builds/build-image).

Learn more about [package manager support on Vercel](https://vercel.com/docs/package-managers#supported-package-managers).