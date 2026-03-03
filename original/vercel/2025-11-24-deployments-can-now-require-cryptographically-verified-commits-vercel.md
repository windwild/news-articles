---
title: "Deployments can now require cryptographically-verified commits - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployments-can-now-require-cryptographically-verified-commits"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:01.252179087+00:00"
language: "en"
translated: false
description: "When enabled, Vercel will only create deployments for commits that have been verified by GitHub. For all other commits, the deployment will be automatically canceled."
---




Nov 24, 2025

![](images/deployments-can-now-require-cryptographically-verified-commits-vercel/img_001.jpg)![](images/deployments-can-now-require-cryptographically-verified-commits-vercel/img_002.jpg)

Vercel now supports commit verification, letting you protect your deployments by requiring commits to be cryptographically verified before they’re deployed from GitHub.

Enable it for GitHub-connected projects in your [project settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fgit).

Learn more about commit signing and verification on [GitHub](https://docs.github.com/en/authentication/managing-commit-signature-verification) or read more about the setting in our [docs](https://vercel.com/docs/project-configuration/git-settings#verified-commits).