---
render_with_liquid: false
title: "Inside Workflow DevKit: How framework integrations work - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/inside-workflow-devkit-how-framework-integrations-work"
date: "2025-12-09"
scraped_at: "2026-03-02T09:24:20.585778495+00:00"
language: "en-zh"
translated: true
description: "A deep dive into how Workflow DevKit integrates with modern frameworks, from Next.js and SvelteKit to Express and Hono, using a unified pattern for creating framework integrations."
---
render_with_liquid: false
render_with_liquid: false

Dec 9, 2025

2025 年 12 月 9 日

When we announced the [Workflow Development Kit (WDK)](https://vercel.com/blog/introducing-workflow) at Ship AI just over a month ago, we wanted it to reflect our [Open SDK Strategy](https://vercel.com/blog/open-sdk-strategy), allowing developers to build with any framework and deploy to any platform.

一个多月前，我们在 Ship AI 大会上宣布了 [Workflow Development Kit（WDK）](https://vercel.com/blog/introducing-workflow)，初衷正是践行我们的 [Open SDK Strategy（开放 SDK 战略）](https://vercel.com/blog/open-sdk-strategy)，让开发者能够自由选用任意框架进行开发，并将应用部署至任意平台。

At launch, WDK supported Next.js and Nitro. Today it works with eight frameworks, including SvelteKit, Astro, Express, and Hono, with TanStack Start and React Router in active development. This post explains the pattern behind those integrations and how they work under the hood.

发布之初，WDK 仅支持 Next.js 和 Nitro。如今，它已兼容八种主流框架，包括 SvelteKit、Astro、Express 和 Hono；而 TanStack Start 与 React Router 的集成也正处于积极开发中。本文将深入剖析这些框架集成背后的设计模式，以及其底层工作原理。

## The pattern behind every WDK integration

## 每个 WDK 集成背后的设计模式

On the surface, integrating WDK with Next.js looks nothing like integrating it with Express or SvelteKit. They all have different bundlers, routing systems, and developer experiences. But at its core, every framework integration follows the same two-phase pattern.

表面上看，WDK 与 Next.js 的集成方式与它和 Express 或 SvelteKit 的集成截然不同：各框架所用的打包器、路由系统及开发者体验均不相同。但本质上，所有框架集成均遵循同一套“两阶段”模式。

### Build-time: Generating workflow handlers

### 构建时：生成工作流处理器（workflow handlers）

The build-time phase compiles your workflow and step functions into executable handler files. It handles bundling, determines where files are output, and applies any framework-specific patches needed for compatibility. This phase also configures hot module replacement, so developers can see workflow changes instantly without restarting their development server.

构建阶段负责将您的工作流（workflow）及步骤函数（step functions）编译为可执行的处理器文件（handler files）。该阶段完成代码打包、确定输出路径，并应用必要的框架专属补丁以确保兼容性。此外，此阶段还配置热模块替换（HMR），使开发者无需重启开发服务器即可即时查看工作流的变更效果。

### Runtime: Exposing handlers as endpoints

### 运行时：将处理器暴露为 HTTP 端点

The runtime phase applies workflow client transforms and makes the handler files from the build-time phase accessible by your application's server. Your workflows become reachable via HTTP without any manual endpoint configuration.

运行阶段负责应用工作流客户端转换（workflow client transforms），并将构建阶段生成的处理器文件交由应用程序服务器调用。由此，您的工作流可通过 HTTP 直接访问，全程无需手动配置任何端点。  

How these handlers are exposed as endpoints differs widely between frameworks, but the process is always the same.

尽管不同框架暴露这些处理器为端点的具体方式差异显著，但其整体流程始终如一。

### How WDK's three transform modes work

### WDK 的三种转换模式如何工作

The magic happens in WDK's SWC compiler plugin, which transforms the same input file into three different outputs depending on the mode.

魔法发生在 WDK 的 SWC 编译器插件中：该插件根据所选模式，将同一输入文件转换为三种不同的输出。

1. **Client mode** runs during your framework's build via a Rollup or Vite plugin. It transforms workflow calls into HTTP client code and adds `workflowId` properties.

1. **客户端模式（Client mode）** 在您的框架构建过程中运行（通过 Rollup 或 Vite 插件）。它将工作流调用转换为 HTTP 客户端代码，并添加 `workflowId` 属性。

2. **Step mode** runs during WDK's esbuild phase. It transforms `"use step"` functions into HTTP handlers that execute your step logic on the server.

2. **步骤模式（Step mode）** 在 WDK 的 esbuild 阶段运行。它将 `"use step"` 函数转换为 HTTP 处理器，使其在服务器端执行您的步骤逻辑。

3. **Workflow mode** also runs during esbuild. It transforms `"use workflow"` functions into orchestrators that run in a sandboxed virtual environment.

3. **工作流模式（Workflow mode）** 同样在 esbuild 阶段运行。它将 `"use workflow"` 函数转换为编排器（orchestrators），这些编排器在沙箱化的虚拟环境中运行。

This means you write your code once, and the compiler generates the client, step handler, and workflow handler automatically.

这意味着您只需编写一次代码，编译器便会自动为您生成客户端代码、步骤处理器和工作流处理器。

![](images/inside-workflow-devkit-how-framework-integrations-work-vercel/img_001.svg)![](images/inside-workflow-devkit-how-framework-integrations-work-vercel/img_002.svg)

[**Custom Workflow DevKit Framework Integrations**\\
\\
Create your own Workflow DevKit framework integrations following an in-depth guide.\\
\\
Learn More](https://useworkflow.dev/docs/how-it-works/framework-integrations)

[**自定义 Workflow DevKit 框架集成**\\
\\
参考详尽指南，创建您自己的 Workflow DevKit 框架集成。\\
\\
了解更多](https://useworkflow.dev/docs/how-it-works/framework-integrations)

### A pattern in practice: SvelteKit

### 实践中的模式：SvelteKit

To show how this works, let's take a look at the SvelteKit integration. SvelteKit is a framework built on top of Vite with file-based routing. Setting up WDK in a SvelteKit app takes one line.

为说明其工作原理，我们以 SvelteKit 集成为例。SvelteKit 是一个基于 Vite 构建的框架，采用基于文件的路由机制。在 SvelteKit 应用中配置 WDK 仅需一行代码。

vite.config.ts

vite.config.ts

```typescript
import { sveltekit } from "@sveltejs/kit/vite";

import { workflowPlugin } from "workflow/sveltekit";

export default {
  plugins: [
    sveltekit(),
    workflowPlugin()
  ]
};
```

```typescript
import { sveltekit } from "@sveltejs/kit/vite";

import { workflowPlugin } from "workflow/sveltekit";

export default {
  plugins: [
    sveltekit(),
    workflowPlugin()
  ]
};
```

That’s all! Behind the scenes, [`workflowPlugin()`](https://github.com/vercel/workflow/blob/main/packages/sveltekit/src/plugin.ts) implements both phases:

就这样！在幕后，[`workflowPlugin()`](https://github.com/vercel/workflow/blob/main/packages/sveltekit/src/plugin.ts) 实现了以下两个阶段：

### Build-time

### 构建时（Build-time）

Two things happen in parallel.

两件事并行发生。

- **Client transformation (Vite + Rollup)**: The `workflowTransformPlugin()` from `@workflow/rollup` hooks into Vite's build and uses SWC with `mode: 'client'` to transform your imports when you call `start(myWorkflow, [...])`, adding an `id` property to workflows  

- **客户端转换（Vite + Rollup）**：来自 `@workflow/rollup` 的 `workflowTransformPlugin()` 钩入 Vite 构建流程，并在调用 `start(myWorkflow, [...])` 时，使用 SWC（配置 `mode: 'client'`）转换你的导入语句，为工作流（workflow）自动添加 `id` 属性。

- **Handler generation (esbuild)**: The `SvelteKitBuilder` creates two bundles (one for steps with `mode: 'step'` and one for workflows with `mode: 'workflow'`). These become the `+server.js` files in `src/routes/.well-known/workflow/v1`  

- **处理器生成（esbuild）**：`SvelteKitBuilder` 会生成两个打包产物（一个用于 `mode: 'step'` 的步骤，另一个用于 `mode: 'workflow'` 的工作流），并将其输出为 `src/routes/.well-known/workflow/v1` 目录下的 `+server.js` 文件。

### Runtime

### 运行时

SvelteKit's file-based routing automatically discovers these generated files and exposes them as HTTP endpoints, as long as the file is named `+server.js`. No manual wiring needed.

SvelteKit 基于文件的路由机制会自动识别这些生成的文件，并在文件名为 `+server.js` 时，将其暴露为 HTTP 端点——无需任何手动配置或连接。

This same plugin-based approach works across many Vite-based frameworks. For example, the Astro integration is nearly identical because they share Vite's plugin system, hot module replacement, and file-based routing. The main differences are where routes are output and what framework-specific patches are needed for compatibility.

这种基于插件的方案同样适用于众多基于 Vite 的框架。例如，Astro 的集成几乎完全一致，因为二者共享 Vite 的插件系统、热模块替换（HMR）以及基于文件的路由机制。主要差异仅在于路由文件的输出位置，以及为保障兼容性所需引入的框架特有补丁。

For frameworks without a bundler like Express or Hono, we use Nitro instead. Nitro is a server toolkit that provides file-based routing, a build system, and other quality-of-life features such as virtual handlers that can be mounted to a server at runtime. This brings the same workflow capabilities to bare HTTP servers.

对于 Express 或 Hono 等本身不包含打包器的框架，我们转而采用 Nitro。Nitro 是一款服务端工具包，提供基于文件的路由、构建系统，以及其他提升开发体验的功能（例如可在运行时挂载到服务器上的虚拟处理器）。这使得纯 HTTP 服务器也能获得同等的工作流能力。

### Why framework request objects required conversion

### 为何需对框架的请求对象进行转换

A challenge that appeared while creating multiple framework integrations was that different frameworks have different opinions on what a "request" looks like. SvelteKit passes a custom request object to route handlers, but our workflow handlers expect the standard Web Request API.

在为多个框架开发集成时，一个突出挑战是：不同框架对“请求对象”（request object）的定义各不相同。SvelteKit 向路由处理器传递的是其自定义的请求对象，而我们的工作流处理器则依赖标准的 Web Request API。

We fixed this by injecting a small converter function into each generated handler.

我们通过向每个生成的处理器中注入一个轻量级转换函数，解决了这一问题。

`+server.js`  

`+server.js`

```javascript
async function convertSvelteKitRequest(request) {

2  const options = {

3    method: request.method,

4    headers: new Headers(request.headers)

5  };

6  if (!['GET', 'HEAD'].includes(request.method)) {

7    options.body = await request.arrayBuffer();

8  };

9  return new Request(request.url, options);

10};
```

```javascript
async function convertSvelteKitRequest(request) {

2  const options = {

3    method: request.method,

4    headers: new Headers(request.headers)

5  };

6  if (!['GET', 'HEAD'].includes(request.method)) {

7    options.body = await request.arrayBuffer();

8  };

9  return new Request(request.url, options);

10};
```

This helper function is injected into each workflow handler file to be compatible with SvelteKit

该辅助函数被注入到每个工作流处理器文件中，以确保与 SvelteKit 兼容。

## Hot Module Replacement

## 热模块替换（HMR）

To ensure developers can iterate to greatness fast, workflow has to support hot module replacement, allowing developers to change workflows and see instant feedback without having to restart their development server.

为确保开发者能够快速迭代、持续精进，工作流必须支持热模块替换（HMR），使开发者在修改工作流时无需重启开发服务器，即可立即获得反馈。

When you save a workflow file in SvelteKit, three things happen:

在 SvelteKit 中保存一个工作流文件时，将发生以下三件事：

1. Vite's `hotUpdate` hook fires with the changed file

1. Vite 的 `hotUpdate` 钩子被触发，并传入已更改的文件。

2. We check for `"use workflow"` or `"use step"` directives

2. 我们检查是否存在 `"use workflow"` 或 `"use step"` 指令。

3. If found, trigger an esbuild rebuild

3. 若检测到上述指令，则触发 esbuild 重新构建。

packages/sveltekit/src/plugin.ts

packages/sveltekit/src/plugin.ts

```typescript
async hotUpdate({ file, read }) {

2  const content = await read();
```

```typescript
async hotUpdate({ file, read }) {

2  const content = await read();
```

4  const useWorkflowPattern = /^\s*(['"])use workflow\1;?\s*$/m;

4  const useWorkflowPattern = /^\s*(['"])use workflow\1;?\s*$/m;

5  const useStepPattern = /^\s*(['"])use step\1;?\s*$/m;

5  const useStepPattern = /^\s*(['"])use step\1;?\s*$/m;

8  if (!useWorkflowPattern.test(content) && !useStepPattern.test(content)) {

8  如果 `useWorkflowPattern.test(content)` 和 `useStepPattern.test(content)` 均为 `false`：

9    return; // Not a workflow file, let Vite handle normally

9    return; // 非工作流文件，交由 Vite 正常处理

10  }

10  }

12  await enqueue(() => builder.build()); // Queue rebuild with esbuild: important if concurrent builds ever happen

12  await enqueue(() => builder.build()); // 使用 esbuild 将重建任务加入队列：若未来支持并发构建，此步骤至关重要

13};


```

Workflow DevKit 在基于 Vite 的框架中启用热模块替换（HMR）的最小示例

## 将该模式扩展至各类框架

在构建多个框架集成的过程中，我们发现主流框架大致可分为两类。

### ) **基于文件路由的框架**（Next.js、SvelteKit、Nuxt）

这类框架的集成非常直接。在构建阶段，Workflow DevKit 会将工作流处理器文件输出至各框架约定的特定目录（例如：Next.js 对应 `app/.well-known/workflow/v1`，SvelteKit 对应 `src/routes/.well-known/workflow/v1`），框架随后会自动识别这些文件为 HTTP 端点。整个过程无需手动配置路由绑定，但不同框架在端点定义与处理方式上存在差异，因此仍需针对各框架打不同的补丁。

### ) **HTTP 服务器框架**（Express、Hono）

这类框架本身不附带构建系统——即没有内置打包器（bundler），仅提供一个裸露的 HTTP 服务器。此时 Nitro 就发挥了关键作用。对于此类框架，Workflow DevKit 使用 esbuild 对工作流进行打包，再由 Nitro 将其挂载为虚拟处理器（virtual handlers）。在运行时，Nitro 会包裹（wrap）你的 HTTP 服务器，并注入这些虚拟处理器，从而将工作流端点暴露出来，使其可通过你的 HTTP 服务器被正常访问。

当前许多现代框架都基于 Vite 构建（如 SvelteKit、Astro、Nuxt）。这意味着插件注册、HMR 配置及客户端转换（client transforms）等核心集成逻辑，在这些框架之间高度相似，几乎完全一致。因此，我们只需一次性构建核心的 Vite 集成能力，再根据各框架特有的路由机制进行适配即可。

## Opening up workflows to every framework

## 向所有框架开放工作流

Building these integrations revealed how framework choice can create unnecessary barriers for adoption. Each integration opened up WDK to an entire developer community that was already committed to their framework of choice.

构建这些集成揭示了框架选型可能为采用带来不必要的障碍。每一次集成，都将 WDK 开放给了一个早已坚定选择特定框架的完整开发者社区。

The SvelteKit integration alone brought workflows to thousands of developers already building in that ecosystem. Rather than forcing teams to migrate to a different framework just for durability, they could add it to their existing stack with a single line in their configuration file.

仅 SvelteKit 集成就已将工作流能力带给了数千名已在该生态中开展开发的工程师。团队无需仅为实现持久化而迁移到另一套框架——只需在配置文件中添加一行代码，即可将其无缝集成至现有技术栈。

Working with the community on integrations for Express, Hono, and Astro reinforced this. Developers wanted workflows in their preferred environment, not as a reason to switch environments.

我们与社区协作完成 Express、Hono 和 Astro 的集成，进一步印证了这一点：开发者希望在自己偏爱的环境中直接使用工作流，而不是为了使用工作流而被迫更换开发环境。

## The pattern holds

## 这一模式具有普适性

Since launch, the Workflow DevKit has gained over 1,300 GitHub stars, with developers building workflows across all these frameworks. Building six additional framework integrations demonstrated how good abstractions reveal patterns. What looks like six different problems is really one problem solved six different ways.

自发布以来，Workflow DevKit 已获得超过 1,300 颗 GitHub Star，开发者正基于所有这些框架构建工作流。新增六个框架集成的过程印证了一个道理：优秀的设计抽象能自然揭示共性模式——表面看似六个不同问题，实则只是同一个核心问题以六种不同方式被解决。

The core pattern remains the same across different frameworks. Generate workflow handlers at build-time. Register those handlers as HTTP endpoints at runtime. Only the implementation details change with a few framework-level specifics.

这一核心模式在各框架中保持一致：在构建时（build-time）生成工作流处理器（workflow handlers），在运行时（runtime）将这些处理器注册为 HTTP 端点。唯一变化的，是若干与框架自身特性相关的实现细节。

As we continue expanding framework support, that pattern still holds. And for developers, it means they can bring durable workflows to whatever framework they're already using.

随着我们持续扩展对更多框架的支持，这一模式依然成立。对开发者而言，这意味着他们可将持久化工作流能力直接引入自己正在使用的任意框架中。

Our goal with Workflow DevKit was to make durability a language-level concept across the ecosystem. With these integrations, we're a step closer.

Workflow DevKit 的目标，是让“持久化”成为整个生态中一种语言层面的原生能力。借助这些集成，我们已向这一目标迈出了坚实一步。

[**Start Building with Workflow DevKit**  
**立即使用 Workflow DevKit 开始构建**  

Use familiar JavaScript to build workflows that persist across deploys and crashes. No queues, schedulers, or extra infrastructure required.  
使用你熟悉的 JavaScript 构建工作流——它们能在部署更新与进程崩溃后依然持续运行。无需消息队列、调度器，也无需额外基础设施。  

Get Started](https://useworkflow.dev/)  
立即开始](https://useworkflow.dev/)