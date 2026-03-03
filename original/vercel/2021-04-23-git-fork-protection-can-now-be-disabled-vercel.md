---
title: "Git Fork Protection can now be disabled - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/git-fork-protection-can-now-be-disabled"
date: "2021-04-23"
scraped_at: "2026-03-02T10:04:49.643547327+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 23, 2021

![](images/git-fork-protection-can-now-be-disabled-vercel/img_001.jpg)

If you receive a pull request from a fork of your Git repository that includes a change to the `vercel.json` file or the Project has Environment Variables configured, Vercel will require authorization from you or a member of your Team to deploy the pull request.

This behavior protects you from accidentally leaking sensitive Project information.

If you're certain your Environment Variables do not contain sensitive information, you can now disable **Git Fork Protection** by visiting the Security section of your Project Settings.

Check out [the documentation](https://vercel.com/docs/platform/projects#git-fork-protection) as well.