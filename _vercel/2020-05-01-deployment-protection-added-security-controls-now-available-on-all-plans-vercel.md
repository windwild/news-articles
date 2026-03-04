---
title: "Deployment Protection: Added security controls now available on all plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/security-controls-protected-preview-deployments-passwords"
date: "2020-05-01"
scraped_at: "2026-03-02T10:06:47.422018161+00:00"
language: "en-zh"
translated: true
description: "Deployment protection on all plans - Secure your deployment previews and create shareable links to share with collaborators"
---
&#123;% raw %}

Dec 19, 2022

2022 年 12 月 19 日

Today we're thrilled to announce added privacy controls across all plans, including the ability to secure their preview deployments behind [Vercel Authentication](https://vercel.com/docs/concepts/deployments/deployment-protection#vercel-authentication) with just one click.

我们非常激动地宣布，现面向所有套餐推出增强的隐私控制功能，包括仅需单击一次，即可通过 [Vercel 认证](https://vercel.com/docs/concepts/deployments/deployment-protection#vercel-authentication) 保护预览部署。

- Protect previews for free across all plans with [Deployment Protection](https://vercel.com/docs/concepts/deployments/deployment-protection)

- 免费在所有套餐中启用预览保护：[部署保护（Deployment Protection）](https://vercel.com/docs/concepts/deployments/deployment-protection)

- New ways to access and collaborate with [Shareable Links](https://vercel.com/docs/concepts/deployments/deployment-protection#shareable-links-(beta)) and Vercel Authentication

- 全新协作与访问方式：[可共享链接（Shareable Links）](https://vercel.com/docs/concepts/deployments/deployment-protection#shareable-links-(beta)) 与 Vercel 认证

- [Advanced Deployment Protection](https://vercel.com/docs/concepts/deployments/advanced-deployment-protection): Better E2E testing, private Production Deployments, and Password Protection

- [高级部署保护（Advanced Deployment Protection）](https://vercel.com/docs/concepts/deployments/advanced-deployment-protection)：更优的端到端（E2E）测试体验、私有生产环境部署，以及密码保护功能

Alongside this announcement, we're adding a new set of features that make it frictionless for team members and external collaborators to work together on protected previews: [Shareable Links](https://vercel.com/docs/concepts/deployments/deployment-protection#shareable-links-(beta)), and [Advanced Deployment Protection](https://vercel.com/docs/concepts/deployments/advanced-deployment-protection#), now available to Pro teams and included in Enterprise plans.

与此同时，我们新增一系列功能，让团队成员及外部协作者能更顺畅地共同协作处理受保护的预览部署：[可共享链接（Shareable Links）](https://vercel.com/docs/concepts/deployments/deployment-protection#shareable-links-(beta)) 与 [高级部署保护（Advanced Deployment Protection）](https://vercel.com/docs/concepts/deployments/advanced-deployment-protection#)，现已向 Pro 套餐团队开放，并包含于 Enterprise 套餐中。

## **Deployment Protection**

## **部署保护**

Deployment protection offers flexible ways to make [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments) private and accessible with Vercel Authentication or Shareable Links.

部署保护提供灵活的方式，使 [预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments) 变为私有，并可通过 Vercel 认证或可共享链接进行访问。

[Vercel Authentication](https://vercel.com/docs/concepts/deployments/deployment-protection#vercel-authentication) allows all Vercel users to log in with a Vercel account across the platform. Teams can now share protected previews with each other without having to enter additional security credentials. The same Vercel account they use to log in will work with their team's Preview Deployments. This provides an easy and frictionless way to collaborate while protecting pre-release products.

[Vercel 认证（Vercel Authentication）](https://vercel.com/docs/concepts/deployments/deployment-protection#vercel-authentication) 允许所有 Vercel 用户使用其 Vercel 账户在整个平台范围内登录。现在，团队成员之间可直接共享受保护的预览部署，无需额外输入安全凭据；用户登录所用的同一 Vercel 账户，亦可直接用于访问其所在团队的预览部署。这既保障了发布前产品的安全性，又实现了轻松、无摩擦的协作体验。

Vercel Authentication is replacing the existing “ [SSO Protection](https://vercel.com/docs/concepts/security#sso-protection)” feature Enterprise customers use today. SAML SSO, that is using an external identity provider to log in along with directory sync, will continue to be a feature only available in the Enterprise plan.

Vercel 认证将取代当前 Enterprise 客户使用的 “[单点登录保护（SSO Protection）](https://vercel.com/docs/concepts/security#sso-protection)” 功能。而 SAML 单点登录（即借助外部身份提供商登录并同步用户目录）将继续作为 Enterprise 套餐专属功能保留。

![Share private preview deployments with people outside your team without the need to log in](images/deployment-protection-added-security-controls-now-available-on-all-plans-vercel/img_001.jpg)与团队以外的人员共享私有预览部署，无需登录

### ) **可共享链接（Beta）**

我们还推出了[可共享链接（Shareable Links）](https://vercel.com/docs/concepts/deployments/deployment-protection#shareable-links)，这是一种向 Vercel 团队**外部人员**共享预览部署（Preview Deployments）的新方式。该功能通过在预览 URL 中添加查询字符串，使外部协作者无需输入额外凭据即可访问预览部署。

虽然通过“可共享链接”访问部署**无需拥有 Vercel 账户**，但若要使用“评论（Comments）”功能进行协作，则仍需登录 Vercel 账户。

Pro 和 Enterprise 计划用户可无限制创建可共享链接；Hobby 计划用户则可同时启用 1 条链接。这些设置均可在您的 Vercel 控制台中配置。

## **高级部署保护正式发布**

基于现有密码保护（Password Protection）用户的反馈，我们正进一步简化团队及代理机构安全地开发、预览和测试其应用的流程。

今天，我们正式推出[高级部署保护（Advanced Deployment Protection）](https://vercel.com/docs/concepts/deployments/deployment-protection#advanced-deployment-protection)——专为具有高安全性要求的团队，或需要以编程方式访问受保护预览部署的团队而设计。高级部署保护可作为 Pro 计划的附加服务，每月收费 $150；所有 Enterprise 计划均默认包含该功能。当前所有密码保护用户将**自动升级**至高级部署保护。

![请求头密钥可用于授予端到端测试工具访问权限](images/deployment-protection-added-security-controls-now-available-on-all-plans-vercel/img_002.jpg)请求头密钥（Header Secret）可用于授予端到端测试工具访问权限

### ) **自动化绕过（Beta）**

As part of Advanced Deployment Protection, we are offering customers a header secret that can be used to grant secure access to previews programmatically.

作为高级部署保护（Advanced Deployment Protection）的一部分，我们为客户提供一个请求头密钥（header secret），可用于以编程方式安全地授予预览环境（previews）访问权限。

The header secret, for example, can be used to grant access to E2E (end-to-end) testing tools. E2E testing allows developers to simulate a real customer usage scenario through an automated tool. Users of these tools often struggle to allow these automated tools to access protected services.

例如，该请求头密钥可用于向端到端（E2E）测试工具授予访问权限。E2E 测试允许开发者通过自动化工具模拟真实客户的使用场景。而这些工具的使用者常常难以让自动化工具访问受保护的服务。

### **Password Protection**

### **密码保护**

For added security, Advanced Deployment Protection users are able to enforce a password to grant access to their Preview Deploys. Passwords can be configured in your Vercel dashboard.

为增强安全性，启用高级部署保护的用户可强制设置密码，以控制对预览部署（Preview Deploys）的访问权限。您可在 Vercel 控制台中配置密码。

### **Private Production Deployments (Beta)**

### **私有生产部署（Beta 版）**

In some cases, customers need to lock down a Production Deployment. This could be the case of an internal tool, or a completely new domain launch on Vercel. By ticking a single box, production deployments can now also be protected in the same way as a Preview Deployment would.

在某些情况下，客户需要锁定其生产部署（Production Deployment），例如内部工具，或在 Vercel 上全新上线的域名。只需勾选一个复选框，即可像保护预览部署一样，对生产部署实施同等保护。

### Next steps

### 后续步骤

For now, deployment protection needs to be turned on manually. To get started, head to your project settings and enable protect preview deployments under deployment settings.

目前，部署保护需手动开启。如需开始使用，请进入项目设置，在“部署设置（deployment settings）”中启用“保护预览部署（protect preview deployments）”。

Learn more in the [documentation](https://www.vercel.com/docs/concepts/deployments/deployment-protection).

更多详情，请参阅[文档](https://www.vercel.com/docs/concepts/deployments/deployment-protection)。
&#123;% endraw %}
