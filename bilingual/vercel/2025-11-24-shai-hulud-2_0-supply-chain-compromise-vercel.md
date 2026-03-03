---
title: "Shai-Hulud 2.0 Supply Chain Compromise  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/shai-hulud-2-0-supply-chain-compromise"
date: "2025-11-24"
scraped_at: "2026-03-02T09:25:22.717855803+00:00"
language: "en-zh"
translated: true
description: "Vercel updates that no Vercel-managed systems or internal build processes were impacted by the Shai-Halud 2.0 supply chain compromise "
---

Nov 24, 2025

2025 年 11 月 24 日

多个来自不同网络服务的 npm 包 [遭到入侵](https://helixguard.ai/blog/malicious-sha1hulud-2025-11-24)，攻击方式为账户劫持或开发者账户失陷。一名恶意行为者成功向 `package.json` 文件中添加了一个隐蔽的加载器，该加载器可定位 Bun 运行时，静默安装并执行恶意脚本。

我们的调查表明，Vercel 的任何运行环境均未受影响；我们正通知一小部分构建作业受到波及的客户。

### 对 Vercel 客户的影响

Vercel 已立即采取措施，为受影响的客户解决问题。作为初步应对措施，我们在持续调查是否存在加载器成功执行的情况下，已重置所有拉取过相关漏洞包的项目的缓存。

- 截至本文发布之时，**所有由 Vercel 管理的系统**及内部构建流程**均未受到影响**。

- **初步分析**发现，仅有**少量 Vercel 客户的构建作业**引用了遭入侵的包。

- 我们正直接联系受影响的客户，并提供详细的缓解措施说明。

我们将持续在调查过程中发布最新进展。