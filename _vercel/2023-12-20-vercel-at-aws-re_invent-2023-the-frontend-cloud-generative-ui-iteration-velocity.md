---
title: "Vercel at AWS re:Invent 2023: The Frontend Cloud, Generative UI, iteration velocity - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/aws-reinvent-2023-iteration-velocity"
date: "2023-12-20"
scraped_at: "2026-03-02T09:48:54.642380152+00:00"
language: "en-zh"
translated: true
description: "Vercel at AWS re:Invent 2023: The Frontend Cloud, Generative UI, iteration velocity with Malte Ubl"
---
&#123;% raw %}

Dec 20, 2023

Dec 20, 2023

The Frontend Cloud, Generative UI, and keys to a high iteration team

前端云、生成式用户界面，以及打造高迭代效率团队的关键要素

Recently the Vercel Team had the pleasure of sponsoring AWS re:Invent 2023. This year we attended as an official part of the AWS Marketplace, which makes it possible to onboard and build on Vercel in just a few clicks.

近期，Vercel 团队有幸成为 AWS re:Invent 2023 的赞助方。今年，我们以 AWS Marketplace 官方合作伙伴身份参会，这使得用户仅需数次点击，即可完成 Vercel 的接入与开发。

While at re:Invent, I was able to share my thoughts on The Frontend Cloud, Generative UI, and the keys to a highly iterative team. Here’s a look at my talk.

在 re:Invent 期间，我分享了关于“前端云”（The Frontend Cloud）、“生成式用户界面”（Generative UI），以及打造高迭代效率团队的关键要素的思考。以下是我的演讲概览。

## The shift to the frontend—the final frontier of differentiation

## 前端化转型——差异化竞争的最后前沿

The current state of web development requires a focus on the frontend—because the frontend is where you differentiate from your competition. It’s where you meet your customers, users, and partners, and become the leader in your market.

当前 Web 开发的发展态势要求我们聚焦于前端——因为前端正是你与竞争对手实现差异化的关键所在。它既是用户、客户与合作伙伴与你相遇的第一触点，也是你确立市场领导地位的核心阵地。

## Composable architecture for better speed, UX, and AI adoption

## 可组合式架构：加速交付、优化用户体验与推动 AI 落地

But many teams are stuck with a monolithic system, bogged down by configuration and left with less room for innovation. These stacks are:

但许多团队仍困于单体系统之中：配置繁重、流程僵化，创新空间被严重压缩。这类技术栈具有如下特征：

- Inflexible  
- 灵活性差  

- Expensive  
- 成本高昂

- Difficult to scale  
- 难以扩展

This is especially true in the age of AI, which is changing the tech landscape and necessitating that businesses remain nimble.  
这在人工智能时代尤为明显——AI 正在重塑技术格局，要求企业必须保持敏捷灵活。

Imagine your website is built on a legacy stack, and you want to add an AI chatbot. **In a managed monolith, you're beholden to that vendor's roadmap.** AI capabilities must be added to the entire app before anyone can use it—in other words, frontend devs are left waiting for your vendor to make changes. Meanwhile, in composable patterns, frontend devs can directly integrate AI services and get going whenever they need.  
试想，你的网站基于一套传统技术栈构建，而你希望为其添加一个 AI 聊天机器人。**在受管单体架构中，你完全受限于该供应商的路线图。** AI 功能必须先集成到整个应用中，用户才能使用——换言之，前端开发人员只能被动等待供应商完成变更。而在可组合（composable）架构模式下，前端开发人员可直接集成 AI 服务，并按需即时启动开发。

The answer to this problem: Implement a composable architecture—build a composable frontend with [complete control over the user and developer experience](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend) while plugging in your preferred APIs, and don’t be held back from important user features.  
解决这一问题的答案是：采用可组合架构——构建一个可组合的前端，从而[全面掌控用户体验与开发者体验](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend)，同时灵活接入你偏好的各类 API，不再因关键用户功能而受阻。

A composable solution is integral to iteration velocity.  
可组合方案是提升迭代速度的关键所在。

## Iterate faster _and_ make better decisions with the Frontend Cloud  
## 借助前端云，更快迭代 _且_ 做出更优决策

One of my firmest beliefs is that iteration velocity can solve all software problems.  
我最坚定的信念之一是：迭代速度足以解决所有软件问题。

That’s because, as software engineers, we know that we are going to make mistakes. So we must iterate, experiment, and fix things. Quickly.  
这是因为，作为软件工程师，我们深知自己难免犯错；因此，我们必须持续迭代、快速实验并及时修复问题。

The velocity component is about speed and direction—it means moving faster _and_ making better decisions each step of the way.  
“速度”（velocity）不仅指快慢，更关乎方向——它意味着既要加速前行，也要在每一步都做出更明智的决策。

Here’s how the Frontend Cloud helps you iterate faster at every step of your software lifecycle:  
以下是前端云如何在软件生命周期的每个阶段助你实现更快速迭代：

### **Develop** your application

### **开发**您的应用程序

- [**Turborepo and Turbopack**](https://vercel.com/solutions/turborepo) **:** 利用智能的、团队共享的缓存机制，显著提升开发与部署阶段的构建性能

- [**React Server Components**](https://vercel.com/blog/understanding-react-server-components) **:** 简化数据集成的迭代过程

### **Preview** your site after you build it

### **预览**构建完成后的网站

- [**Preview deployments**](https://vercel.com/docs/deployments/preview-deployments) **:** 每次提交推送（commit push）均自动生成一个直接、不可变的预览部署，方便您与相关方共享

- [**Comments**](https://vercel.com/docs/workflow-collaboration/comments) **:** 在预览部署中提供类似 Figma 的实时反馈功能，并可通过 Slack、Linear 和 Jira 集成实现可操作的协作

- [**Fast builds**](https://vercel.com/docs/deployments/builds) **:** 预览流程中的每一步均支持快速构建，以持续保障团队开发效率

### **Ship** your site into production

### **上线**您的网站至生产环境

- [**Continuous Deployment:**](https://vercel.com/docs/deployments/overview) 通过您首选的 Git 托管平台，自动、快速地将应用部署至生产环境

- [**Edge Config**](https://vercel.com/docs/storage/edge-config) **:** 将应用配置全局推送至边缘网络节点，使 A/B 测试及其他实验性功能尽可能贴近终端用户运行

- [**Instant Rollback**](https://vercel.com/docs/deployments/instant-rollback) **：** 谁都会犯错，因此您可在一秒钟甚至更短时间内，立即回滚至应用的任意历史版本。

- [**即时回滚（Instant Rollback）**](https://vercel.com/docs/deployments/instant-rollback) **：** 我们都会犯错，因此您可在一秒钟甚至更短时间内，立即回滚至应用的任意历史版本。

Leverage The Frontend Cloud in order to enhance your time-to-market and optimize decision making at every step—that is, supercharge your iteration velocity.

借助前端云（The Frontend Cloud），全面提升您的上市速度（time-to-market），并在每个环节优化决策——换言之，极大提升您的迭代速度（iteration velocity）。

## Generative UI helps you take that first step

## 生成式 UI 助您迈出第一步

Iteration velocity matters at every step of the way, and our [new product v0 comes in](https://vercel.com/blog/announcing-v0-generative-ui) at the very first step. v0 makes website creation as simple as describing your ideas. We’ve dubbed it Generative UI—combining the best practices of frontend development with the potential of generative AI.

迭代速度在开发全流程中都至关重要；而我们的[全新产品 v0](https://vercel.com/blog/announcing-v0-generative-ui) 正是在“第一步”就为您赋能。v0 让网站构建变得如同描述想法一样简单。我们将其命名为“生成式 UI（Generative UI）”——融合前端开发的最佳实践与生成式 AI 的强大潜力。

v0 builds the first iteration of your application, similar to how ChatGPT does.

v0 会为您构建应用的首个迭代版本，其工作方式类似于 ChatGPT。

Here’s how it works:

以下是其工作流程：

- Describe the interface you want to build  

- 描述您希望构建的界面  

- v0 produces code using open-source tools like React, Tailwind CSS, and  

- v0 基于 React、Tailwind CSS 等开源工具生成代码，并使用  

`shadcn/ui`

`shadcn/ui`

- Select an iteration and keep editing in v0  

- 选择一个迭代版本，并继续在 v0 中编辑

- When you're ready, copy and paste that code into your app and develop from there  

- 准备就绪后，将该代码复制并粘贴到您的应用中，从此处开始开发。

It doesn’t replace the entire process, but rather it gets you started in seconds—another piece of your toolkit to iteration velocity—betting on the power of simple text prompts.  

它并非取代整个开发流程，而是让您在几秒钟内即刻启动——这是提升迭代速度的又一利器，其核心在于简单文本提示所蕴含的强大能力。

## **Configure less. Create more.**  

## **配置更少，创造更多。**

One of my favorite parts of my job is watching the brands achieve peak iteration velocity and solve software problems with tools like these.  

我工作中最喜爱的部分之一，就是见证各大品牌借助此类工具实现极致的迭代速度，并高效解决软件问题。

Another iteration velocity hack: With partnerships like AWS Marketplace, Vercel helps users take advantage of best-in-class AWS infrastructure with zero configuration, making a composable architecture cost-effective, flexible, and secure.  

另一项提升迭代速度的技巧：通过与 AWS Marketplace 等平台的合作，Vercel 使用户无需任何配置即可充分利用业界领先的 AWS 基础设施，从而让可组合式架构兼具成本效益、灵活性与安全性。

By going composable and leveraging tools like the Frontend Cloud and v0, teams can access peak iteration velocity, and lead with their frontend into an AI-first world.  

通过采用可组合式架构，并借助 Frontend Cloud 和 v0 等工具，团队能够实现极致的迭代速度，并以前端为引领，迈向以 AI 为先的新世界。

[**Vercel's Frontend Cloud is available on AWS Marketplace**  
\\  
Simplify your software buying experience: You can use your AWS EDP credits to buy Vercel. Get in touch with us to create your custom offer.  
\\  
Create Custom Offer](https://vercel.com/contact/sales)  

[**Vercel 前端云现已上线 AWS Marketplace**  
\\  
简化您的软件采购体验：您可使用 AWS EDP 信用额度购买 Vercel 服务。欢迎联系我们，为您定制专属报价方案。  
\\  
定制专属报价](https://vercel.com/contact/sales)

Vercel.com landing page  

Vercel.com 官网落地页  

### Turn your frontend into a profit center  

### 将您的前端转化为盈利中心  

![](images/vercel-at-aws-re_invent-2023-the-frontend-cloud-generative-ui-iteration-velocity/img_001.svg)

Download the whitepaper

下载白皮书

Blog post

博客文章

Sep 12, 2023

2023年9月12日

### How to create an optimal developer workflow

### 如何构建最优的开发者工作流

![](images/vercel-at-aws-re_invent-2023-the-frontend-cloud-generative-ui-iteration-velocity/img_002.jpg)![](images/vercel-at-aws-re_invent-2023-the-frontend-cloud-generative-ui-iteration-velocity/img_003.jpg)

Lindsey and Mark

林赛与马克
&#123;% endraw %}
