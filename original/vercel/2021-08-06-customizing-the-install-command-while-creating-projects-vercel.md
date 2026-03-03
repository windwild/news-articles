---
title: "Customizing the Install Command while creating Projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/customizing-the-install-command-while-creating-projects"
date: "2021-08-06"
scraped_at: "2026-03-02T10:04:22.077300186+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 6, 2021

![](images/customizing-the-install-command-while-creating-projects-vercel/img_001.jpg)

When [importing a Git repository](https://vercel.com/new) into Vercel, your Project's dependencies used to automatically be installed using either [Yarn](https://yarnpkg.com/) or [npm](https://www.npmjs.com/), depending on your code. Selecting a different package manager such as [pnpm](https://pnpm.io/) was only possible after the Project was already deployed.

As of today, however, you can configure your custom Install Command even before the first Deployment for your new Project is created.

This also comes in handy for passing custom options to the `yarn` or `npm install` commands, since you can simply place the command of your choice in the "Install Command" field.

Check out [the documentation](https://vercel.com/docs/build-step#install-command) as well.