---
title: "LangSmith: Redesigned product homepage and Resource Tags for better organization"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-homepage-redesign-and-resource-tags/"
date: "2024-11-19"
scraped_at: "2026-03-03T07:47:32.899972136+00:00"
language: "en-zh"
translated: true
description: "LangSmith's homepage is now organized into Observability, Evaluation, and Prompt Engineering. Learn why we organized the homepage like this. Plus, see our latest Resource Tags updates."
---
&#123;% raw %}

Today, we’re excited to release a redesigned LangSmith product homepage as well as improved support for resource organization within your workspaces. These updates reflect our ongoing insights into how engineering teams build, optimize, and iterate on their LLM applications. In this post, we will walk through our updated beliefs and how they guided our design.

我们很高兴地宣布，今日正式发布全新改版的 LangSmith 产品主页，并进一步优化了工作区内的资源组织功能。这些更新源于我们持续对工程团队如何构建、优化和迭代其大语言模型（LLM）应用所形成的深入洞察。本文将详细介绍我们更新后的核心理念，以及这些理念如何指导本次设计升级。

## Our approach to redesigning the LangSmith homepage

## 重新设计 LangSmith 主页的设计思路

Through collaborating with thousands of developers and companies, we’ve observed that they work across three main areas when building LLM applications: observability, evaluation, and prompt engineering. To reflect the critical role each plays in an effective developer workflow, we’ve split our [LangSmith product homepage](http://smith.langchain.com/?ref=blog.langchain.com) into these three areas.

通过与数千名开发者及企业合作，我们观察到：在构建 LLM 应用时，团队主要围绕三大核心领域开展工作——可观测性（Observability）、评估（Evaluation）和提示工程（Prompt Engineering）。为充分体现这三者在高效开发者工作流中所扮演的关键角色，我们已将 [LangSmith 产品主页](http://smith.langchain.com/?ref=blog.langchain.com) 按照这三大领域进行重构与划分。

### Observability

### 可观测性

_This section in LangSmith includes Tracing Projects and Dashboards._

_LangSmith 中该模块包含“追踪项目（Tracing Projects）”与“仪表板（Dashboards）”。_

One of the biggest recommendations for AI engineers is to “look at your own data” — and LangSmith enables this by helping users identify issues and understand their LLM application’s performance over time.

对 AI 工程师而言，最重要的建议之一便是“审视你自己的数据”——而 LangSmith 正是通过帮助用户识别问题、并随时间推移持续理解其 LLM 应用的运行表现，来切实支持这一实践。

**Tracing Projects** are collections of traces emitted from your AI application. Inside this page, you can search and filter traces, then click into a specific trace for a more detailed view. This type of datapoint-level observability is crucial for understanding what is going on in your application, so that you can debug and identify issues quickly.

**追踪项目（Tracing Projects）** 是由你的 AI 应用所生成的一系列追踪记录（traces）的集合。在此页面中，你可以对追踪记录执行搜索与筛选操作，并点击任一具体 trace 查看其详细信息。这种面向数据点级别的可观测能力，对于深入理解应用内部运行状况至关重要，从而让你能够快速调试并定位问题。

**Dashboards** allow you to create custom monitoring charts to track the metrics that matter the most to your application over time. This includes basic metrics like cost, latency, and quality as well as more specific criteria like agent actions over time or realtime evaluation scores.

**仪表板（Dashboards）** 支持你创建自定义监控图表，以长期跟踪对你应用最关键的各类指标。这些指标既包括成本（cost）、延迟（latency）、质量（quality）等基础维度，也涵盖更具体的场景化指标，例如智能体（agent）随时间变化的操作行为，或实时评估得分（realtime evaluation scores）。

Our observability features are designed to empower users to optimize their LLM application at every step in the lifecycle — from detailed debugging in development, to monitoring performance at scale in production.

我们的可观测性功能旨在赋能用户，在 LLM 应用全生命周期的每个阶段实现持续优化——无论是在开发阶段进行深度调试，还是在生产环境中大规模监控系统性能。

### Evaluation

### 评估

_This section in LangSmith includes Datasets, Experiments, and Annotation Queues._

_本节在 LangSmith 中包含数据集（Datasets）、实验（Experiments）和标注队列（Annotation Queues）。_

Evaluating your LLM application is often a bottleneck in development. High-quality, continuous evaluations (or “evals”) help developers understand how well their application is performing and pinpoint areas for improvements. LangSmith Evaluation removes the guesswork, highlighting regressions or improvements across metrics like accuracy, style, and other key criteria.

对 LLM 应用的评估通常是开发过程中的瓶颈。高质量、持续性的评估（即“evals”）有助于开发者了解应用的实际表现，并精准定位待优化环节。LangSmith Evaluation 消除了主观猜测，可清晰揭示各项关键指标（如准确性、风格等）上的性能退化或提升。

First, LangSmith makes it easy to curate **datasets**. Users can import existing data, or automatically add data points from their logs in the Observability section of LangSmith. You can then run experiments over these datasets, score the result with automatic evaluators, and track the results of these over time.

首先，LangSmith 让**数据集（datasets）** 的构建变得轻而易举：用户既可导入已有数据，也可从 LangSmith 的可观测性（Observability）模块日志中自动提取数据点。随后，您可在这些数据集上运行实验，借助自动化评估器对结果打分，并长期追踪各项实验结果的变化趋势。

Human review remains a crucial part of evaluating LLM applications, and LangSmith simplifies this process with **Annotation Queues**. Using Annotation Queues, users can organize and manage data points that need human review, streamlining the workflow for reviewers and ensuring consistent, high-quality feedback.

人工评审仍是评估 LLM 应用不可或缺的一环；LangSmith 通过**标注队列（Annotation Queues）** 大幅简化该流程。借助标注队列，用户可系统化地组织与管理待人工评审的数据点，从而优化评审人员的工作流，并保障反馈的一致性与高质量。

### Prompt Engineering

### 提示工程（Prompt Engineering）

_This section in LangSmith includes Prompts and the Playground._

_本节在 LangSmith 中包含提示模板（Prompts）和交互式沙盒（Playground）。_

Effective prompt engineering is necessary for building a responsive and reliable LLM application. LangSmith enables user to **store and version prompts**, making it easy to track their evolution and collaborate seamlessly with team members.

高效的提示工程是构建响应迅速、稳定可靠的 LLM 应用的前提。LangSmith 支持用户**存储并版本化管理提示模板（prompts）**，便于追踪其迭代演进，并与团队成员无缝协作。

Additionally, the **Playground** in LangSmith allows users to iterate on prompts in real-time. Users can run prompts against individual datapoints or over an entire dataset to assess their impact at scale. The Playground also allows for side-by-side comparisons of how different prompt and model combinations perform.

此外，LangSmith 的**交互式沙盒（Playground）** 支持用户实时迭代优化提示模板：既可针对单个数据点运行提示，也可面向整个数据集批量测试，从而规模化评估其实际效果；沙盒还支持并排对比不同提示模板与模型组合的表现差异。

Prompt engineering is an area where we’re interested in pushing the boundaries. What could an “IDE for prompt engineering” truly look like? We’re diving into this question, reimagining the tools that prompt engineers need, and we’re excited to share some of our ideas soon.

提示工程正是我们致力于突破边界的领域之一。一个真正面向提示工程的“集成开发环境（IDE）”究竟应具备何种形态？我们正深入探索这一问题，重新构想提示工程师真正需要的工具体系，并期待不久后与您分享我们的部分构想。

### Onboarding guides to get started

### 入门指南（Onboarding Guides）

To help new users get started quickly, we also added an onboarding guide at the top of the homepage, covering Observability, Evaluation, and Prompt Engineering.

为帮助新用户快速上手，我们还在首页顶部新增了入门引导，涵盖可观测性（Observability）、评估（Evaluation）和提示工程（Prompt Engineering）三大主题。

## Improved resource organization with Resource Tags

## 借助资源标签（Resource Tags）优化资源组织

In LangSmith, **Workspaces** are designed to separate resources and provide dedicated environments for different teams or business units within an organization. However, as teams have grown in LangSmith, so has the need for better resource organization within workspaces. Earlier this year, we introduced [**Resource Tags**](https://changelog.langchain.com/announcements/resource-tags-to-organize-your-workspace-in-langsmith?ref=blog.langchain.com) to enhance resource grouping and accessibility.

在 LangSmith 中，**工作区（Workspaces）** 旨在隔离各类资源，并为组织内的不同团队或业务部门提供专属运行环境。然而，随着 LangSmith 用户团队规模不断扩大，工作区内资源的组织与管理需求也日益增长。今年早些时候，我们推出了 [**资源标签（Resource Tags）**](https://changelog.langchain.com/announcements/resource-tags-to-organize-your-workspace-in-langsmith?ref=blog.langchain.com)，以提升资源的分组能力与可访问性。

![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_001.png)Creating a new resource tag in LangSmith

![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_001.png)在 LangSmith 中创建新的资源标签

We’ve now made resource tags even more intuitive and flexible. In a typical application, you might have multiple tracing projects for different LLM pipelines, various datasets, numerous prompts, and numerous annotation queues. We aim to simplify how these resources can be logically grouped and accessed.

如今，我们进一步提升了资源标签的直观性与灵活性。在典型应用场景中，您可能拥有面向不同大语言模型（LLM）流水线的多个追踪项目、多种数据集、大量提示（prompts）以及多个标注队列（annotation queues）。我们的目标是简化这些资源的逻辑分组方式与访问路径。

Initially, we considered introducing a strict “Application” concept, where each resource would belong to a single application. However, UX research revealed that this was too rigid; users often need resources to span multiple projects or want to organize resources by environment (e.g. dev, staging, or prod), rather than solely by project.

最初，我们曾考虑引入严格的“应用（Application）”概念，即每个资源仅归属于一个应用。但用户体验（UX）研究显示，这种设计过于僵化：用户往往需要让同一资源横跨多个项目，或更倾向于按环境（如开发、预发布、生产）而非仅按项目来组织资源。

**Resource tags** now offer this customizable grouping. You can filter by “Application” by default, or just create and filter by custom tags that suit your workflow. This flexibility supports varied organizational needs, including environment-based separation, making resources easy to locate and manage.

**资源标签（Resource Tags）** 现已支持高度可定制的分组方式。默认情况下，您可通过“应用（Application）”进行筛选；您也可自由创建并按符合自身工作流的自定义标签进行筛选。这种灵活性可满足多样化的组织需求（例如基于环境的隔离），使资源更易于定位与管理。

![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_002.png)Filtering by “Application” or custom tags![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_003.png)View of resources organized by “Application” - in this case, it displays resources for the chat-langchain application.

![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_002.png)按“应用（Application）”或自定义标签进行筛选  
![](images/langsmith-redesigned-product-homepage-and-resource-tags-for-better-organization/img_003.png)按“应用（Application）”组织的资源视图——本例中展示的是 chat-langchain 应用的相关资源。

To further enhance security and customization, we’ll soon introduce Attribute-Based Access Control (ABAC) for resource tags. This feature will enable fine-grained access control for teams to assign conditional permissions based on specific tag attributes, so users can securely organize and access resources across different projects and environments.

为进一步提升安全性与定制能力，我们即将为资源标签推出基于属性的访问控制（Attribute-Based Access Control, ABAC）。该功能将支持团队基于特定标签属性设置条件化权限，实现细粒度的访问管控，从而让用户能够安全地跨项目、跨环境组织与访问资源。

## Try out LangSmith

## 立即试用 LangSmith

Explore the new LangSmith homepage and features today at [smith.langchain.com](http://smith.langchain.com/?ref=blog.langchain.com) — and let us know what you think through the in-app feedback form.

今天就前往 [smith.langchain.com](http://smith.langchain.com/?ref=blog.langchain.com) 探索全新的 LangSmith 首页与功能，并通过应用内反馈表单告诉我们您的想法！
&#123;% endraw %}
