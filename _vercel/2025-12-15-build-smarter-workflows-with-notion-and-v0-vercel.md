---
render_with_liquid: false
title: "Build smarter workflows with Notion and v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/build-smarter-workflows-with-notion-and-v0"
date: "2025-12-15"
scraped_at: "2026-03-02T09:23:51.349821211+00:00"
language: "en-zh"
translated: true
description: "v0 now connects to Notion via MCP. Build dashboards, tools, and prototypes from your existing docs and databases, and write generated content back to your workspace."
---
render_with_liquid: false
render_with_liquid: false

Dec 15, 2025

2025 年 12 月 15 日

Notion 已成为团队信赖的、高度协同的工作空间。您的产品需求文档（PRD）、技术规格说明（specs）以及项目上下文均在此集中管理。v0 帮助这些团队将创意快速转化为仪表板、应用程序和原型。今天，这些工作流正式打通。

您现在可安全地将 v0 连接到您的 Notion 工作区，确保 v0 所构建的一切内容均以您现有的文档和数据库为根基。

无论您的团队知识以何种形式存在于 Notion 中，v0 现在均可在其之上直接构建。

## **借助此功能，您能交付什么**

## **此功能支持交付的内容**

v0 现已接入您团队的真实上下文。这意味着，您可构建以往需耗费更长时间、跨多个工具搜集与整合信息才能完成的产品。

通过在 v0 内部将 Notion 作为 MCP（Model Context Protocol，模型上下文协议）工具使用，团队现在能够交付：

- 基于 Notion 数据库构建的仪表板与内部工具  
- 基于 Notion 中撰写的 PRD 所生成的产品原型  
- 由存储在 Notion 中的简报（briefs）、日历（calendars）和文档（docs）所驱动的内容工作流

- Project and operations summaries generated from team trackers  

- 由团队追踪器生成的项目与运营摘要  

- Product demos grounded in customer insights and feedback you collect in Notion  

- 基于您在 Notion 中收集的客户洞察与反馈打造的产品演示  

- Presentation slides based on outlines in Notion  

- 基于 Notion 中提纲生成的演示文稿幻灯片  

The integration also supports write access, so v0 can contribute directly back to your workspace. Add weekly summaries or generated insights directly into project pages, update PRDs with implementation notes or design refinements after generating prototypes, or save generated content straight into the appropriate pages.  

该集成还支持写入权限，因此 v0 可直接向您的工作区回传内容。您可将周度摘要或生成的洞察直接添加至项目页面，可在生成原型后，用实施备注或设计优化更新产品需求文档（PRD），亦可将生成的内容直接保存至对应页面。  

Your projects stay grounded in the information your team already maintains, so you spend less time switching tools and more time building.  

您的项目始终扎根于团队已维护的信息之中，从而减少在不同工具间切换的时间，把更多精力投入到实际构建工作中。  

## **How we’re using it on the v0 team**  

## **v0 团队如何使用该功能**  

We run a lot of [events](https://v0.app/irl). Coordinating them meant juggling a form for submissions, a Notion database for event details, and separate spreadsheets for tracking reach and progress. It worked, but it was hard to scale. The fragmentation made it hard to stay consistent, move fast, and pull insights across everything we were hosting.  

我们举办大量 [线下活动（IRLs）](https://v0.app/irl)。过去协调这些活动需同时管理提交表单、用于记录活动详情的 Notion 数据库，以及分别用于追踪影响力与进展的多张电子表格。这套流程虽能运转，但难以规模化。信息分散导致我们难以保持一致性、快速推进，也难以从所有活动中汇总洞察。  

Now with the Notion integration, it’s one prompt:  

如今借助 Notion 集成，只需一条提示词：  

```markdown  
I want to build a tracking dashboard for our v0  

IRLs (events) using our Notion events database.  
```

Give me metrics for:

我需要以下指标：

5- events completed (monthly, yearly, weekly)

5- 已完成的活动数量（按月、按年、按周统计）

6- attendees engaged (monthly, yearly, weekly)

6- 参与活动的参会者人数（按月、按年、按周统计）

7- forward-looking events (scheduled count + weekly additions)

7- 未来待办活动（已排期活动总数 + 每周新增活动数）

Build an intuitive dashboard I can send to my team every Friday, with a clear summary of the top data my team cares about. Use only events created after

请为我构建一个直观的仪表盘，我可于每周五发送给团队，其中需清晰汇总团队最关注的核心数据。仅统计“创建时间在以下日期之后”的活动：

November 11th.

11月11日。

```

![](images/build-smarter-workflows-with-notion-and-v0-vercel/img_001.jpg)![](images/build-smarter-workflows-with-notion-and-v0-vercel/img_002.jpg)![](images/build-smarter-workflows-with-notion-and-v0-vercel/img_003.jpg)![](images/build-smarter-workflows-with-notion-and-v0-vercel/img_004.jpg)

v0 直接从 Notion 数据库读取数据，几秒钟内便生成了一个可运行的仪表板。随后，我们持续迭代：优化各项指标、改进界面设计，并基于数据库中的字段添加摘要信息。

而借助写入权限，v0 不仅生成了仪表板，还直接将每周摘要和关键指标写回我们的 Notion 活动页面中。

过去那种零散、依赖多个工具的流程，如今已整合为一个可复用的工作流——仅需几个提示词即可完成。

## Start building today

## 立即开始构建

在您的 v0 项目中启用 [Notion MCP 集成](https://v0.app/)，连接您的工作区，然后向 v0 提出有关您数据的问题。不知从何入手？请查看我们的 [入门模板](https://v0.app/templates/community-events-dashboard-from-notion-database-ZGbgOdhwh88)，并使用您自己的页面和数据库对其进行自定义。

我们非常期待看到您的创作！欢迎在 [X](https://x.com/v0)、[Vercel 社区](https://community.vercel.com/) 中与我们分享您的工作流，或将其 [提交为模板](https://v0.app/templates)，供他人使用。