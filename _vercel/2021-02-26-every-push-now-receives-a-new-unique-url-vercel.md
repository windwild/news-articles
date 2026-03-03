---
title: "Every push now receives a new unique URL - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/every-push-now-receives-a-unique-url"
date: "2021-02-26"
scraped_at: "2026-03-02T10:05:52.241516303+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Feb 26, 2021

2021年2月26日

![](images/every-push-now-receives-a-new-unique-url-vercel/img_001.jpg)

Today, we're announcing that **every Git push and Vercel CLI invocation will result in a new unique URL and a new immutable Deployment**.

我们今天宣布：**每一次 Git 推送（push）和 Vercel CLI 调用，都将生成一个全新的唯一 URL 和一次不可变的部署（immutable Deployment）**。

Existing Deployments will no longer be re-used if you try to create a new one.

若您尝试创建新的部署，系统将不再复用已有的部署。

This change will likely not impact you in a meaningful way. On November 20th 2020, we [enabled automatic System Environment Variables](https://vercel.com/changelog/system-environment-variables-are-now-available-by-default) by default. If that option is enabled, a new immutable Deployment will already be created every time.

此项变更对您很可能不会产生实质性影响。早在2020年11月20日，我们已[默认启用自动系统环境变量（System Environment Variables）](https://vercel.com/changelog/system-environment-variables-are-now-available-by-default)。若该选项已启用，则每次都会自动生成一次新的不可变部署。

Vercel always strives to give you real-time feedback on every change you push. To this end, we are working on leveraging smart incremental computation techniques to **avoid redoing work that’s already been done**.

Vercel 始终致力于为您推送的每一次变更提供实时反馈。为此，我们正在探索并应用智能的增量计算技术，以**避免重复执行已完成的工作**。