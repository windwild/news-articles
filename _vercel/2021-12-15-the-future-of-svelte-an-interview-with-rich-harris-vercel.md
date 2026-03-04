---
title: "The future of Svelte, an interview with Rich Harris - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-future-of-svelte-an-interview-with-rich-harris"
date: "2021-12-15"
scraped_at: "2026-03-02T10:03:53.474548919+00:00"
language: "en-zh"
translated: true
description: "In this 45-minute interview, hear Rich Harris (the creator of Svelte) talk about its plans for the future. Other topics include funding open-source, SvelteKit 1.0, the Edge-first future, and more."
---
&#123;% raw %}

Dec 15, 2021

2021年12月15日

Svelte 被票选为 [最受喜爱的 Web 框架](https://insights.stackoverflow.com/survey/2021#section-most-loved-dreaded-and-wanted-web-frameworks)，同时也是 [开发者满意度最高的框架](https://2020.stateofjs.com/en-US/technologies/front-end-frameworks/)。

在本次时长 45 分钟的访谈中，[Lee Robinson](https://twitter.com/leeerob) 与 Svelte 的创始人 [Rich Harris](https://vercel.com/blog/vercel-welcomes-rich-harris-creator-of-svelte) 展开对话，探讨他对该框架未来发展的规划。其他话题还包括开源项目的资金支持、SvelteKit 1.0、以边缘计算（Edge）为先的未来发展方向等。

一场 Lee Robinson 与 Rich Harris 关于 Svelte 的深度访谈。

## 对话精华摘要

## 对话亮点

### **请谈谈您第一个广受欢迎的项目。从纯粹出于兴趣构建一个项目，到突然发现大量用户在使用它——这种转变对您开发开源项目的方式产生了怎样的影响？**

### **请介绍一下您首个广为人知的项目。当初纯粹出于兴趣开发一个项目，到后来突然看到大量用户开始使用它——这种转变如何改变了您参与开源开发的方式？**

**Rich:** “受欢迎”这个词当然具有相对性。我最早投入大量精力的大型项目，其实是 Svelte 的前身——一个名为 Ractive 的框架。我于 2013 年发布了它的第一个版本，发布时间几乎与 React 同步。我还记得当时正紧锣密鼓地准备公开发布，结果在我们上线前一个月，React 的公告就登上了 Hacker News。我当时心想：“唉，现在做这个还有什么意义？真是白费功夫。”

但最终我还是发布了 Ractive，而且反响相当不错。彼时 React 尚未成为人人必学的“标配”，整个市场格局也尚未定型。很长一段时间里，我都怀揣着这样一个幻想：Ractive 有潜力成为 React 的有力竞争者。我真心热爱这个项目——它是我首个大型开源实践，我倾注了全部心血与热忱，最终也确实收获了一批忠实用户。

如果你并非开源项目维护者，可能很难意识到：一个项目哪怕规模不大，其社区活跃度也可能迅速超出单个维护者所能承受的极限。我当时几乎把所有夜晚和周末都投入其中；用户数量持续增长，甚至已有公司开始采用它。这种高强度投入渐渐变得难以为继，最终让我彻底身心俱疲、精疲力竭。我想，这便是我初次直面开源维护者真实处境的时刻。

正是这段经历教会了我如何与用户共处，也教会了我如何应对一系列关键问题：例如，如何吸引贡献者加入？如何引导他们与核心团队保持一致的方向、协同推进项目？又该如何得体而坚定地拒绝不合适的功能请求？可以说，Ractive 是我深入开源世界内核的一场“烈火洗礼”，也为数年后 Svelte 的诞生奠定了坚实基础。

### With Svelte, you're leading an amazing project and community. Why join Vercel, and what does that mean for the future of Svelte?

### 采用 Svelte，您正引领一个卓越的项目与社区。为何加入 Vercel？这对 Svelte 的未来意味着什么？

**Rich:** I think it's a really good outcome. It's not something that I would necessarily have anticipated. If you'd asked me a year ago if this was going to happen, I would've been very surprised at this outcome. But I thought long and hard about what it's going to mean for the project and I think it's an incredibly positive development.

**Rich：** 我认为这是一个非常理想的结果，甚至并非我此前必然能预料到的。如果一年前有人问我这件事是否会发生，我一定会对此结果感到十分惊讶。但我经过长时间、深入的思考，认真评估了它对 Svelte 项目意味着什么——我认为这是一项极其积极的发展。

It means, for example, there's a lot of people who would like to use Svelte for their own products, and they haven't been able to because there's the whole bus factor thing. They're worried a project without any real financial backing is just going to disappear. Some of those people are now starting to turn around and say, _Well okay, it has a full-time engineer. Vercel is clearly excited about Svelte and is investing real resources into Svelte._

这意味着，例如，许多公司本希望将 Svelte 应用于自己的产品中，却因“巴士因子”（bus factor）问题而迟迟未能推进——他们担心一个缺乏真正资金支持的开源项目随时可能消失。如今，其中一部分人开始转变态度，说：“好吧，现在 Svelte 拥有了一名全职工程师；Vercel 显然对 Svelte 充满热情，并正在投入实实在在的资源。”

Companies feel they're able to use Svelte. In many cases, their engineers already wanted to use Svelte, and now they're able to do that. It means people can start working on Svelte knowing they're likely to be able to get hired as a Svelte developer. Because of all of those things, the community is likely to grow. We're going to get a better idea of what the community needs. We're going to get more people contributing to other parts of the ecosystem, component libraries, all of that stuff. It feels like the beginning of this very virtuous cycle. Svelte was already growing very quickly, but I think this is going to accelerate things quite considerably.

企业如今更有信心采用 Svelte。在很多情况下，其工程师原本就希望使用 Svelte，而现在他们终于可以付诸实践了。这也意味着，开发者可以放心地投身 Svelte 开发——因为他们很可能因此获得 Svelte 开发者岗位的工作机会。正因上述种种因素，Svelte 社区有望持续壮大；我们将更清晰地了解社区的真实需求；也将吸引更多人参与生态系统的其他环节建设，例如组件库等。这仿佛标志着一个良性循环的开端。Svelte 本身已处于高速增长阶段，而此次合作必将显著加速这一进程。

### How would you sell the vision of Svelte or SvelteKit to a CTO or senior leadership?

### 您将如何向首席技术官（CTO）或高层管理者阐述 Svelte 或 SvelteKit 的愿景？

**Rich:** It kind of doesn't matter what you're building. Your competitive advantage is essentially limited by how fast you can ship stuff, and SvelteKit will let you ship stuff faster. That is what it boils down to.

**Rich：** 无论您构建的是何种应用，企业的竞争优势本质上都受限于您交付产品的速度——而 SvelteKit 正是帮助您更快交付的利器。归根结底，就是这么简单。

I believe moving from React to Svelte will allow you to write stuff faster. We have a whole thesis about how Svelte is a UI language that is designed explicitly for solving this problem and it allows you to write things in a more idiomatic way. But even leaving that aside, if you move from rolling your own application structure around a component framework, you're going to be doing a hell of a lot of work and you're going to have all of these undocumented bits and pieces. It's one of these things that's going to succumb to a bit of rot over time.

我相信，从 React 迁移到 Svelte 将使您编写代码的速度大幅提升。我们有一整套理论支撑：Svelte 是一门专为解决“快速交付”这一核心问题而设计的 UI 语言，它能让您以更符合直觉、更符合惯例（idiomatic）的方式编写代码。但即便抛开这一点不谈，如果您此前一直围绕某个组件框架（如 React）自行搭建应用架构，那么您实际上承担了大量重复性工作，还不得不维护一堆缺乏文档、难以追溯的零散模块——这类自建架构往往随着时间推移而逐渐腐化（rot）。

If you, instead of starting at the component-framework level, start at the application- framework level—be that [Next.js](https://vercel.com/solutions/nextjs) or [Nuxt](https://nuxtjs.org/) or [SvelteKit](https://vercel.com/changelog/sveltekit-projects-can-now-be-deployed-with-zero-configuration)—then immediately you've taken a huge chunk of maintenance off your plate. You can start building stuff much, much quicker with one of those frameworks.

反之，若您不再从组件框架层面起步，而是直接选用应用级框架——无论是 [Next.js](https://vercel.com/solutions/nextjs)、[Nuxt](https://nuxtjs.org/)，还是 [SvelteKit](https://vercel.com/changelog/sveltekit-projects-can-now-be-deployed-with-zero-configuration)，您便能立即将大量运维负担从肩上卸下。借助这些框架，您将能以前所未有的速度启动并推进开发工作。

### SvelteKit is a framework that's edge-first. It's trying to optimize for running code as close to your customers as possible. How does that play into the design of the framework and some of the decisions that you make for what you include or what you don't include?

### SvelteKit 是一款“边缘优先”（edge-first）的框架，致力于让代码尽可能靠近您的用户运行。这一理念如何影响框架的设计，以及您在功能取舍（即纳入或排除哪些特性）时的决策？

**Rich:** From day one, we thought, _How can we build this framework in such a way that it's going to work on any of the platforms that exist today but also future platforms that don't exist yet?_

**Rich：** 自项目启动第一天起，我们就一直在思考：“我们该如何构建这个框架，使其不仅能在当今所有主流平台上顺畅运行，更能无缝适配那些尚未诞生的未来平台？”

We support version one of the [Vercel File System API](https://vercel.com/docs/file-system-api).  

我们支持 [Vercel 文件系统 API](https://vercel.com/docs/file-system-api) 的第一版。

Version two is going to allow us to take those individual functions we're generating for the different parts of the app and map them to [functions that run at the edge](https://vercel.com/features/edge-functions).  

第二版将使我们能够将为应用各部分生成的这些独立函数，映射到 [在边缘运行的函数](https://vercel.com/features/edge-functions)。

That's going to mean if you're building an app with SvelteKit, even if it gets absolutely huge, then a user in some remote part of the world is going to hit an edge server very close to them.  

这意味着，如果你正在使用 SvelteKit 构建应用——哪怕应用规模变得极其庞大——位于世界某个偏远地区的用户，也将能访问到离他们地理位置非常近的边缘服务器。

It's going to run just the code necessary to handle that specific request and then it's going to come back to them.  

该服务器仅执行处理该特定请求所必需的代码，随后便将响应返回给用户。

In many cases, the page will be pre-rendered anyway, because that's a very easy thing to configure in SvelteKit, and this is where we think that all of this stuff is going.  

在许多情况下，页面本身早已完成预渲染，因为这在 SvelteKit 中配置起来非常简单；而这正是我们认为整个技术演进的方向所在。

You build your app in one very easy to develop way. You have this cohesive codebase that isn't tied to any one platform.  

你以一种极为便捷的方式开发你的应用；你拥有一个高度统一、且不与任何单一平台绑定的代码库。

Then, depending on how capable the platform is, it will optimize the experience for users based on the platform's capabilities.  

然后，平台将根据其自身能力，动态优化终端用户的使用体验。

And in the case of Vercel where we have this global CDN and we have this global [Edge Network,](https://vercel.com/features/infrastructure) we can really push that user experience pretty far.  

以 Vercel 为例：凭借其全球内容分发网络（CDN）以及全球化的 [边缘网络（Edge Network）](https://vercel.com/features/infrastructure)，我们确实能将用户体验提升至全新高度。

**Watch the full interview to see why developers love Svelte and try** [**Svelte on Vercel**](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fsveltekit&template=sveltekit&id=67753070&b=main&from=templates) **today.**

**观看完整访谈，了解开发者为何钟爱 Svelte，并立即尝试** [**Vercel 上的 Svelte**](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fsveltekit&template=sveltekit&id=67753070&b=main&from=templates) **。**
&#123;% endraw %}
