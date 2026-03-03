---
title: "Introducing the new v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-new-v0"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.455064562+00:00"
language: "en-zh"
translated: true
description: "The new v0 brings production-ready AI coding to enterprises with git workflows, security, and real integrations. Ship faster with agents and teams."
---

Feb 3, 2026

2026年2月3日

Since v0 became generally available in 2024, more than 4 million people have used it to turn their ideas into apps in minutes. v0 has helped people get promotions, win more clients, and work more closely with developers.

自 v0 于 2024 年正式发布以来，已有超过 400 万人使用它在几分钟内将创意转化为应用程序。v0 已帮助用户获得晋升、赢得更多客户，并与开发者展开更紧密的合作。

AI lowered the barrier to writing code. Now we're raising the bar for shipping it.

人工智能降低了编写代码的门槛；如今，我们正提高交付代码的标准。

Today, v0 evolves vibe coding from novelty to business critical. Built for production apps and agents, this release includes enterprise-grade security and integrations teams can use to ship real software, not just spin up demos.

今天，v0 将“氛围编程”（vibe coding）从一种新奇尝试，升级为关乎企业成败的关键能力。本版本专为生产级应用与智能体（agents）而构建，包含企业级安全机制及开箱即用的集成能力，助力团队交付真正可用的软件，而不仅限于快速搭建演示原型。

![](images/introducing-the-new-v0-vercel/img_001.jpg)![](images/introducing-the-new-v0-vercel/img_002.jpg)![](images/introducing-the-new-v0-vercel/img_003.jpg)![](images/introducing-the-new-v0-vercel/img_004.jpg)

## The limitations of vibe coding

## “氛围编程”的局限性

We're at an inflection point where anyone can create software. But this freedom has created three problems for the enterprise.

我们正处于一个拐点：如今，任何人都能开发软件。但这种自由也给企业带来了三大问题。

**Vibe coding is now the world's largest shadow IT problem.** AI-enabled software creation is already happening inside every enterprise, and employees are shipping security flaws alongside features: credentials copied into prompts, company data published to the public internet, and databases get deleted, all with no audit trail.

**“氛围编程”已成为全球规模最大的影子 IT（Shadow IT）问题。** 借助 AI 的软件开发已在每一家企业内部悄然发生，而员工在交付新功能的同时，也一并引入了安全漏洞：凭据被直接复制进提示词（prompts）、公司数据被无意发布至公共互联网、数据库遭误删——所有这些操作均无审计记录可追溯。

**Demos are easy to generate, but production features aren't.** Prototyping is one of the most popular use cases for marketers and PMs, but the majority of real software work happens on existing apps, not one-off creations. Prototypes fail because they live outside real codebases, require rewrites before production, and create handoffs between tools and teams.

**生成演示原型轻而易举，但上线生产功能却困难重重。** 快速原型设计是市场人员与产品经理最常使用的场景之一；然而，绝大多数真正的软件开发工作，都发生在已有的成熟应用之上，而非一次性创作的孤立原型中。原型之所以失败，是因为它们游离于真实代码库之外，上线前必须重写，并在工具与团队之间造成大量交接断点。

**The old Software Development Life Cycle is overloaded with dead-ends.** The legacy SDLC relies on countless PRDs, tickets, and review meetings. Feedback cycles take weeks or months. Vibe coding has overloaded these outdated processes with thousands of good ideas that will never see the light of day, frustrating engineers and their stakeholders.

**传统的软件开发生命周期（SDLC）已不堪重负、处处碰壁。** 过时的 SDLC 严重依赖海量的产品需求文档（PRD）、工单（tickets）和评审会议，反馈周期动辄数周乃至数月。“氛围编程”则向这些陈旧流程倾注了成千上万的优质创意——但它们中的绝大多数终将石沉大海，令工程师及其利益相关方深感挫败。

We took these problems to heart and rebuilt v0 from the ground up.

我们深刻认识到这些问题，并从零开始彻底重构了 v0。

## From 0 to shipped: What's new

## 从零到上线：有哪些新特性

### Work on existing codebases

### 在现有代码库上工作

Instead of engineers spending weeks on re-writes for production, v0’s new sandbox-based runtime can import any GitHub repo and automatically pull environment variables, and configurations from Vercel.

以往，工程师往往需要花费数周时间重写代码以投入生产；而 v0 全新的基于沙箱的运行时，可直接导入任意 GitHub 仓库，并自动从 Vercel 拉取环境变量与配置。

Every prompt generates production-ready code in a real environment, and it lives in your repo. No more copying code back and forth.

每一次提示（prompt）均在真实环境中生成可直接用于生产的代码，且代码直接存于您的代码仓库中。无需再反复复制粘贴代码。

![](images/introducing-the-new-v0-vercel/img_005.jpg)![](images/introducing-the-new-v0-vercel/img_006.jpg)![](images/introducing-the-new-v0-vercel/img_007.jpg)![](images/introducing-the-new-v0-vercel/img_008.jpg)

### Bring git to your entire team

### 让 Git 走进整个团队

Historically, marketers and PMs weren’t comfortable setting up and troubleshooting a local dev environment. With v0, they don’t have to.

过去，市场人员和产品经理往往对搭建及调试本地开发环境感到力不从心；而借助 v0，他们完全无需再为此操心。

A new Git panel lets you create a new branch for each chat, open PRs against main, and deploy on merge. Pull requests are first-class and previews map to real deployments. For the first time, anyone on a team, not just engineers, can ship production code through proper git workflows.

一个全新的 Git 面板，支持为每次对话创建独立分支、向主分支（main）发起 Pull Request（PR），并在合并后自动部署。Pull Request 成为头等公民，预览链接即对应真实部署。这是首次，团队中任何成员——而不仅限于工程师——都能通过标准的 Git 工作流交付生产级代码。

![](images/introducing-the-new-v0-vercel/img_009.jpg)![](images/introducing-the-new-v0-vercel/img_010.jpg)![](images/introducing-the-new-v0-vercel/img_011.jpg)![](images/introducing-the-new-v0-vercel/img_012.jpg)

### Democratize data, safely

### 安全地实现数据民主化

Building internal reports and data apps typically requires painful setup of ETL pipelines and scheduled jobs. With v0, you can connect your app directly to the tables you need.

构建内部报表和数据应用通常需要繁琐地搭建 ETL 管道与定时任务。借助 v0，您可直接将应用连接至所需的数据表。

Secure integrations with Snowflake and AWS databases mean anyone can build custom reporting, add rich context to their internal tools, and automate data-triggered processes.

与 Snowflake 和 AWS 数据库的安全集成，意味着任何人均可构建定制化报表、为其内部工具添加丰富的上下文信息，并自动化执行由数据触发的流程。

### Stay secure by default

### 默认即安全

Vibe coding tools optimize for speed and novelty, discarding decades of software engineering best practices.

强调“氛围感”的编码工具追求速度与新奇性，却舍弃了数十年来沉淀的软件工程最佳实践。

v0 is built on Vercel, where security is built-in by default and configurable for common compliance needs. Set deployment protection requirements, connect securely to enterprise systems, and set proper access controls for every app.

v0 基于 Vercel 构建，安全机制默认内置，并可根据常见合规需求灵活配置。您可设定部署保护要求、安全接入企业系统，并为每个应用设置恰当的访问控制策略。

## How our customers use the new v0

## 我们的客户如何使用全新 v0

- **Product leaders** turn PRDs into prototypes, and prototypes into PRs, shipping the right features, fast. They go from "tell sales there's another delay" to "it's shipped."

- **产品负责人**将产品需求文档（PRD）快速转化为原型，再将原型直接转为代码提交（PR），高效交付真正符合需求的功能。他们从“告诉销售团队：又延期了”转变为“功能已上线”。

- **Designers** work against real code, refining layouts, tweaking components, and previewing production with each update. They go from "another ticket for frontend" to "it's shipped."

- **设计师**基于真实代码开展工作，持续优化页面布局、调整组件细节，并在每次更新后即时预览生产环境效果。他们从“再提一个前端工单吧”转变为“功能已上线”。

- **Marketers** turn ideas into site updates immediately, edit landing pages, changing images, fixing copy, and publishing, all without opening a ticket. They go from "please, it's a quick change" to "it's shipped."

- **营销人员**可立即将创意转化为网站更新：编辑落地页、更换图片、修正文案并发布上线——全程无需提交工单。他们从“拜托，这只是个简单修改”转变为“功能已上线”。

- **Engineers** unblock stakeholders without breaking prod, making quick fixes, importing repos, and letting business users open PRs, all in a single tab. They go from "I can't keep up with the backlog" to "it's shipped."

- **工程师**：无需中断生产环境，即可为相关方解除阻塞——快速修复问题、导入代码仓库，并让业务用户直接在单个标签页中提交 Pull Request。他们从“我赶不上积压任务”跃升至“已上线”。

- **Data teams** ship dashboards the business actually uses, building custom reports and analytics on top of real data with just a few prompts. They go from "that's buried in a notebook" to "it's shipped."

- **数据团队**：交付业务团队真正使用的仪表盘，仅需几个提示词，即可基于真实数据构建定制化报表与分析。他们从“那东西埋在某个 Notebook 里”跃升至“已上线”。

- **GTM teams** close deals with the demo customers actually asked for, create live previews, mock data, and branded experiences in minutes. They go from "let's show the standard deck" to "it's shipped."

- **GTM 团队**：用客户真正要求的演示版促成交易，在几分钟内生成实时预览、模拟数据及品牌化体验。他们从“我们来展示标准演示文稿吧”跃升至“已上线”。

## What's next

## 下一步是什么？

Today, you can use v0 to ship production apps and websites. 2026 will be the year of agents.

今天，您即可使用 v0 上线生产级应用与网站。2026 年将是“智能体（agents）之年”。

Soon, you’ll be able to build end-to-end agentic workflows in v0, AI models included, and deploy them on Vercel’s self-driving infrastructure.

很快，您将能在 v0 中构建端到端的智能体工作流（含 AI 模型），并将其部署至 Vercel 的自动驾驶基础设施。

Welcome to the new v0. We can’t wait to see what you build.

欢迎来到全新版本的 v0！我们迫不及待想看到您将构建出什么。

[Sign up or log in](https://v0.app/) to try the new v0 today.

[立即注册或登录](https://v0.app/)，今天就体验全新 v0。

_Snowflake, GitHub, AWS are trademarks of their respective owners._

_雪浪云（Snowflake）、GitHub、AWS 均为其各自所有者的商标。_