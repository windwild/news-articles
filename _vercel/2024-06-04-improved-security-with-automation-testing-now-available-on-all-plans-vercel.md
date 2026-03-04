---
title: "Improved security with automation testing now available on all plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-security-with-automation-testing-now-available-on-all-plans"
date: "2024-06-04"
scraped_at: "2026-03-02T09:43:50.845013233+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jun 4, 2024

2024 年 6 月 4 日

You can now more easily run end-to-end tests against deployments protected by [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication).

现在，您可以更轻松地对受 [Vercel 认证](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) 保护的部署运行端到端（e2e）测试。

All plans can now [create a secret value to bypass authentication](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation), which can then be set as an HTTP header (or query parameter) named `x-vercel-protection-bypass`.

所有套餐现在均可 [创建密钥值以绕过认证](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation)，该密钥值随后可作为名为 `x-vercel-protection-bypass` 的 HTTP 请求头（或查询参数）进行设置。

The automation bypass enables you to protect your project's deployments with [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) while still providing access to external services like Checkly and Playwright for your CI/CD e2e testing.

自动化绕过机制使您能够在使用 [Vercel 认证](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) 保护项目部署的同时，仍为 Checkly 和 Playwright 等外部服务提供访问权限，从而支持 CI/CD 流程中的端到端测试。

See [how to use Protection Bypass for Automation](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation#using-protection-bypass-for-automation).

请参阅 [如何在自动化中使用保护绕过功能](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation#using-protection-bypass-for-automation)。
{% endraw %}
