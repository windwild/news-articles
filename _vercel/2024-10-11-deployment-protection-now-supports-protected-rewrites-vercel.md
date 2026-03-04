---
title: "Deployment Protection now supports protected rewrites - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/deployment-protection-now-supports-protected-rewrites"
date: "2024-10-11"
scraped_at: "2026-03-02T09:40:22.135677527+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Oct 11, 2024

2024 年 10 月 11 日

We've improved how [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) handles rewrites between protected deployments. If you have access to the deployment and it belongs to the same team as the original deployment, we now automatically grant access to the rewritten deployment.

我们已优化了 [Vercel 认证](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) 在受保护部署之间处理重写（rewrite）的方式。若您有权访问该部署，且该部署与原始部署同属一个团队，则我们现在将自动授予您对重写后部署的访问权限。

Previously, when rewriting to a protected deployment, [Vercel Authentication](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) would redirect through `vercel.com` to authenticate the user, causing the rewrite to become a redirect.

此前，在重写至受保护部署时，[Vercel 认证](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/vercel-authentication) 会通过 `vercel.com` 进行跳转以完成用户身份验证，导致重写行为实际变为一次重定向（redirect）。

Automatic access between protected rewrites is only applicable if you are already authenticated with Vercel on the original deployment. This new behavior does not apply to rewrites when you authenticate using [Shareable Links](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/sharable-links), [Protection Bypass for Automation](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation), or [Password Protection](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/password-protection).

受保护重写之间的自动访问权限，仅在您已在原始部署上完成 Vercel 身份认证的前提下生效。若您使用 [可共享链接（Shareable Links）](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/sharable-links)、[自动化绕过保护（Protection Bypass for Automation）](https://vercel.com/docs/security/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation) 或 [密码保护（Password Protection）](https://vercel.com/docs/security/deployment-protection/methods-to-protect-deployments/password-protection) 进行身份认证，则此新行为不适用。

Read more about [Deployment Protection](https://vercel.com/docs/security/deployment-protection) in our docs.

请参阅文档中关于 [部署保护（Deployment Protection）](https://vercel.com/docs/security/deployment-protection) 的更多说明。