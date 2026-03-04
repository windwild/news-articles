---
title: "Iterate faster with Turborepo and Vercel Remote Cache - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-remote-cache-turbo"
date: "2023-02-07"
scraped_at: "2026-03-02T09:55:35.582316422+00:00"
language: "en-zh"
translated: true
description: "Vercel Remote Cache makes your Turborepo caching strategy multiplayer, allowing you to share caches with your teammates and CI."
---
{% raw %}

Feb 7, 2023

2023 年 2 月 7 日

We saved 7,347 hours in CI last week. Try out the tools we used in three minutes.

上周，我们在持续集成（CI）中节省了 7,347 小时。只需三分钟，即可试用我们所使用的工具。

Your software delivery is only as fast as the slowest part of your toolchain. As you and your teams work towards optimizing your deployment pipelines, it's important to make sure the speed of your continuous integration (CI) automations keep pace with your developers.

您的软件交付速度，仅与您工具链中最慢的一环相当。当您和团队致力于优化部署流水线时，确保持续集成（CI）自动化流程的速度能跟上开发者的节奏，至关重要。

Let’s take a look at how Turborepo and [Vercel Remote Cache](https://vercel.com/docs/concepts/monorepos/remote-caching#vercel-remote-cache) create a shared cache for everyone working on your projects.

让我们来看看 Turborepo 与 [Vercel 远程缓存（Vercel Remote Cache）](https://vercel.com/docs/concepts/monorepos/remote-caching#vercel-remote-cache) 如何为所有参与您项目开发的成员构建一个共享缓存。

## **What is Turborepo?**

## **什么是 Turborepo？**

Turborepo is a high-performance build system for JavaScript and TypeScript codebases that offers fast incremental builds, doesn't impact your runtime code, and intelligent caching that can reduce CI times by **up to 85%** for common pipelines.

Turborepo 是一款面向 JavaScript 和 TypeScript 代码库的高性能构建系统，支持快速的增量构建，不会影响运行时代码，并具备智能缓存能力——在常见流水线中，可将 CI 时间**最多缩短 85%**。

In a Turborepo, you can schedule your tasks to give you a clear workflow, even when the work you need to do has many layers of complexity. Common Turborepo tasks are building, linting, code generation, TypeScript type checking, and running a full development environment with a single command.

在 Turborepo 中，您可以对任务进行编排调度，从而获得清晰的工作流，即使您所需完成的工作本身具有多层复杂性。常见的 Turborepo 任务包括：构建（build）、代码检查（linting）、代码生成（code generation）、TypeScript 类型检查（type checking），以及通过单条命令启动完整的开发环境。

> “With Turborepo, we were able to give each workspace its own build, test, and typecheck scripts and not worry about manually managing when they execute. Turborepo’s remote caching has drastically sped up our CI runs when a code change only touches one or a few workspaces.”
>
> “借助 Turborepo，我们得以让每个工作区（workspace）拥有独立的构建、测试和类型检查脚本，而无需手动管理它们的执行时机。当一次代码变更仅影响一个或少数几个工作区时，Turborepo 的远程缓存显著加快了我们的 CI 运行速度。”
>
> ![](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_001.png)
>
> **Spike Brehm,** Software Engineer
>
> **斯派克·布雷姆（Spike Brehm）**，软件工程师

Once you’ve set your task [pipelines](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks#defining-a-pipeline?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_turbo_remote_cache), Turborepo will parallelize your tasks to run as early as possible, restoring previously cached tasks if they’re available for near-instant execution. In practice, this means that developers can iterate faster, cutting the time from commit to production at every step in your CI process.

一旦您配置好任务[流水线（pipelines）](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks#defining-a-pipeline?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_turbo_remote_cache)，Turborepo 将自动并行执行各项任务，并尽可能早地启动；若此前已缓存过对应任务，则直接复用缓存结果，实现近乎瞬时的执行。在实际开发中，这意味着开发者能够更快地完成迭代，在 CI 流程的每一步都大幅缩短从代码提交到上线投产的时间。

## **Try the Vercel Remote Cache in three minutes**

## **三分钟内体验 Vercel 远程缓存**

When you’re connected to Vercel Remote Cache, your caching becomes multiplayer. The local caching behavior you see on your workstation becomes shared, allowing your teammates and CI to share the same cache that you have on your local machine.

当您连接到 Vercel 远程缓存（Vercel Remote Cache）时，您的缓存便具备了“多人协作”能力。您在本地工作站上观察到的本地缓存行为将变为共享状态，使您的团队成员和持续集成（CI）系统能够与您本地机器上的缓存同步共享。

First, we’ll need a repository to work in so let’s use the Turborepo starter:

首先，我们需要一个代码仓库作为工作环境，因此我们使用 Turborepo 起始模板：

```bash
npx create-turbo@latest
```

```bash
npx create-turbo@latest
```

In your new project directory, run a second command:

在新建的项目目录中，运行以下第二个命令：

```bash
npx turbo login
```

```bash
npx turbo login
```

You will receive a prompt in your browser to authorize the Turborepo CLI with Vercel.

您的浏览器将弹出授权提示，允许 Turborepo 命令行工具（CLI）访问您的 Vercel 账户。

Last, run this command to link your project to your Vercel Remote Cache:

最后，运行以下命令，将您的项目关联至您的 Vercel 远程缓存：

```text
npx turbo link
```

```text
npx turbo link
```

You're now ready to roll. Instead of only caching tasks locally, you'll now be able to share cached tasks with your other laptops, teammates, and CI/CD systems that are also connected to the same Vercel Remote Cache.

现在，您已准备就绪！此后，您的任务缓存将不再局限于本地——您还可与自己的其他笔记本电脑、团队成员以及同样接入同一 Vercel 远程缓存的 CI/CD 系统共享已缓存的任务。

## **Deploying your Turborepo apps on Vercel**

## **在 Vercel 上部署您的 Turborepo 应用**

Let’s see the shared Vercel Remote Cache in action.

让我们看看共享的 Vercel 远程缓存（Remote Cache）如何实际运作。

First, run your build locally with `pnpm run build`. Both of your applications will build in parallel on your machine. If you run this command a second time, you'll hit a cache and your build will take a few milliseconds.

首先，使用 `pnpm run build` 在本地运行构建。你的两个应用将在本地机器上并行构建。如果你第二次运行该命令，将命中缓存，整个构建过程仅需几毫秒。

Because you connected to the Remote Cache earlier, Vercel is automatically aware of the build caches you've just created. Let's use this shared cache by deploying on Vercel.

由于你此前已连接到远程缓存，Vercel 会自动识别你刚刚创建的构建缓存。接下来，我们通过在 Vercel 上部署来利用这一共享缓存。

To create a deployment, push your repository to your Git provider and then visit [vercel.com/new](https://vercel.com/new). Vercel will automatically detect that your project is a monorepo and prompt you with a workflow to deploy the first app in your `/apps` directory (in our case, `docs`). The defaults for your framework, root directory, and build commands will also be set for you.

要创建一次部署，请先将代码仓库推送到你的 Git 托管平台，然后访问 [vercel.com/new](https://vercel.com/new)。Vercel 将自动识别你的项目为单体仓库（monorepo），并引导你完成部署流程——默认部署 `/apps` 目录下的第一个应用（本例中为 `docs`）。同时，框架类型、根目录及构建命令等配置也将自动为你预设。

![Settings to deploy a project from your Turborepo.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_002.jpg)![Settings to deploy a project from your Turborepo.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_003.jpg)设置：从你的 Turborepo 部署项目。

Click "Deploy" and your application will begin building. If you take a look at your build logs, you’ll notice some messages showing you that you’ve hit a cache for your build—the one from your local build that you shared to your Vercel Remote Cache.

点击“Deploy”（部署），你的应用即开始构建。查看构建日志时，你会看到若干提示信息，表明本次构建成功命中了缓存——即你此前本地构建并同步至 Vercel 远程缓存的结果。

![Turborepo restoring your project from the Vercel Remote Cache.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_004.jpg)![Turborepo restoring your project from the Vercel Remote Cache.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_005.jpg)![Turborepo restoring your project from the Vercel Remote Cache.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_006.jpg)![Turborepo restoring your project from the Vercel Remote Cache.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_007.jpg)Turborepo 正从 Vercel 远程缓存中恢复你的项目。

## **Visualize how much time you've saved**

## **直观呈现你节省的时间**

The first time you run a task with Turborepo, it will cache your task outputs, your logs, and **the amount of time it took for the task to complete**.

首次使用 Turborepo 运行某项任务时，它会缓存该任务的输出结果、日志，以及**任务完成所耗费的实际时间**。

The original execution time is an important piece of information that we can estimate how much time Turborepo is saving you. If we compare the full task run to a cache restoration, we know how much time you've saved.

原始执行耗时是一项关键指标，使我们得以估算 Turborepo 为你节省了多少时间。通过对比完整任务执行与缓存恢复所需时间，即可精确获知你节省的具体时长。

![One week of Vercel Remote Cache usage for our team at Vercel.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_008.jpg)  
![Vercel 远程缓存一周使用情况（Vercel 团队内部数据）](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_008.jpg)  

![One week of Vercel Remote Cache usage for our team at Vercel.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_009.jpg)  
![Vercel 远程缓存一周使用情况（Vercel 团队内部数据）](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_009.jpg)  

![One week of Vercel Remote Cache usage for our team at Vercel.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_010.jpg)  
![Vercel 远程缓存一周使用情况（Vercel 团队内部数据）](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_010.jpg)  

![One week of Vercel Remote Cache usage for our team at Vercel.](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_011.jpg)  
![Vercel 远程缓存一周使用情况（Vercel 团队内部数据）](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_011.jpg)  

One week of Vercel Remote Cache usage for our team at Vercel.  

Vercel 团队内部一周的 Vercel 远程缓存使用情况。

On Vercel, you can see how much time you’ve been saving in the "Artifacts" section of your Usage dashboard tab. Most cache hits see their outputs restored in a measurement of milliseconds, effectively saving you the entire duration of the original task run.  

在 Vercel 平台上，您可在用量仪表盘（Usage dashboard）的“构建产物（Artifacts）”标签页中直观查看已节省的时间。绝大多数缓存命中（cache hit）可在毫秒级内完成输出恢复，相当于完全省去了原始任务执行所需的全部耗时。

## **Welcome to the Turboverse**  

## **欢迎来到 Turboverse**

Building with Turborepo on Vercel has brought a zero-configuration distributed caching solution to your project in under five minutes. You can also:  

在 Vercel 上基于 Turborepo 构建项目，仅需不到五分钟，即可为您的项目接入零配置的分布式缓存方案。此外，您还可以：

- Easily incorporate [other CI providers](https://turbo.build/repo/docs/ci?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_turbo_remote_cache) in this process to create a robust CI/CD pipeline to meet all of your deployment needs  

  轻松集成 [其他 CI 工具提供商](https://turbo.build/repo/docs/ci?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_turbo_remote_cache)，构建一套健壮的 CI/CD 流水线，全面满足您的部署需求；

- Cache Nx and Rush remotely using [the Vercel Remote Cache SDK](https://github.com/vercel/remote-cache)  

  使用 [Vercel 远程缓存 SDK](https://github.com/vercel/remote-cache) 实现 Nx 和 Rush 的远程缓存。

Leveraging your Vercel Remote Cache, you will always be up-to-date with the latest version of Turborepo and you’ll never have to manage a distributed caching solution.  

借助您的 Vercel 远程缓存，您将始终使用最新版 Turborepo，且无需自行运维任何分布式缓存系统。

You can try out Vercel Remote Cache on your Hobby account for free and, if you'd like to get started with your team, [here's a free Pro trial](https://vercel.com/signup?next=/dashboard?createTeam=true) to see how fast your CI can go.  

您可免费在 Hobby 计划账户中试用 Vercel 远程缓存；若您希望为团队开启协作，[点击此处获取免费 Pro 试用](https://vercel.com/signup?next=/dashboard?createTeam=true)，亲身体验您的 CI 流水线能有多快。

Vercel Template  

Vercel 模板  

Deploy this template  

部署此模板

### This is an official starter Turborepo with two Next.js sites and three local packages

### 这是一个官方的 Turborepo 入门模板，包含两个 Next.js 站点和三个本地包

Turborepo & Next.js Starter

Turborepo 与 Next.js 入门模板

Blog post

博客文章

Jan 24, 2023

2023 年 1 月 24 日

### How Supabase elevated their developer experience with Turborepo

### Supabase 如何借助 Turborepo 提升开发者体验

![](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_012.png)![](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_013.jpg)

![](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_012.png)![](images/iterate-faster-with-turborepo-and-vercel-remote-cache-vercel/img_013.jpg)

Alli and Anthony

Alli 与 Anthony
{% endraw %}
