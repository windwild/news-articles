---
title: "Projects using pnpm can now be deployed with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/projects-using-pnpm-can-now-be-deployed-with-zero-configuration"
date: "2022-03-22"
scraped_at: "2026-03-02T10:02:29.885975428+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 22, 2022

![](images/projects-using-pnpm-can-now-be-deployed-with-zero-configuration-vercel/img_001.jpg)

Projects using [pnpm](https://pnpm.io/) can now be deployed to Vercel with zero configuration. Vercel is also now sponsoring pnpm to further package manager innovation.

Like Yarn and npm, pnpm is a package manager focused on saving disk space and [boosting installation speed](https://pnpm.io/benchmarks) by utilizing symlinks. Starting today, Projects that contain a `pnpm-lock.yaml` file will automatically run `pnpm install` as the default [Install Command](https://vercel.com/docs/concepts/deployments/build-step#install-command) using the latest version of pnpm.

[Check out the documentation](https://vercel.com/docs/concepts/deployments/build-step#install-command) as well.