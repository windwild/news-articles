---
title: "16x larger Environment Variable storage up to 64KB - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/16x-larger-environment-variable-storage-up-to-64kb"
date: "2022-08-04"
scraped_at: "2026-03-02T10:01:12.233434101+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 4, 2022

![Two bars. One small one represents the 4KB limit of env vars when using a Lambda function, and another bigger bar represents the new 64KB limit of env vars when using Lambda functions in Vercel](images/16x-larger-environment-variable-storage-up-to-64kb-vercel/img_001.jpg)![Two bars. One small one represents the 4KB limit of env vars when using a Lambda function, and another bigger bar represents the new 64KB limit of env vars when using Lambda functions in Vercel](images/16x-larger-environment-variable-storage-up-to-64kb-vercel/img_002.jpg)

You can now use a total of 64KB in Environments Variables for each of your Deployments on Vercel. This change means you can add large values for authentication tokens, JWTs, or certificates, without worrying about storage size.

Deployments using Node.js, Python, and Ruby can support the larger 64KB environment.

Check out [the documentation](https://vercel.com/docs/concepts/projects/environment-variables#environment-variable-size) as well.