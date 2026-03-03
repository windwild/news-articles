---
title: "Bun's text lockfile is now supported with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/buns-text-lockfile-is-now-supported-with-zero-configuration"
date: "2025-01-16"
scraped_at: "2026-03-02T09:38:14.605948980+00:00"
language: "en"
translated: false
description: "Bun v1.1.39 introduces text lockfile support, and Vercel now supports bun.lock with zero configuration. You can use the text lockfile today with bun install --save-text-lockfile."
---




Jan 16, 2025

Projects using Bun's new text `bun.lock`lockfile can now be deployed to Vercel with zero configuration.

While Vercel [already supports Bun's binary `bun.lockb` lockfile](https://vercel.com/changelog/bun-install-is-now-supported-with-zero-configuration-6qPMITQUrVSmCuGQSdO9HC), Bun v1.1.39 introduces a new [text-based](https://bun.sh/blog/bun-lock-text-lockfile) lock file with `bun install --save-text-lockfile`. Bun plans to make this the default in v1.2.

Learn more about [package managers supported by Vercel](https://vercel.com/docs/deployments/builds/package-managers#package-managers).