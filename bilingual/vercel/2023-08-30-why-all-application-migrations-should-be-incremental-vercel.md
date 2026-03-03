---
title: "Why all application migrations should be incremental  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/incremental-migrations"
date: "2023-08-30"
scraped_at: "2026-03-02T09:51:26.141150163+00:00"
language: "en-zh"
translated: true
description: "Projects that require migrations should aim for incremental migrations"
---

Aug 30, 2023

2023年8月30日

Large migrations are inevitable, but they don't have to be painful or risky. Learn why incrementally migrating is the solution.

大型迁移不可避免，但未必意味着痛苦或高风险。了解为何渐进式迁移是更优解。

In 2023, there are few software projects that are true greenfield endeavors. Instead, migrations of existing systems are the new normal. Migrations done wrong can introduce substantial business and timeline risks into any software project. An incremental migration strategy can minimize those risks while pulling forward validation of business impact.

2023年，真正从零开始（greenfield）的软件项目已极为罕见；相反，对现有系统的迁移已成为新常态。若迁移执行不当，可能给任何软件项目带来重大的业务与工期风险。而采用渐进式迁移策略，不仅能最大限度降低此类风险，还能提前验证迁移所带来的实际业务影响。

Vercel’s product is designed to support incremental migration from the ground up. In this post you'll get a high-level overview of incremental migration strategies and considerations.

Vercel 的产品自设计之初便全面支持渐进式迁移。本文将为您概览渐进式迁移的核心策略与关键考量因素。

## Why migrate incrementally?

## 为何要采用渐进式迁移？

Almost all software projects that require migrations should aim for incremental migrations in order to:

几乎所有需要迁移的软件项目，都应以渐进式迁移为目标，原因在于：

- Minimize risk by reducing the scope of the individual steps of the migration.

- 通过缩小每次迁移步骤的范围，降低整体风险。

- Minimize risk by having a more natural path to rolling back in the case of unexpected issues.

- 在出现意外问题时，提供更自然、更可控的回滚路径，从而降低风险。

- Allow validating the technical implementation and business value substantially earlier in the process.

- 显著提前完成技术实现与业务价值的双重验证。

- Achieve downtime-free migration without maintenance windows.

- 实现零停机迁移，无需安排维护窗口期。

### Understanding big bang migrations

### 理解“大爆炸式”迁移

Big bang migrations are migrations in which a system is replaced in a one-time full switchover. There may be intermediate steps, but they are all performed in very short order. Basically, you pick a date, and on that date, all usage is moved from the legacy system to the new system.

“大爆炸式”迁移是指系统通过一次性、全面切换的方式完成替换的迁移方式。过程中可能包含若干中间步骤，但所有步骤均需在极短时间内集中执行。本质上，你选定一个日期，就在该日期将全部业务流量从遗留系统整体切换至新系统。

![](images/why-all-application-migrations-should-be-incremental-vercel/img_001.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_002.jpg)

Problems with big bang migrations can include:

“大爆炸式”迁移可能存在的问题包括：

- You may go through the entire process only to learn that there are product problems that are very expensive to fix this late in the program.

- 整个迁移流程走完后，才发现存在产品层面的问题，而此时已临近项目尾声，修复成本极高。

- Rehearsals are inherently difficult to execute, making it hard to assess upfront whether a migration will succeed.

- 预演（rehearsal）本身难以真实开展，导致难以在迁移启动前准确评估其成功概率。

- You may reach a point of no return where a migration has to be completed even if major problems are noticed while it is happening.

- 迁移过程中可能进入“不可回退点”（point of no return），即使发现严重问题，也不得不强行完成迁移。

- It may be required to take the legacy system offline while the migration is happening leading to lost business. Such maintenance windows often escalate in duration as issues are only discovered while the migration is running.

- 迁移期间可能需要将遗留系统下线，从而造成业务中断与损失。此类维护窗口（maintenance window）的时长往往随着迁移过程中的问题暴露而不断延长。

### What is an incremental migration?

### 什么是渐进式迁移？

![](images/why-all-application-migrations-should-be-incremental-vercel/img_003.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_004.jpg)

An incremental migration strategy involves gradually transitioning to a new or significantly updated software system. During this process, both the old and new systems run simultaneously, and either features or users are moved over in phases instead of all at once.

增量迁移策略是指逐步过渡到一个全新或经过重大更新的软件系统。在此过程中，新旧系统并行运行，功能或用户分阶段迁移，而非一次性全部切换。

There are two major types of incremental migrations:

增量迁移主要有两种类型：

**1\. Vertical: Feature-by-feature increments**

**1. 垂直迁移：按功能逐项迁移**

![](images/why-all-application-migrations-should-be-incremental-vercel/img_005.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_006.jpg)

![](images/why-all-application-migrations-should-be-incremental-vercel/img_005.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_006.jpg)

In this strategy, subsets of system functionality are switched to the new system. Think of this as migrating one feature at a time where both systems are operating in parallel and functionality is routed to the new or legacy system based on whether the respective feature has been migrated or not.

该策略将系统功能的子集逐步切换至新系统。可将其理解为“一次迁移一个功能”：新旧系统并行运行，具体功能路由至新系统还是遗留系统，取决于该功能是否已完成迁移。

**2\. Horizontal: User-by-user increments**

**2. 水平迁移：按用户逐批迁移**

![](images/why-all-application-migrations-should-be-incremental-vercel/img_007.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_008.jpg)

![](images/why-all-application-migrations-should-be-incremental-vercel/img_007.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_008.jpg)

In horizontal migrations, while "users" are commonly the main unit being moved, other entities can be used instead. The ideal choice would be an entity that can be easily divided or "sharded" within a system, ensuring minimal interaction between these separate shards.

在水平迁移中，尽管“用户”通常是主要的迁移单位，但也可选用其他实体替代。“理想”的迁移单位应是系统内易于划分（即“分片”）的实体，从而确保各分片之间交互最少。

It would not be uncommon to see vertical and horizontal incremental migration strategies combined in complex migrations. In that case you’d see a user-by-user migration on per-feature basis.

在复杂的迁移场景中，垂直迁移与水平迁移策略相结合并不罕见；此时，迁移将表现为“按功能维度逐用户推进”。

## Trade-offs of incremental migrations

## 增量迁移的权衡考量

The primary trade-off of incremental migrations is the introduction of additional effort to implement the interop between the new and legacy system. This must be weighed against the reduction in risk and faster time to business validation.

增量迁移的主要权衡在于：为实现新系统与遗留系统之间的互操作性（interop），需额外投入开发工作量。这一成本必须与风险降低程度以及业务验证周期的缩短效果进行综合权衡。

This is particularly challenging if the systems have to access each other’s data. In case of a horizontal incremental migration, picking the right unit of increment is the most crucial decision to minimize data dependencies. Common entities where this is true is a "user," or an "organization."

当两个系统需要相互访问对方的数据时，这一挑战尤为突出。在水平式增量迁移中，选择恰当的“增量单元”是最大限度减少数据依赖关系的最关键决策。典型的适用实体包括“用户”（user）或“组织”（organization）。

## Frontend migrations

## 前端迁移

Frontend migrations are a special case of migration in which a frontend layer is migrated while the backend stays stable. Frontend migrations are generally easier to execute because the stateful data continues to be handled by the same "system of record," and only the rendering and processing for the backend’s data is updated.

前端迁移是一类特殊的迁移场景，其特点是仅迁移前端层，而后端保持稳定。此类迁移通常更易执行，因为有状态数据仍由同一套“权威数据源系统”（system of record）统一管理，仅需更新对后端数据的渲染逻辑与处理逻辑。

While the term "frontend" sometimes evokes expectations of user interfaces and similar modalities, the principle of layered migration can be extended deep into larger systems: for example, even if entire systems are exchanged including their primary database, it can be helpful to keep the data-warehouse layer stable and to ingest data from legacy and new systems concurrently.

尽管“前端”一词有时会让人联想到用户界面等交互模态，但分层迁移的原则可深度延伸至更大型的系统架构中：例如，即便整个系统（包括其主数据库）都被替换，仍可保持数据仓库层稳定，并同时从遗留系统和新系统中摄取数据。

![](images/why-all-application-migrations-should-be-incremental-vercel/img_009.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_010.jpg)

Not changing the analytics layers at the same time as applications has the additional benefit of retaining a reliable system for the purpose of judging the performance of the new system.

在迁移应用系统的同时不变更分析层（analytics layers），还能带来另一项优势：保留一个可靠的基准系统，用以客观评估新系统的运行表现。

![](images/why-all-application-migrations-should-be-incremental-vercel/img_011.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_012.jpg)

## Migrating from monolithic to composable architecture

## 从单体架构向可组合架构迁移

A special case of such a frontend migration is one where the legacy system wasn’t properly decomposed into backend and frontend. If the goal is to switch to a new frontend, it may be possible to introduce an API into the legacy system such that a new frontend can be introduced while keeping the existing system around as a backend.

此类前端迁移的一种特殊情形是：遗留系统本身并未被合理地划分为后端与前端两层。若目标是切换至全新前端，则可在遗留系统中引入一套 API，从而在保留原有系统作为后端的前提下，逐步接入新前端。

The above is common when companies bought into monolithic systems that coupled frontend and backend into a single system. As these companies want more control over the user interface they are presenting to their users, they often introduce separated frontends that treat the previous monolith as an API service.

上述情况在企业采用将前端与后端耦合于单一系统的单体架构时十分常见。随着这些企业希望对其面向用户的界面拥有更多控制权，它们往往引入独立的前端，并将原有的单体系统视作 API 服务来调用。

### Migrating a web frontend

### 迁移 Web 前端

The key primitive to incremental migration of web frontends is the [reverse proxy](https://vercel.com/docs/edge-network/rewrites). Reverse proxies allow a web server to serve content from multiple different web servers under its primary domain.

增量式迁移 Web 前端的核心机制是[反向代理](https://vercel.com/docs/edge-network/rewrites)。反向代理使一个 Web 服务器能够在其主域名下，聚合并提供来自多个不同 Web 服务器的内容。

![](images/why-all-application-migrations-should-be-incremental-vercel/img_013.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_014.jpg)

![](images/why-all-application-migrations-should-be-incremental-vercel/img_013.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_014.jpg)

### Step 1: Introduce a reverse proxy with zero change in functionality

### 第一步：引入零功能变更的反向代理

Step 1 of any migration to new serving infrastructure is to introduce a reverse proxy that forwards all requests to the legacy infra. The reverse proxy can:

任何迁移到新服务基础设施的第一步，都是引入一个将所有请求转发至遗留基础设施的反向代理。该反向代理可以：

- Be co-located with the new frontend (recommended)

- 与新前端共置（推荐）

- Be the legacy frontend

- 由遗留前端自身承担

- Be a dedicated system that is introduced specifically for the migration

- 是为本次迁移专门引入的独立系统

Co-locating the reverse proxy with the new frontend is recommended because it allows exposing the new infrastructure to production traffic without expected behavior changes.

推荐将反向代理与新前端共置，因为这种方式可在不引发预期行为变化的前提下，将新基础设施逐步暴露给生产流量。

Vercel applications come with built-in reverse proxy functionality to help implement such migrations. Notably, the reverse proxy can be programmed through [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) which helps implementing the migration increments as well as request adapters between new and legacy systems.

Vercel 应用内置反向代理功能，可助力此类迁移的实施。值得注意的是，该反向代理可通过 [Edge Middleware（边缘中间件）](https://vercel.com/docs/functions/edge-middleware) 进行编程，从而支持分阶段实施迁移，并在新旧系统之间构建请求适配器。

When this stage is complete the new infrastructure is formally in production yet all actual logic gets served by the legacy system. We expect zero behavior changes after step 1, so it is easy to verify that this step of the migration was successful.

当此阶段完成时，新基础设施已正式上线投入生产，但所有实际业务逻辑仍由遗留系统提供服务。我们预期第 1 步完成后行为零变化，因此很容易验证该迁移步骤是否成功。

### Step 2: Start migrating parts of the traffic

### 第 2 步：开始迁移部分流量

At the beginning of step 2, the new system serves all of the traffic but none of the actual application logic. The new system can now be configured to take over part of the traffic while continuing to proxy all other traffic to the legacy system.

在第 2 步初期，新系统承接全部流量，但不执行任何实际应用逻辑；此时可配置新系统接管其中一部分流量，其余流量则继续通过反向代理转发至遗留系统。

For example, in a web shop one might start serving a subset of the product detail pages from the new system while everything else is proxied. These increments in functionality can be validated one step at a time.

例如，在一个电商网站中，可先由新系统提供部分商品详情页，其余所有页面仍通过代理访问遗留系统。此类功能增量可逐项验证。

Over time a larger and larger percentage of pages are served by the new system, until eventually 100% of traffic is fulfilled directly by the new system. At this stage the reverse proxy to the legacy system can be shut down and the migration in terms of user-visible effects is complete.

随着时间推移，由新系统直接服务的页面比例逐步扩大，最终实现 100% 的流量均由新系统直接响应。此时，通往遗留系统的反向代理即可停用，从用户可见效果角度看，迁移即告完成。

### Traffic migrations

### 流量迁移

Traffic migrations are a special case of a horizontal incremental migration.

流量迁移是水平式渐进迁移的一种特殊形式。

[Vercel](https://vercel.com/) itself is currently in the middle of a major incremental migration of its primary serving system. The team has chosen an incremental migration strategy paired with dark launches. Their goal for the new system is to have bug-for-bug compatibility with the legacy system while substantially improving latency and CPU usage.

[Vercel](https://vercel.com/) 自身目前正处在其核心服务系统的一次重大渐进式迁移过程中。团队选择了“渐进式迁移 + 暗发布（dark launch）”相结合的策略。新系统的设计目标是在保持与遗留系统逐 Bug 兼容的前提下，显著降低延迟并优化 CPU 使用率。

A [dark launch](https://cloud.google.com/blog/products/gcp/cre-life-lessons-what-is-a-dark-launch-and-what-does-it-do-for-me) is the introduction of a secondary system while an existing system continues to serve the user-facing traffic. In our dark launch phase we send traffic both to the old and new system and compare the results to validate that they behave exactly the same.

[暗发布（dark launch）](https://cloud.google.com/blog/products/gcp/cre-life-lessons-what-is-a-dark-launch-and-what-does-it-do-for-me) 是指在现有系统持续处理面向用户的流量的同时，引入一套辅助系统。在我们的暗发布阶段，我们会将流量同时发送至新旧两套系统，并比对输出结果，以验证二者行为完全一致。

Naturally, a dark launch uses additional resources (since both old and new systems are engaged for the same traffic effectively doubling processing needs). Respectively, it is advisable to only run a subset of traffic through the dark launch path.

自然地，暗启动会消耗额外资源（因为新旧系统同时处理相同流量，相当于使计算需求翻倍）。因此，建议仅将一部分流量通过暗启动路径进行处理。

At Vercel, our incremental rollout plan looks like this:

在 Vercel，我们的渐进式上线计划如下：

- Dark launch for X% of traffic

- 针对 X% 的流量实施暗启动

- Observe differences in responses between old and new system

- 观察新旧系统响应结果的差异

- If needed, fix the behavior of the new system

- 如有必要，修复新系统的行为

- Validate that the new system does, indeed, improve latency and CPU usage

- 验证新系统是否确实降低了延迟并减少了 CPU 使用率

- Once the dark launch behaves sufficiently like the new system and the goals of the new system achieved, switch the same X% of traffic over to the new system

- 一旦暗启动的表现已足够接近新系统，且新系统的目标均已达成，便将同样 X% 的流量正式切换至新系统

- Repeat until 100% of traffic is migrated

- 重复上述步骤，直至 100% 的流量完成迁移

As of today, we've successfully finished this migration and are now serving 100% of traffic on the new system.

截至今日，我们已成功完成此次迁移，目前全部流量（100%）均已由新系统承载。

## Summary

## 总结

Incremental migrations can seem like additional scope that one might wish to avoid, but mature organizations realize that they are usually worth the effort. Incremental migrations minimize risk, improve the time to validating the business value of a change, and eliminate planned downtime.

渐进式迁移看似增加了额外的工作范围，令人望而却步；但成熟的组织深知，这类迁移通常物有所值。渐进式迁移可显著降低风险、加快验证变更商业价值所需的时间，并彻底消除计划内停机。

Frontend migrations are a special case of migrations where systems of record stays the same while the frontend is replaced. Migrations to Vercel are often such frontend migrations. Our platform provides specialized tools to support such migration through reverse proxying and fine-grained request management in [Edge Middleware](https://vercel.com/docs/functions/edge-middleware).

前端迁移是迁移的一种特殊形式，其特点是“系统记录源”（systems of record）保持不变，仅替换前端层。迁移到 Vercel 的场景往往就属于此类前端迁移。我们的平台通过反向代理及 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) 中细粒度的请求管理，提供专门工具以支持此类迁移。

[**Start building securely**\\
\\
Our experts can help you navigate Vercel for your team's unique needs.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即安全构建**\\
\\
我们的专家可协助您根据团队的独特需求，高效使用 Vercel。\\
\\
联系我们](https://vercel.com/contact/sales)