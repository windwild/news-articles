---
title: "Dependencies can now be installed with a custom command - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/dependencies-can-now-be-installed-with-a-custom-command"
date: "2020-11-11"
scraped_at: "2026-03-02T10:06:32.977667039+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 11, 2020

![](images/dependencies-can-now-be-installed-with-a-custom-command-vercel/img_001.jpg)

By default, Vercel automatically determines the right command for installing your project's code dependencies in the [Build Step](https://vercel.com/docs/build-step) based on the [Framework Preset](https://vercel.com/docs/build-step#framework-preset) configured for your project and the presence of certain files (like `package-lock.json`) in your source code.

As of today, you can customize the command that Vercel will run within the Build Step for installing your code dependencies.

In the new **Install Command** section within the Project Settings, you can now enter any command of your choice that will be run instead of having Vercel automatically determine the right one for you.

Check out [the documentation](https://vercel.com/docs/build-step#install-command) as well.