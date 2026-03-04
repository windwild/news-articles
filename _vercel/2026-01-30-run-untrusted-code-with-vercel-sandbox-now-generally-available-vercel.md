---
title: "Run untrusted code with Vercel Sandbox, now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-sandbox-is-now-generally-available"
date: "2026-01-30"
scraped_at: "2026-03-02T09:21:39.510841501+00:00"
language: "en-zh"
translated: true
description: "AI agents need secure, isolated environments that spin up instantly. Vercel Sandbox is now generally available with filesystem snapshots, container support, and production reliability."
---
{% raw %}

Jan 30, 2026

2026 年 1 月 30 日

AI agents are changing how software gets built. They clone repos, install dependencies, run tests, and iterate in seconds.

AI 智能体正在改变软件的构建方式：它们可克隆代码仓库、安装依赖、运行测试，并在数秒内完成迭代。

Despite the change in software, most infrastructure was built for humans, not agents.

尽管软件开发范式已然转变，但当前绝大多数基础设施仍是为人类开发者设计的，而非面向智能体。

Traditional compute assumes someone is in the loop, with minutes to provision and configure environments. Agents need secure, isolated environments that start fast, run untrusted code, and disappear when the task is done.

传统计算模型默认“人在环路中”，环境的准备与配置往往需耗时数分钟；而智能体则需要安全、隔离、启动迅速、可执行不可信代码、并在任务完成后即刻销毁的运行环境。

Today, Vercel Sandbox is generally available, the execution layer for agents, and we're open-sourcing the Vercel Sandbox [CLI](https://www.npmjs.com/package/sandbox) and [SDK](https://www.npmjs.com/package/@vercel/sandbox) for the community to build on this infrastructure.

今天，Vercel Sandbox 正式全面开放——这是专为 AI 智能体打造的执行层。同时，我们已将 Vercel Sandbox 的 [CLI](https://www.npmjs.com/package/sandbox) 和 [SDK](https://www.npmjs.com/package/@vercel/sandbox) 开源，供社区基于这一基础设施开展构建。

## Built on our compute platform

## 基于我们自研的计算平台构建

Vercel processes over 2.7 million deployments per day. Each one spins up an isolated microVM, runs user code, and disappears, often in seconds.

Vercel 每日处理超 270 万次部署。每次部署均会启动一个隔离的微虚拟机（microVM），运行用户代码，并通常在数秒内自动销毁。

To do that at scale, we built our own compute platform.

为支撑如此大规模的部署，我们自主研发了专属计算平台。

Internally code-named Hive, it’s powered by [Firecracker](https://firecracker-microvm.github.io/) and orchestrates microVM clusters across multiple regions. When you click Deploy in [v0](https://v0.dev/), import a repo, clone a template, or run `vercel` in the CLI, Hive is what makes it feel quick.

该平台内部代号为 Hive，底层基于 [Firecracker](https://firecracker-microvm.github.io/) 构建，并跨多个区域统一编排微虚拟机集群。当你在 [v0](https://v0.dev/) 中点击“Deploy”、导入代码仓库、克隆模板，或在命令行中执行 `vercel` 命令时，正是 Hive 让整个过程显得迅捷流畅。

Sandbox brings that same infrastructure to agents.

Sandbox 将这一成熟基础设施能力延伸至 AI 智能体领域。

## Why agents need different infrastructure

## 为何智能体需要不同的基础设施

Agents don’t work like humans. They spin up environments, execute code, tear them down, and repeat the cycle continuously.

智能体的工作方式与人类不同：它们会持续创建运行环境、执行代码、销毁环境，并不断重复这一循环。

That shifts the constraints toward isolation, security, and ephemeral operation, not persistent, long-running compute.

这使得系统设计的约束条件转向了**隔离性、安全性与临时性运行**，而非持久化、长期运行的计算资源。

Agents need:

智能体需要：

- Sub-second starts for thousands of sandboxes per task

- 每项任务支持数千个沙箱，启动延迟低于1秒

- Full isolation when running untrusted code from repositories and user input

- 在运行来自代码仓库或用户输入的不可信代码时，实现完全隔离

- Ephemeral environments that exist only as long as needed

- 仅在必要时存在的临时运行环境

- Snapshots to restore complex environments instantly instead of rebuilding

- 快照能力：可即时恢复复杂环境，无需重新构建

- Fluid compute with Active CPU pricing for cost and performance efficiency

- 灵活的计算资源调度，配合“活跃CPU计费”模式，兼顾成本效益与性能效率

We’ve spent years solving these problems for deployments. Sandbox applies the same approach to agent compute.

我们已花费多年时间解决部署场景中的上述问题。Sandbox 将同样的方法论应用于智能体计算（agent compute）。

## What is Vercel Sandbox?

## 什么是 Vercel Sandbox？

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 提供按需启动的 Linux 微型虚拟机（microVM）。每个 sandbox 均相互隔离，拥有独立的文件系统、网络环境和进程空间。

您将获得 `sudo` 权限、软件包管理器，以及在标准 Linux 机器上所能执行的全部命令能力。

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();



await sandbox.runCommand({

6  cmd: 'node',

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

8  stdout: process.stdout,

9});



await sandbox.stop();
```

沙盒（Sandboxes）在设计上就是临时性的。它们会按需运行，任务完成后自动关闭；您只需为实际占用的 CPU 时间付费，空闲时间不计费。

这与智能体（agents）的工作方式高度契合。单个任务可能涉及数十次启动、运行和清理循环，基础设施必须能够持续跟上这种高频操作。

## 团队如何使用 Sandbox

## 团队如何使用沙盒（Sandbox）

### [Roo Code](https://roocode.com/)

### [Roo Code](https://roocode.com/)

Roo Code 构建跨 Slack、Linear、GitHub 及其网页界面运行的 AI 编程智能体。当您触发某个智能体时，获得的是一个可交互的正在运行的应用程序，而不仅仅是一段代码补丁（patch）。

Roo Code 构建跨 Slack、Linear、GitHub 及其网页界面运行的 AI 编程智能体。当您触发某个智能体时，获得的是一个可交互的正在运行的应用程序，而不仅仅是一段代码补丁（patch）。

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_001.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_002.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_003.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_004.jpg)

> “The agent operates inside a complete environment where services can run together, so it can test changes end-to-end before handing you something to review. Instead of ‘review a patch and hope,’ you get a preview you can engage with as the agent iterates. The agent operates inside a complete environment where services can run together, so it can test changes end-to-end before handing you something to review. Instead of ‘review a patch and hope,’ you get a preview you can engage with as the agent iterates.”

> “代理在完整的环境中运行，各项服务可协同工作，因此可在交付您审阅前完成端到端的变更验证。我们摒弃了‘审阅补丁、寄望成功’的传统模式，转而为您提供一个可交互的实时预览——随着代理持续迭代，您亦可同步参与其中。代理在完整的环境中运行，各项服务可协同工作，因此可在交付您审阅前完成端到端的变更验证。我们摒弃了‘审阅补丁、寄望成功’的传统模式，转而为您提供一个可交互的实时预览——随着代理持续迭代，您亦可同步参与其中。”

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_005.jpg)

**Matt Rubens,** CEO Roo Code  
**Matt Rubens，** Roo Code 首席执行官

Snapshots changed their architecture. They snapshot the environment so later runs can restore a known state instead of starting from scratch, skipping repo cloning, dependency installs, and service boot time.  
快照（Snapshots）重构了其架构：通过对整个运行环境进行快照，后续执行可直接恢复至已知状态，无需从零开始——跳过代码仓库克隆、依赖安装及服务启动等耗时环节。

> “Snapshots turn agents from stateless workers into persistent collaborators. Start a task on Monday, snapshot it, resume Thursday when stakeholders can review. Branch from a working state and try two approaches in parallel. Snapshots turn agents from stateless workers into persistent collaborators. Start a task on Monday, snapshot it, resume Thursday when stakeholders can review. Branch from a working state and try two approaches in parallel.”

> “快照将代理从无状态的工作单元转变为具备持续记忆的协作伙伴。您可在周一启动一项任务，创建快照；待周四相关方准备就绪时，直接恢复快照继续推进。更可基于一个稳定可用的状态创建分支，同步尝试两种不同方案。快照将代理从无状态的工作单元转变为具备持续记忆的协作伙伴。您可在周一启动一项任务，创建快照；待周四相关方准备就绪时，直接恢复快照继续推进。更可基于一个稳定可用的状态创建分支，同步尝试两种不同方案。”

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_005.jpg)

**Matt Rubens,** CEO Roo Code  
**Matt Rubens，** Roo Code 首席执行官

### [Blackbox AI](https://www.blackbox.ai/)

### [Blackbox AI](https://www.blackbox.ai/)

Blackbox AI built Agents HQ, a unified orchestration platform that integrates multiple AI coding agents through a single API. It runs tasks inside Vercel Sandboxes.  
Blackbox AI 构建了 Agents HQ —— 一个统一编排平台，通过单一 API 集成多个 AI 编程代理，并在 Vercel Sandbox 中执行各项任务。

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_007.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_008.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_009.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_010.jpg)

> “The decision to standardize on Vercel’s sandbox infrastructure was driven by two critical performance metrics: infrastructure stability and cold start performance. Sub-second sandbox initialization times enabled rapid task distribution and reduced end-to-end execution latency, which proved essential for production-grade agent orchestration. The decision to standardize on Vercel’s sandbox infrastructure was driven by two critical performance metrics: infrastructure stability and cold start performance. Sub-second sandbox initialization times enabled rapid task distribution and reduced end-to-end execution latency, which proved essential for production-grade agent orchestration.”

> “我们决定全面采用 Vercel 的沙盒基础设施，主要基于两项关键性能指标：基础设施稳定性与冷启动性能。亚秒级的沙盒初始化时间，显著加快了任务分发速度，并降低了端到端执行延迟——这对生产级代理编排至关重要。我们决定全面采用 Vercel 的沙盒基础设施，主要基于两项关键性能指标：基础设施稳定性与冷启动性能。亚秒级的沙盒初始化时间，显著加快了任务分发速度，并降低了端到-end执行延迟——这对生产级代理编排至关重要。”

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_011.png)

**Robert Rizk,** Co-founder and CEO of Blackbox AI  
**Robert Rizk，** Blackbox AI 联合创始人兼首席执行官

This supports horizontal scaling for high-volume concurrent execution. Blackbox can dispatch tasks to multiple agents in parallel, each in an isolated sandbox, without resource contention.  
该能力支撑高并发场景下的水平扩展。Blackbox 可并行向多个代理分发任务，每个代理均运行于相互隔离的沙盒中，彻底避免资源争用。

> “By using Vercel sandboxes to let users run AI agents at scale, we enable organizations to treat AI agents as reliable, scalable compute primitives within their development and production systems. By using Vercel sandboxes to let users run AI agents at scale, we enable organizations to treat AI agents as reliable, scalable compute primitives within their development and production systems.”

> “借助 Vercel 沙盒支持用户规模化运行 AI 代理，我们助力企业将 AI 代理视为开发与生产系统中可靠、可伸缩的基础计算单元。借助 Vercel 沙盒支持用户规模化运行 AI 代理，我们助力企业将 AI 代理视为开发与生产系统中可靠、可伸缩的基础计算单元。”

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_011.png)

**Robert Rizk,** Co-founder and CEO of Blackbox AI  
**Robert Rizk，** Blackbox AI 联合创始人兼首席执行官

## Create your first sandbox with one command in the CLI

## 通过 CLI 一条命令创建您的首个沙盒

```typescript
npx sandbox create --connect
```

```typescript
npx sandbox create --connect
```

Explore the [documentation](https://vercel.com/docs/vercel-sandbox) to get started, and check out the [open-source SDK](https://github.com/vercel/sandbox).

请查阅 [文档](https://vercel.com/docs/vercel-sandbox) 以快速上手，并查看 [开源 SDK](https://github.com/vercel/sandbox)。
{% endraw %}
