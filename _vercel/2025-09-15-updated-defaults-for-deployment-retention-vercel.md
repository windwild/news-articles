---
title: "Updated defaults for deployment retention - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/updated-defaults-for-deployment-retention"
date: "2025-09-15"
scraped_at: "2026-03-02T09:28:42.704337103+00:00"
language: "en-zh"
translated: true
description: "Vercel is updating the default retention policy for deployments. Unlimited retention is no longer available."
---

render_with_liquid: false
Sep 15, 2025

2025 年 9 月 15 日

Starting October 15, 2025, Vercel will update the default deployment retention policy for all projects currently using the legacy “unlimited” setting:

自 2025 年 10 月 15 日起，Vercel 将更新所有当前使用旧版“无限制”设置的项目的默认部署保留策略：

- Canceled Deployments - **30 days**, with a maximum of **1 year.**  
- 已取消的部署 —— **30 天**，最长不超过 **1 年**。

- Errored Deployments - **3 months**, with a maximum of **1 year.**  
- 出错的部署 —— **3 个月**，最长不超过 **1 年**。

- Pre-Production Deployments - **6 months**, with a maximum of **3 years.**  
- 预发布部署 —— **6 个月**，最长不超过 **3 年**。

- Production Deployments - **1 year**, with a maximum of **3 years.**  
- 生产环境部署 —— **1 年**，最长不超过 **3 年**。

Projects with a [custom deployment retention setting](https://vercel.com/docs/security/deployment-retention#setting-a-deployment-retention-policy) will not be affected. Additionally, before October 15, the "unlimited" option will become unavailable when modifying retention policies.

已配置[自定义部署保留策略](https://vercel.com/docs/security/deployment-retention#setting-a-deployment-retention-policy)的项目不受本次调整影响。此外，在 10 月 15 日之前，“无限制”选项将在修改保留策略时被移除，不再可用。

Team owners can configure a default retention policy to be applied to any new projects created under the team on [Teams > Security & Privacy > Deployment Retention Policy](https://vercel.com/dashboard/~/settings/security#deployment-retention-policy). This policy can also be easily applied to all existing projects.

团队所有者可在 [Teams（团队）> Security & Privacy（安全与隐私）> Deployment Retention Policy（部署保留策略）](https://vercel.com/dashboard/~/settings/security#deployment-retention-policy) 页面中，为该团队下新建的任何项目配置默认保留策略；该策略亦可一键应用至所有现有项目。

_Note that your 10 most recent production deployments and any currently aliased deployment will never be deleted, regardless of age._

_请注意：您最近的 10 个生产环境部署，以及当前拥有别名（alias）的任意部署，无论其创建时间多久，均永远不会被删除。_

Learn more about [Deployment Retention](https://vercel.com/docs/security/deployment-retention).

了解更多关于[部署保留策略](https://vercel.com/docs/security/deployment-retention)的信息。