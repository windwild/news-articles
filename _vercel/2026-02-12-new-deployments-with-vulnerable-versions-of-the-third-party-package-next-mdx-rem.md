---
title: "New deployments with vulnerable versions of the third-party package next-mdx-remote are now blocked by default - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-deployments-with-vulnerable-versions-of-next-mdx-remote-are-now-blocked-by-default"
date: "2026-02-12"
scraped_at: "2026-03-02T09:21:33.009390202+00:00"
language: "en-zh"
translated: true
description: "Any new deployment containing a version of next-mdx-remote that is vulnerable to CVE-2026-0969 will now automatically fail to deploy on Vercel."
---
{% raw %}

Feb 12, 2026

2026 年 2 月 12 日

任何包含易受 [CVE-2026-0969](https://www.cve.org/CVERecord?id=CVE-2026-0969) 漏洞影响的第三方包 `next-mdx-remote` 版本的新部署，现在将在 Vercel 上自动部署失败。

无论您使用哪家托管服务商，我们都强烈建议升级至已修复该漏洞的版本。

您可通过在 Vercel 项目中设置环境变量 `DANGEROUSLY_DEPLOY_VULNERABLE_CVE_2026_0969=1` 来禁用此项自动防护机制。[了解更多](https://vercel.com/docs/environment-variables#creating-environment-variables)
{% endraw %}
