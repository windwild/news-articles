---
title: "Version 7 of npm is now supported - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/version-7-of-npm-is-now-supported"
date: "2021-08-06"
scraped_at: "2026-03-02T10:04:13.049318913+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 6, 2021

![](images/version-7-of-npm-is-now-supported-vercel/img_001.jpg)

Vercel will now automatically detect whether your Project's dependencies were added with version 7 of the npm CLI, based on the presence of [the latest lockfile format](https://docs.npmjs.com/cli/v7/configuring-npm/package-lock-json#lockfileversion).

If detected, Vercel will automatically switch to using npm v7 to install your Project's dependencies within the [Build Step](https://vercel.com/docs/build-step).

This means that, among many bug fixes in the latest version of npm, your Deployments can now make use of the following new features:

- [Workspaces](https://github.com/npm/rfcs/blob/latest/implemented/0026-workspaces.md)

- [Automatically installing peer dependencies](https://github.com/npm/rfcs/blob/latest/implemented/0025-install-peer-deps.md)

- [package-lock v2 and support for yarn.lock](https://blog.npmjs.org/post/621733939456933888/npm-v7-series-why-keep-package-lockjson)


Check out the [full release notes](https://github.blog/2020-10-13-presenting-v7-0-0-of-the-npm-cli/) and the [documentation](https://vercel.com/docs/build-step#install-command) as well.