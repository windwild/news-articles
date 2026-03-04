---
title: "Iterating from design to deploy: Guillermo Rauch's talk at Figma Config 2023 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/iterating-from-design-to-deploy"
date: "2023-07-13"
scraped_at: "2026-03-02T09:51:46.831594158+00:00"
language: "en-zh"
translated: true
description: "A reflection on Guillermo Roach's Config 2023 talk, \"The shape of future builders: from design to deploy.\""
---
{% raw %}

Jul 13, 2023

2023 年 7 月 13 日

Guillermo Rauch's talk at Figma Config 2023.

Guillermo Rauch 在 Figma Config 2023 大会上的演讲。

In a world of accelerating digital innovation, we need tools that transform the web development landscape. In his recent [Figma Config keynote](https://config.figma.com/video-on-demand/6329925612112), Guillermo Rauch spoke about how we at Vercel enable builders—non-developers included—to tighten the cycle of design and deploy.

在数字创新加速发展的时代，我们需要能够重塑 Web 开发格局的工具。在近期的 [Figma Config 主题演讲](https://config.figma.com/video-on-demand/6329925612112) 中，Guillermo Rauch 阐述了 Vercel 如何赋能各类构建者——包括非开发者——进一步缩短“设计→部署”的闭环周期。

Below, we’ll dive behind the scenes of the talk and give you tangible ways to try out Vercel’s Frontend Cloud.

下文，我们将深入本次演讲幕后，并为您提供切实可行的方式，亲身体验 Vercel 的前端云（Frontend Cloud）。

The Shape of Future Builders: From Design to Deploy. (Config 2023)

未来构建者的形态：从设计到部署。（Config 2023）

## **Why develop on the web?**

## **为何选择在 Web 上开发？**

Vercel enables you to deploy to the web because we believe it’s the past, present, and future of applications.

Vercel 支持您将应用部署至 Web，因为我们坚信：Web 是应用程序的过去、现在与未来。

The web isn't just an information hub; it's a dynamic and inclusive platform for creators to build, deploy, and interact with a range of applications and services. Here's why it's compelling to develop on:

Web 不仅是一个信息枢纽；它更是一个动态、包容的平台，让创作者得以构建、部署并交互使用各类应用程序与服务。以下是 Web 开发令人信服的几大理由：

- **Open-source**: Unlike proprietary ecosystems, the web's open-source nature provides developers with unmatched freedom and flexibility. They can collaborate, innovate, and contribute without constraints, which makes the Web evolve faster than any other platform.

- **开源**：与封闭的专有生态不同，Web 的开源特性为开发者提供了无与伦比的自由度与灵活性。开发者可不受限制地协作、创新与贡献，这也使得 Web 的演进速度远超任何其他平台。

- **Universality**: The web is available across various devices like desktops, mobiles, TVs, and wearables. It offers a single source of truth for designs, ensuring cross-platform compatibility. It’s global, transcending geographic, economic, and technological barriers.

- **普适性**：Web 可在各类设备上运行，包括桌面端、移动端、电视端及可穿戴设备。它为设计提供统一的“单一事实来源”（single source of truth），确保跨平台兼容性。Web 具有全球属性，跨越地理、经济与技术壁垒。

- **Interactivity**: The web is shifting from static websites to dynamic applications. For instance, a single hyperlink can lead to a complete web-building experience, allowing users to transition from being passive consumers to active creators.

- **交互性**：互联网正从静态网站转向动态应用。例如，一个简单的超链接即可开启完整的网页构建体验，使用户从被动的内容消费者转变为积极的内容创造者。

- **Inclusivity**: Above its technical merits, the web's true strength lies in its capacity to empower individuals. By welcoming everyone to participate, it encourages a more inclusive and innovative technological future.

- **包容性**：除技术优势之外，互联网真正的力量在于赋能个体。通过向所有人开放参与机会，它推动构建一个更具包容性与创新性的技术未来。

The biggest problem with the web, then, is the obstacles in place for non-engineers between design and deploy. Without code, non-engineers are severely limited in the types of applications they can create.

因此，当前互联网面临的最大问题，是设计师等非工程师群体在“设计”与“部署”之间所遭遇的重重障碍。若不编写代码，非工程师所能创建的应用类型将受到极大限制。

## Design first, engineering second

## 设计先行，工程随后

Building on the web may be the best place to build, but it’s always required a whole lot of engineering.

在互联网上构建应用或许是最佳选择，但长期以来，这始终意味着需要投入大量工程工作。

However, the complex nature of development is changing. The solid engineering foundation we’ve been building for the past few decades—think backend cloud tech like AWS or Kubernetes—has come to a maturity that enables us to work design first, engineering second.

然而，开发工作的复杂性正在发生转变。过去几十年来我们持续夯实的工程基础——例如 AWS 或 Kubernetes 等后端云技术——已日趋成熟，使我们得以真正实现“设计先行、工程随后”的工作模式。

The lines between designers and engineers are blurring. Your whole team should be able to collaborate in real-time.

设计师与工程师之间的界限正日益模糊。你的整个团队都应能够实时协作。

A key player in this paradigm shift has been React. By turning abstract JavaScript functions into tangible, reusable components, React opened the door to a frontend-first approach. This allows teams to create dynamic, user-centric interfaces, while more or less slotting in backend solutions.

这场范式变革中的关键推动者之一是 React。它将抽象的 JavaScript 函数转化为具体、可复用的组件，从而开启了“前端优先”的开发路径。这使得团队能够构建动态、以用户为中心的界面，而后端解决方案则可相对灵活地集成其中。

Today, the best online experiences are those that use team-designed components to offer user-facing personalization that allows for deep connection. Think endless scrolling on Twitter, swiping on TikTok, or Instagram’s minimalism. All prioritize the frontend experience.

如今，最出色的在线体验，无不依托于团队共同设计的组件，提供面向用户的个性化功能，从而建立深层次的情感联结。例如 Twitter 的无限滚动、TikTok 的左右滑动，以及 Instagram 的极简主义风格——它们无一例外，都将前端体验置于核心地位。

To keep up with modern user expectations, design must remain the top priority, and it must evolve rapidly. The shift from engineering to design is not just a trend; it’s a journey towards a more engaging, personal, and ultimately, human digital experience.

为满足当代用户不断演进的期待，设计必须始终居于首位，并且必须快速迭代进化。“从工程主导转向设计主导”绝非一时潮流；它是一场通往更具吸引力、更富个性、也最终更富人性化的数字体验的深刻旅程。

## **Making the web faster**

## **让网络更快**

Better designs may make for better experiences, but connecting with a slow application is a difficult proposition. In today’s attention economy, engagement is everything and speed holds engagement.

优秀的设计或许能带来更佳的用户体验，但若应用响应迟缓，用户连接意愿便会大打折扣。在当今注意力即经济的时代，用户参与度至关重要，而速度正是维系参与度的关键。

Top-ranking apps’ load time is measured in milliseconds.

头部应用的加载时间以毫秒计。

![As cited in a recent study by Deloitte, an improvement in load time of just 100ms can result in an 8% increase in your app’s customer conversion.](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_001.jpg)如德勤（Deloitte）近期一项研究所指出：应用加载时间仅缩短 100 毫秒，即可提升客户转化率高达 8%。

Add to this that search engines want to show fast, low bounce rate sites as their top results, and you find that milliseconds make millions.

再者，搜索引擎倾向于将加载迅速、跳出率低的网站置顶展示——这意味着，毫秒之差，往往关乎百万营收。

### **The Frontend Cloud**

### **前端云**

Making a high-performing, well-designed site requires more than just an assortment of individual open-source tools; it demands an integrated ecosystem.

打造高性能、设计精良的网站，远不止堆砌各类开源工具；它需要一个深度集成的生态系统。

This is the primary goal of Vercel’s Frontend Cloud: to facilitate a unified, seamless user **and** developer experience. It allows numerous solutions—CMS, database, shop, auth, you name it—to smoothly integrate with popular frameworks such as Next.js and SvelteKit.

这正是 Vercel 前端云（Frontend Cloud）的核心使命：为终端用户与开发者同时提供统一、流畅的体验。它支持 CMS、数据库、电商系统、身份认证等各类解决方案——无论您选择哪一种——均可无缝对接 Next.js、SvelteKit 等主流全栈框架。

![Bring your favorite framework and full-stack tools. We'll wire it all together with our Frontend Cloud.](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_002.jpg)带上您钟爱的框架与全栈工具，我们将借助前端云将其全部有机整合。

However, unlike a “walled garden” approach, Vercel’s frontend cloud guarantees cohesion while bringing together top-tier closed- and open-source tools from every sector of web design, allowing for true interchangeability of tools.

然而，Vercel 的前端云并非采用封闭式“围墙花园”（walled garden）模式；它在确保系统整体协同性的同时，汇聚了网页设计各领域顶尖的闭源与开源工具，真正实现工具间的自由替换与灵活组合。

You can focus on creating your frontend, adding other pre-built solutions only as needed. You get to pick the solutions that best align with your unique vision, without compromising on design.

您可以专注于前端开发，仅在需要时添加其他预构建的解决方案。您可以自由选择最契合自身独特愿景的方案，而无需在设计上做出妥协。

### Framework-defined infrastructure

### 框架定义的基础设施

Frameworks are good at reducing the organizational load on your team’s developers. Using Next.js, SvelteKit, or Vue frees team members up to focus on designing powerful UX. However, frameworks lose value if they don’t work out-of-the-box with your eventual deployment environment.

框架擅长减轻团队开发者在组织层面的负担。使用 Next.js、SvelteKit 或 Vue，可让团队成员专注于打造强大的用户体验（UX）。然而，若框架无法与您最终的部署环境开箱即用，则其价值将大打折扣。

Vercel takes the view that deployment infrastructure itself should be framework-defined, meaning that you never have custom brew solutions on cloud architecture.

Vercel 认为，部署基础设施本身也应由框架来定义——这意味着您无需在云架构中自行构建定制化方案。

![Devs shouldn't have to manage intricate architecture; follow your favorite framework and the rest is up to us.](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_003.jpg)  
开发者不应被迫管理错综复杂的架构；只需沿用您钟爱的框架，其余一切交由我们处理。

Your framework code—everything that framework is capable of—just _works_ when deployed to Vercel. That’s what we mean when we say we’re the native Next.js solution (in addition to being its creator and maintainer).

您基于框架编写的全部代码——即该框架所能支持的所有功能——部署至 Vercel 后均可直接运行。这正是我们自称“原生 Next.js 解决方案”的含义所在（同时我们也是 Next.js 的创建者与维护者）。

We leverage all those years of infrastructure engineering to provide the best solutions behind the scenes: CDNs, serverless tech, dynamic data on the Edge, and the list goes on. Developers shouldn’t have to reinvent the wheel every time they want to roll out a new product.

我们凭借多年积累的基础设施工程经验，在后台提供业界领先的解决方案：内容分发网络（CDN）、无服务器技术（serverless）、边缘动态数据（dynamic data on the Edge），等等不一而足。开发者无需每次发布新产品时都重新造轮子。

## Making the web, faster

## 让 Web 更快

The key to a more interactive and personal web lies in the ability to iterate rapidly. The faster your team can fail and learn from failure, the faster you can have a truly great product.

构建更具交互性与个性化的 Web 的关键，在于快速迭代的能力。您的团队越能快速试错并从失败中学习，就越能更快打造出真正卓越的产品。

![Vercel makes testing of your app in a real-world environment easily available to anyone you choose, meaning your team can make the product better, faster.](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_004.jpg)  
Vercel 让您可轻松地将应用置于真实世界环境中进行测试，并可自由指定参与测试的人员，从而助力团队更快地优化产品。

As discussed above, Vercel enables quick cycles through our Frontend Cloud’s native integrations and framework-defined infra. However, with Vercel’s seamless [Git integration](https://vercel.com/docs/concepts/deployments/git), all team members can interact with _every_ change in a live preview. (Put in developer-speak, every Git commit across every branch of your repo leads to a unique Vercel deployment that can be interacted with in a true-to-prod environment.)

如上所述，Vercel 依托我们前端云（Frontend Cloud）的原生集成与框架定义的基础设施（framework-defined infra），实现了快速迭代循环。然而，借助 Vercel 无缝的 [Git 集成](https://vercel.com/docs/concepts/deployments/git)，所有团队成员均可在实时预览环境中与 _每一次_ 更改进行交互。（用开发者语言来说：您的代码仓库中任意分支上的每一次 Git 提交，都会生成一个独一无二的 Vercel 预览部署，且该部署运行于高度贴近生产环境（true-to-prod）的真实环境中。）

Truly, we're finished with the age of, "Well, it worked on _my_ machine."

真正地，我们已告别了“嗯，它在我机器上是能跑通的”这一时代。

### **Side-by-side collaboration**

### **并行协作**

Those true-to-life previews don’t stay read-only, though. Taking inspiration from collaborative tools like Figma, Notion, and Google Docs, Vercel has made iterating a whole-team activity.

不过，这些高度还原真实场景的预览并非只读状态。Vercel 借鉴了 Figma、Notion 和 Google Docs 等协作工具的设计理念，将迭代过程转变为整个团队共同参与的活动。

Within your Preview Deployments, Vercel offers real-time commenting, issue tracking, and visual editing—all while staying true to production performance.

在您的预览部署（Preview Deployments）中，Vercel 提供实时评论、问题追踪（issue tracking）与可视化编辑（visual editing）功能——同时始终保障与生产环境一致的性能表现。

- **Deployment URLs** \- Links to specific Preview Deployments can be easily shared with any project stakeholders, on-team or off. Everyone works from the same source of truth and can test across even the toughest environments—like that pesky web browser that pops up within Twitter.

- **部署 URL（Deployment URLs）**：指向特定预览部署的链接可轻松分享给项目内外所有相关方（on-team 或 off-team）。所有人基于同一真实可信的信息源开展工作，并可在各类严苛环境中完成测试——例如 Twitter 内嵌的那个令人头疼的网页浏览器。

- **Comments** \- Preview deployments include Figma-like [comments](https://vercel.com/docs/workflow-collaboration/comments) that, thanks to framework-defined infra, stick to the actual DOM elements of the webpage. This means you can stick comments anywhere that everyone else can see in real time.

- **评论（Comments）**：预览部署内置类似 Figma 的 [评论功能](https://vercel.com/docs/workflow-collaboration/comments)，依托框架定义的基础设施，这些评论可精准锚定至网页真实的 DOM 元素上。这意味着您可在任意位置添加评论，所有协作者均能实时查看。

- **Issue Tracking** \- Comments alone can be hard to track, so we’ve made sure they integrate directly with [Linear](https://linear.app/), which in turn can be integrated into many other of your team’s favorite tools.

- **问题追踪（Issue Tracking）**：仅靠评论本身可能难以高效跟踪任务进展，因此我们确保其原生集成 [Linear](https://linear.app/) ——而 Linear 本身又可进一步对接您团队钟爱的众多其他工具。

- **Visual Editing** \- When enabled, [Visual Editing](https://vercel.com/docs/workflow-collaboration/draft-mode) allows you to see where every dynamic component comes from in your CMS. On large products, it’s easy to spend ten minutes finding where to edit content, but now you can click right into where the edits need to happen.

- **可视化编辑（Visual Editing）**：启用后，[可视化编辑](https://vercel.com/docs/workflow-collaboration/draft-mode) 功能可清晰展示每个动态组件在内容管理系统（CMS）中的来源。在大型产品中，过去常需耗费十分钟才能定位到待编辑的内容位置；如今，您只需单击即可直达需要修改之处。

- **Build Blocking** \- Thanks to Vercel’s CI/CD automation, preview comments from any team member can _block_ new deployments from being made, much like developers have always been able to ask each other for changes to be made before a feature is merged.

- **构建阻断（Build Blocking）**：依托 Vercel 的 CI/CD 自动化能力，任何团队成员在预览部署中留下的评论均可 _阻断_ 新部署的发布流程——这与开发者长期以来在功能合并前相互提出修改要求的做法完全一致。

Blurring these traditional lines between design and engineering means that all team members can work side-by-side to bring highly creative products to life, working together in real time to optimize productivity.

模糊设计与工程之间这些传统界限，意味着所有团队成员都能并肩协作，将极具创意的产品变为现实，并通过实时协同大幅提升生产力。

### A note on AI

### 关于 AI 的说明

The tightly integrated approach talked about throughout this article also opens the door to directly integrating AI in design. We’re actively building AI solutions across our product, including the ability to adjust your apps on the fly from the Preview Deployments themselves.

本文通篇所探讨的高度集成化方法，也为在设计流程中直接集成 AI 打开了大门。我们正积极在整个产品中构建 AI 解决方案，包括支持您直接从预览部署（Preview Deployments）中即时调整应用功能。

Stay tuned for more developments.

敬请关注后续进展。

![In the near future, Vercel plans to make AI available to speed up simple code tasks directly from Preview Deployments.](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_005.jpg)  
![不久的将来，Vercel 计划在预览部署（Preview Deployments）中直接提供 AI 功能，以加速简单的代码任务。](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_005.jpg)  
In the near future, Vercel plans to make AI available to speed up simple code tasks directly from Preview Deployments.

不久的将来，Vercel 计划在预览部署（Preview Deployments）中直接提供 AI 功能，以加速简单的代码任务。

## **The future is you, empowered**

## **未来属于被赋能的你**

We’re entering a new era: one where creativity, efficiency, and technology unite to forge remarkable digital experiences.

我们正迈入一个崭新时代：在这个时代，创造力、效率与技术深度融合，共同塑造非凡的数字体验。

In this new world of real-time collaboration, everyone on your team has the power to contribute, innovate, and effect change.

在这个实时协作的新世界中，您团队中的每一位成员都拥有贡献想法、推动创新并促成变革的力量。

[**Start building securely**\\  
\\  
Our experts can help you navigate Vercel for your team's unique needs.\\  
\\  
Contact Us](https://vercel.com/contact/sales)  
[**立即安全地开始构建**\\  
\\  
我们的专家可协助您根据团队的独特需求，高效使用 Vercel。\\  
\\  
联系我们](https://vercel.com/contact/sales)

Vercel.com landing page  
Vercel.com 首页

### Learn more

### 了解更多

Vercel.com landing page

Vercel.com 官网落地页

### Turn your frontend into a profit center

### 将您的前端转变为盈利中心

![](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_006.svg)

![](images/iterating-from-design-to-deploy-guillermo-rauch_s-talk-at-figma-config-2023-verc/img_006.svg)

Download the whitepaper

下载白皮书
{% endraw %}
