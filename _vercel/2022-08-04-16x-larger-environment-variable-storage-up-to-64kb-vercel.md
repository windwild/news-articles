---
title: "16x larger Environment Variable storage up to 64KB - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/16x-larger-environment-variable-storage-up-to-64kb"
date: "2022-08-04"
scraped_at: "2026-03-02T10:01:12.233434101+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Aug 4, 2022

2022 年 8 月 4 日

![Two bars. One small one represents the 4KB limit of env vars when using a Lambda function, and another bigger bar represents the new 64KB limit of env vars when using Lambda functions in Vercel](images/16x-larger-environment-variable-storage-up-to-64kb-vercel/img_001.jpg)![两条柱状图。其中较短的一条表示在使用 AWS Lambda 函数时环境变量的 4KB 限制，较长的一条则表示在 Vercel 中使用 Lambda 函数时环境变量的新上限——64KB](images/16x-larger-environment-variable-storage-up-to-64kb-vercel/img_002.jpg)

You can now use a total of 64KB in Environments Variables for each of your Deployments on Vercel. This change means you can add large values for authentication tokens, JWTs, or certificates, without worrying about storage size.

您现在可在 Vercel 的每次部署中，最多使用总计 64KB 的环境变量。此项更新意味着您可以放心添加认证令牌（authentication tokens）、JWT 或证书等体积较大的值，无需担忧存储空间限制。

Deployments using Node.js, Python, and Ruby can support the larger 64KB environment.

使用 Node.js、Python 和 Ruby 的部署均可支持更大的 64KB 环境变量容量。

Check out [the documentation](https://vercel.com/docs/concepts/projects/environment-variables#environment-variable-size) as well.

也欢迎查阅[相关文档](https://vercel.com/docs/concepts/projects/environment-variables#environment-variable-size)。