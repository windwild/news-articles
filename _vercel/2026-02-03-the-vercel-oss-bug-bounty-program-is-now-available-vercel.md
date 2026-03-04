---
title: "The Vercel OSS Bug Bounty program is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-vercel-oss-bug-bounty-program-is-now-available"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:37.655836837+00:00"
language: "en-zh"
translated: true
description: "Vercel is opening its open source software bug bounty program to the public for researchers find vulnerabilities and make OSS safer"
---
{% raw %}

Feb 3, 2026

2026年2月3日

Security is foundational to everything we build at Vercel. Our open source projects power millions of applications across the web, from small side projects to demanding production workloads at Fortune 500 companies. That responsibility drives us to keep investing in security for the platform and the broader ecosystem.

安全性是我们于 Vercel 所构建一切的基石。我们的开源项目为遍布全网的数百万应用程序提供支持——从小型个人项目，到《财富》500 强企业的高要求生产级工作负载。这份责任驱使我们持续投入资源，强化平台本身及更广泛生态系统的安全能力。

Today, we're opening the Vercel Open Source Software (OSS) bug bounty program to the public on [HackerOne](https://hackerone.com/vercel-open-source). We're inviting security researchers everywhere to find vulnerabilities, challenge assumptions, and help us reduce risk for everyone building with these tools.

今天，我们正式在 [HackerOne](https://hackerone.com/vercel-open-source) 平台向公众开放 Vercel 开源软件（OSS）漏洞赏金计划。我们诚邀全球各地的安全研究人员积极参与：发现潜在漏洞、挑战既有假设，并协助我们降低所有使用这些工具进行开发者的整体风险。

Since August 2025, we've run a private bug bounty for our open source software with a small group of researchers. That program produced multiple high-severity reports across our Tier 1 projects and helped us refine our processes for triage, fixes, coordinated disclosure, and CVE publication. Now we're ready to expand.

自 2025 年 8 月以来，我们已面向一小批研究人员启动了针对开源软件的私有漏洞赏金计划。该计划已在我们的第一梯队（Tier 1）项目中产出多个高危漏洞报告，并帮助我们优化了漏洞分级（triage）、修复、协调披露（coordinated disclosure）以及 CVE 编号发布等全流程机制。如今，我们已准备好将计划全面开放。

## Building on our foundation of security investment

## 基于我们长期安全投入的坚实基础

Last fall, we opened a bug bounty program focused on [Web Application Firewall](https://vercel.com/security/waf) and the React2Shell vulnerability class. Rather than wait for bypasses to surface in the wild, we took a proactive approach: pay security researchers to find them first.

去年秋季，我们推出了聚焦于[网络应用防火墙（WAF）](https://vercel.com/security/waf)及 React2Shell 漏洞类别的漏洞赏金计划。我们并未被动等待绕过攻击在现实中出现，而是采取了主动防御策略：付费邀请安全研究人员率先发现并报告这些漏洞。

That program paid out over $1M across dozens of researchers who helped us find and fix vulnerabilities before attackers could. The lesson was clear. Good incentives and clear communication turn researchers into partners, not adversaries.

该计划已向数十位研究人员累计发放奖金逾 100 万美元，他们帮助我们在攻击者利用前即发现并修复了多个漏洞。经验清晰表明：合理激励与透明沟通，能将研究人员转化为值得信赖的合作伙伴，而非对立面。

Opening our private OSS bug bounty program to the public is the natural next step. Security vulnerabilities in these projects don't just affect Vercel; they affect everyone who builds with these tools. Finding and fixing them protects millions of end-users.

将私有 OSS 漏洞赏金计划向公众开放，是顺理成章的下一步。这些项目中的安全漏洞，影响的绝不仅限于 Vercel 自身；所有使用这些工具进行开发的开发者及其终端用户，均会受到波及。及时发现并修复漏洞，正是在守护数百万终端用户的切实安全。

## Which projects are covered

## 哪些项目纳入覆盖范围？

All Vercel open source projects are in scope. The projects listed below represent the core of the Vercel open source ecosystem. These are the frameworks, libraries, and tools that millions of developers rely on daily.

所有 Vercel 开源项目均在本计划覆盖范围内。以下所列项目构成了 Vercel 开源生态体系的核心，它们是数百万开发者每日依赖的框架、库与开发工具。

### Core projects included in the HackerOne program

### HackerOne 计划包含的核心项目

| **Project** | **Description** |
| --- | --- |
| [Next.js](https://github.com/vercel/next.js) | 用于生产环境 Web 应用的 React 框架 |
| [Nuxt](https://github.com/nuxt/nuxt) | 面向现代 Web 开发的 Vue.js 框架 |
| [SWR](https://github.com/vercel/swr) | 用于数据获取的 React Hooks 库 |
| [Svelte](https://github.com/sveltejs/svelte) | 用于构建用户界面的框架 |
| [Turborepo](https://github.com/vercel/turborepo) | 面向单体仓库（monorepos）的高性能构建系统 |
| [AI SDK](https://github.com/vercel/ai) | AI 应用的 TypeScript 工具包 |
| [vercel (CLI)](https://github.com/vercel/vercel) | Vercel 平台的命令行接口 |
| [workflow](https://github.com/vercel/workflow) | 持久化工作流执行引擎 |
| [flags](https://github.com/vercel/flags) | 功能开关（Feature Flags）SDK |
| [ms](https://github.com/vercel/ms) | 轻量级毫秒单位转换工具 |
| [nitrojs](https://github.com/nitrojs/nitro) | 通用服务端引擎 |
| [async-sema](https://github.com/vercel/async-sema) | 异步操作信号量（Semaphore）库 |
| [skills](https://github.com/vercel-labs/skills) | 开源智能体技能工具：`npx skills` |

These are the projects where vulnerabilities have the highest potential impact, and where we prioritize incident response, vulnerability management, and CVE publication.

上述项目中，漏洞可能造成的影响最为严重；我们亦将在此类项目中优先开展事件响应、漏洞管理及 CVE 编号发布工作。

## How to participate

## 如何参与

If you’re a security researcher and ready to start hunting, visit [HackerOne](https://hackerone.com/vercel-open-source) to find everything you need: scope details, reward ranges, and submission guidelines.

如果您是安全研究员，且已准备好开始漏洞挖掘，请访问 [HackerOne](https://hackerone.com/vercel-open-source)，获取全部必要信息：项目范围说明、奖励金额区间以及提交指南。

When you find a vulnerability, submit it through HackerOne with clear reproduction steps. Our security team reviews every submission and works directly with researchers through the disclosure process. We're committed to fast response times and transparent communication.

发现漏洞后，请通过 HackerOne 提交报告，并附上清晰、可复现的操作步骤。我们的安全团队将审核每一份提交，并在披露过程中直接与研究员协作。我们承诺快速响应并保持沟通透明。

We appreciate the researchers who take the time to dig into our code and report issues responsibly. Your work helps keep these projects safer for everyone.

我们衷心感谢各位研究员抽出时间深入研究我们的代码，并负责任地报告问题。您的工作让这些开源项目对所有人而言都更加安全。

[Join our bug bounty program](https://hackerone.com/vercel-open-source) or [learn more about security at Vercel](https://vercel.com/security).

[加入我们的漏洞赏金计划](https://hackerone.com/vercel-open-source)，或[进一步了解 Vercel 的安全实践](https://vercel.com/security)。
{% endraw %}
