---
title: "Deploying dreams: An inside look at a summer internship with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/summer-internship-at-vercel"
date: "2024-09-13"
scraped_at: "2026-03-02T09:41:39.625251610+00:00"
language: "en-zh"
translated: true
description: "What's an internship like at Vercel? Hear firsthand from one of Vercel's summer interns what the process was like, what they worked on, and what they learned."
---
{% raw %}

Sep 13, 2024

2024年9月13日

Hello! I’m Aryan. I am currently a student at UC Berkeley, studying Electrical Engineering and Computer Science (EECS). This summer, I had the opportunity to be an intern at Vercel. It’s been an unforgettable experience. As my internship comes to a close and I head back to school, I want to share a behind-the-scenes look at what an internship at Vercel is like.

你好！我是Aryan。目前，我是加州大学伯克利分校（UC Berkeley）的一名学生，主修电子工程与计算机科学（EECS）。今年夏天，我有幸在Vercel担任实习生。这是一段令人难忘的经历。随着实习临近尾声、我即将重返校园，我想借此机会带大家一窥Vercel实习生活的幕后故事。

## How it all started

## 一切的起点

I started programming when I was in 8th grade. A major inflection point in my journey was competing in my first hackathon, Hack Cupertino 2018. This hackathon changed my mental model of the world. Instead of being a consumer of applications, I could become a creator. I could transform my ideas into code and publish it on the internet for others to use. Coding truly felt like a superpower.

我从八年级开始学习编程。我成长道路上的一个重要转折点，是参加了人生中第一场黑客松——2018年的Hack Cupertino。这场黑客松彻底改变了我对世界的认知：我不再只是应用程序的使用者，而可以成为创造者——将脑海中的想法转化为代码，并发布到互联网上供他人使用。编程，真的让我感觉拥有了超能力。

Throughout high school, I continued cultivating my development skills by interning at a few startups and competing in more hackathons around the US.

高中阶段，我通过在几家初创公司实习、以及在美国各地参加更多黑客松，持续磨砺自己的开发能力。

In college, I joined a club called [Cal Hacks](https://hackberkeley.org/) my freshman year. Cal Hacks hosts the world’s largest collegiate hackathon, bringing together over 2000 students from around the world for a 48-hour challenge. I love the magic of building with the community. As a part of the Cal Hacks team, I help build our own open-source software to streamline running hackathons.

进入大学后，我在大一就加入了名为[Cal Hacks](https://hackberkeley.org/)的社团。Cal Hacks主办全球规模最大的高校黑客松，每年汇聚来自世界各地逾2000名学生，共同参与一场为期48小时的极限挑战。我深深着迷于“与社区一同创造”的魔力。作为Cal Hacks团队的一员，我参与开发我们自研的开源软件，以提升黑客松的组织与运营效率。

## Why Vercel?

## 为什么选择Vercel？

I’ve been a customer of Vercel for years. Every hackathon or side project I created used Vercel and Next.js. The ease of use, incredible DX, and top-tier performance of both makes it easy to get started quickly. With tight competition timelines, I want as much time to focus on what I’m building, not infrastructure and configurations.

我早已是Vercel多年的用户。我参与的每一场黑客松、每一个个人项目，都离不开Vercel与Next.js。二者出色的易用性、卓越的开发者体验（DX）以及顶级的性能表现，让项目起步变得轻而易举。在紧张的竞赛时间表下，我希望把尽可能多的时间聚焦于真正要构建的功能本身，而非基础设施搭建与配置调优。

I’m inspired by Vercel’s culture of shipping fast, customer obsession, and sweating the details. Everything Vercel creates feels meticulously crafted, polished, and premium. I would see [shadcn](https://x.com/shadcn) and [John Phamous](https://x.com/JohnPhamous) sharing what they were working on, and I always wondered what it would be like to work at Vercel. I had to apply.

Vercel所倡导的“快速交付”“以客户为中心”以及“精益求精”的文化深深激励着我。Vercel打造的每一款产品，都呈现出精雕细琢、打磨完善、质感出众的特质。我常常看到[shadcn](https://x.com/shadcn)和[John Phamous](https://x.com/JohnPhamous)在社交平台上分享他们的工作进展，也一直好奇：在Vercel工作究竟是怎样一种体验？于是，我毫不犹豫地递交了申请。

## Vercel’s intern interview process

## Vercel实习生面试流程

The interview process at Vercel was different from most of my other interview experiences.  
Vercel 的面试流程与我此前经历过的大多数面试截然不同。

Vercel’s interview mimics what it is like to work on the job. It tests your ability to _break down a problem_ and _reason aloud about possible solutions_. Using Google and asking clarifying questions are encouraged.  
Vercel 的面试高度模拟真实工作场景，重点考察你 _拆解问题_ 和 _清晰阐述解决方案思路_ 的能力。鼓励使用 Google 搜索信息，也欢迎提出澄清性问题。

I prefer this style of interview as opposed to a “leetcode” style interview because it practically evaluates real-world engineering skills. It feels real and authentic, and less like a trap.  
我更青睐这种面试形式，而非典型的“LeetCode 式”算法面试——因为它能切实评估工程师在真实世界中所需的核心能力。整个过程显得真实、自然，而非设下陷阱般的考验。

All the hackathons and first-hand use of Vercel’s products paid off. I received an offer.  
此前参与的所有黑客松活动，以及对 Vercel 产品的亲身体验，最终都得到了回报——我收到了录用通知。

## What projects did I work on as an intern?

## 实习期间我参与了哪些项目？

During my internship, I had the opportunity to work on multiple projects across a few different teams and codebases. Surprisingly, these were not small apps off in the corner. They were high-traffic, high-visibility apps customers use every day.  
实习期间，我有幸跨多个团队和代码库参与了多个项目。出人意料的是，这些并非边缘化的“小应用”，而是客户每日高频使用、流量巨大、备受关注的核心产品。

I led three major efforts over my 12 weeks as an intern.  
在为期 12 周的实习中，我主导了三项重要工作。

### Support Center UX improvements

### 支持中心（Support Center）用户体验优化

The [Vercel Support Center](https://vercel.com/docs/dashboard-features/support-center) is a secure and streamlined way for Vercel Pro and Enterprise customers to communicate with the Vercel Support team. You can submit new support cases and view the status of existing support cases.  
[Vercel 支持中心](https://vercel.com/docs/dashboard-features/support-center) 是 Vercel Pro 与企业版客户与 Vercel 支持团队进行安全、高效沟通的官方渠道。用户可在此提交新的支持工单，并实时查看已有工单的处理状态。

The experience was functional, but it was lacking useful features. In collaboration with the Customer Success Engineers (CSEs), we identified ways we could improve the customer experience.  
该平台功能完备，但缺乏若干关键实用特性。我们与客户成功工程师（CSE）紧密协作，共同识别出多项可显著提升客户体验的优化方向。

- Search support case subjects  
- 支持工单主题搜索  

- Filter cases by case status  
- 按工单状态筛选工单

- Sort cases by created, updated, and severity fields  
- 按“创建时间”、“更新时间”和“严重程度”字段对工单进行排序  

This project gave me exposure to Vercel’s website monorepo powered by Turborepo, Next.js, Vercel’s internal design system ([Geist](https://vercel.com/geist)), and Vercel’s API. Here’s the before and after results.  
该项目让我深入了解了 Vercel 官网所采用的由 Turborepo 驱动的单体仓库（monorepo），以及其中使用的 Next.js、Vercel 内部设计系统（[Geist](https://vercel.com/geist)）和 Vercel 的 API。以下是改版前后的效果对比。

![Screenshot of Support Center before changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_001.jpg)![Screenshot of Support Center before changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_002.jpg)  
![Support Center 改版前截图](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_001.jpg)![Support Center 改版前截图](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_002.jpg)

Screenshot of Support Center before changes  
Support Center 改版前截图

![Screenshot of Support Center after changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_003.jpg)![Screenshot of Support Center after changes](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_004.jpg)  
![Support Center 改版后截图](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_003.jpg)![Support Center 改版后截图](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_004.jpg)

Screenshot of Support Center after changes  
Support Center 改版后截图

After revamping the Support Center page, I published a [changelog](https://vercel.com/changelog/improvements-to-support-center) announcing the improvements. I was also able to share these improvements with the rest of the company during Demo Day, a weekly meeting at Vercel where we get to show each other what we’ve been working on.  
在完成 Support Center 页面的重构后，我发布了一份[更新日志](https://vercel.com/changelog/improvements-to-support-center)，正式宣布此次优化。此外，我还借 Vercel 每周一次的“Demo Day”（成果展示日）向全公司同事分享了这些改进——这是 Vercel 内部一项惯例活动，大家借此机会展示各自近期的工作成果。

### The new v0  
### 全新版本的 v0  

After Support Center, I transitioned to working on the next iteration of v0.  
完成 Support Center 项目后，我转入 v0 下一版本的开发工作。

When [Vercel first announced v0](https://vercel.com/blog/announcing-v0-generative-ui), it was a generative user interface system powered by AI. It generates copy-and-paste friendly React code based on [shadcn/ui](https://ui.shadcn.com/) and [Tailwind CSS](https://tailwindcss.com/) that you can use in their projects.  
当 [Vercel 首次发布 v0](https://vercel.com/blog/announcing-v0-generative-ui) 时，它是一个由 AI 驱动的生成式用户界面系统：可根据 [shadcn/ui](https://ui.shadcn.com/) 和 [Tailwind CSS](https://tailwindcss.com/) 自动生成开箱即用、可直接复制粘贴的 React 代码，供开发者集成至自己的项目中。

When I joined, we were preparing to launch [v0’s new conversational UI](https://x.com/v0/status/1826020673908535325).

我加入时，团队正筹备发布 [v0 的全新对话式用户界面](https://x.com/v0/status/1826020673908535325)。

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_005.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_006.jpg)

In the new v0, I spearheaded the implementation of citations. This involved enhancing the Retrieval Augmented Generation (RAG) pipeline to source high-quality documentation and guides from Next.js, Vercel, Turborepo, Turbopack, AI SDK, and shadcn/ui. Additionally, I developed the frontend interface for displaying sources and inline citations. The team and I iterated on multiple versions of what the sources would look like. Below are some of the iterations we worked through before arriving at the final design.

在新版 v0 中，我主导了“引用标注”（citations）功能的实现。这包括优化检索增强生成（Retrieval Augmented Generation, RAG）流程，使其能从 Next.js、Vercel、Turborepo、Turbopack、AI SDK 和 shadcn/ui 等平台中精准提取高质量的文档与指南；同时，我还开发了用于展示信息来源及行内引用的前端界面。我和团队围绕“引用源应如何呈现”进行了多轮设计迭代。以下是我们最终确定设计方案前经历的部分迭代过程。

**Iteration 1:** Initially, we wanted to display the sources as cards at the top of chat assistant’s response, so user’s would know which sources were referenced when generating the answer.

**第一轮迭代：** 最初，我们计划将引用源以卡片形式置于聊天助手回复的顶部，以便用户在阅读答案时即刻了解其依据来源。

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_007.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_008.jpg)

**Iteration 2:** We felt Iteration 1 was too invasive and demanded too much of the user’s attention. We then tried a pill-like design forIteration 2. The more compact design took up less space and drew less attention. We also moved them below the chat assistant’s response instead of at the top.

**第二轮迭代：** 我们认为第一轮设计过于突兀，对用户注意力干扰过大。于是尝试采用类胶囊（pill-like）样式——这种更紧凑的设计占用空间更小、视觉干扰更低；同时，我们将引用源位置从回复顶部移至底部。

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_009.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_010.jpg)

**Iteration 3:** The pills in Iteration 2 lacked key information about the source. We switched back to the cards, but redesigned them to be more compact and less distracting, while providing more information about the source. It was a balanced compromise.

**第三轮迭代：** 第二轮的胶囊样式虽简洁，却缺失了关于引用源的关键信息。因此我们回归卡片形式，但对其进行了重新设计：在保持紧凑性与低干扰性的同时，显著增强了信息承载能力。这一方案达成了功能完整性与用户体验之间的良好平衡。

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_011.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_012.jpg)

The introduction of citations enables v0’s answers to be grounded in facts, as the output uses numbered references (like a research paper) to justify its response.

引入引用标注功能后，v0 的回答得以真正“基于事实”——其输出采用类似学术论文的编号引用方式，为每项结论提供可追溯、可验证的信息来源支撑。

After building citations, I began rolling out hundreds of beta invitations to the new v0. This included building out the onboarding experience to seamlessly introduce users to the new iteration.

在完成引用功能开发后，我开始向数百名用户发放新版本 v0 的测试邀请。这其中包括构建全新的新手引导流程，以无缝地将用户引入这一全新迭代版本。

![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_013.jpg)![](images/deploying-dreams-an-inside-look-at-a-summer-internship-with-vercel-vercel/img_014.jpg)

The new v0 has been a lot of fun to help build and use. You can create some [incredible experiences](https://x.com/evilrabbit_/status/1826385997376225643) with it. If you haven’t tried it yet, [you should](https://v0.dev/chat).

新版 v0 的开发与使用过程充满乐趣。借助它，你可以打造一些[令人惊叹的体验](https://x.com/evilrabbit_/status/1826385997376225643)。如果你尚未尝试，[现在就该试试了](https://v0.dev/chat)。

### Feeding the new v0 brain

### 为新版 v0 “注入大脑”

One of the best parts of working at Vercel is access to some of the best and brightest minds in the industry. Everyone is such a wealth of insight and knowledge. Sadly, this knowledge can remain trapped within Vercel. I saw an opportunity to democratize this knowledge and share it with the community.

在 Vercel 工作的一大优势，是能接触到业界最顶尖、最富创造力的一批人才。每位同事都见解深刻、知识渊博。遗憾的是，这些宝贵的知识往往仅限于 Vercel 内部流通。我意识到，这是一个将知识“民主化”的契机——将其开放并分享给更广泛的开发者社区。

I set out to create v0 Brain—a way to seamlessly bring the best internal Vercel insights, recommendations, and UI design aesthetic directly from the creators of React, Next.js, shadcn/ui, Turbo, SWC, and more to further supplement v0’s knowledge. The workflow needed to be effortless. Vercel lives in Slack and we love emojis (we have over 8000 custom emojis). The v0 Brain workflow is based off a specific emoji reaction. Add the emoji reaction to any insightful message in Slack and it funnels the insight to the AI team to be evaluated and added to v0’s underlying AI model.

为此，我着手创建了 **v0 Brain** —— 一种机制，可将 Vercel 内部最前沿的洞见、实践建议与 UI 设计美学，直接从 React、Next.js、shadcn/ui、Turbo、SWC 等技术的缔造者手中，无缝引入 v0，从而进一步丰富其底层 AI 模型的知识储备。整个工作流必须轻量无感：Vercel 的日常协作围绕 Slack 展开，而我们对 Emoji 情有独钟（公司内部自定义 Emoji 超过 8000 个）。v0 Brain 的核心机制正是基于一个特定 Emoji 表情反应：只需在 Slack 中任意一条富有洞见的消息下添加该 Emoji，这条内容便会自动进入 AI 团队的评估队列，经审核后整合进 v0 的底层 AI 模型。

Again, I had the opportunity to present at Demo Day, where I shared how anyone in the company can contribute to v0’s knowledge base with ease in our day-to-day conversations with each other.

再次，我有幸在 Demo Day 上进行展示，向全体同事介绍了如何在日常交流中轻松贡献洞见，共同完善 v0 的知识库。

## What was it like working at Vercel?

## 在 Vercel 工作是一种怎样的体验？

I had direction, but I had full autonomy from day one. I had immense support from my manager and “welcome buddies” to quickly get onboarded and oriented. Working with a sense of urgency and iteration velocity are Vercel core values. I started merging pull requests and releasing to Production on my second day. I shipped over 80 pull requests during my internship. Working at Vercel is like the intensity of a hackathon, but with just the right amount of tools, safeguards, and processes in place to ensure quality.

我始终拥有清晰的方向指引，但自入职第一天起便享有充分的自主权。我的经理和“欢迎伙伴”（Welcome Buddies）给予了我极大的支持，帮助我快速完成入职与适应。紧迫感与高速迭代，是 Vercel 的核心价值观。入职第二天，我便已开始合并 Pull Request 并向生产环境发布代码；整个实习期间，我共提交了 80 多个 Pull Request。在 Vercel 工作，就像一场高强度黑客松，但同时配备了恰到好处的工具链、防护机制与流程规范，确保交付质量。

I had the opportunity of working on several impactful projects during my internship, all of which directly contributed to the core product and made it into Production. I had full ownership of my projects end-to-end. In a lot of ways, I felt more like a full-time software engineer versus an intern on the team, which I really enjoyed.

实习期间，我有幸参与多个具有实际影响力的重要项目，所有项目均直接服务于 Vercel 的核心产品，并最终上线生产环境。我对所负责项目拥有端到端的完整所有权。在很多方面，我感觉自己更像一名全职软件工程师，而非团队中的实习生——这种体验令我倍感欣喜。

The best part of the Vercel experience is the people. I met some of my design and engineering heroes. Like the creators of major OSS projects, such as [shadcn](https://x.com/shadcn) of shadcn/ui and [Paul Henschel](https://x.com/0xca0a) of zustand and react-three-fiber, and the famed leadership of Vercel. Learning firsthand from the greats was unforgettable. All of them are kind, welcoming, and encouraging.

Vercel 体验中最棒的部分，是这里的人。我有幸结识了一些我心目中的设计与工程领域偶像——比如主流开源项目（OSS）的缔造者：[shadcn/ui](https://x.com/shadcn) 的作者 [shadcn](https://x.com/shadcn)，以及 Zustand 和 react-three-fiber 的作者 [Paul Henschel](https://x.com/0xca0a)，还有 Vercel 久负盛名的领导团队。能亲耳聆听这些业界巨擘的指导，是一段令人终生难忘的经历。他们每个人都亲切友善、热情包容、充满鼓励。

I was motivated every day because I knew my work would impact Vercel’s millions of global users. Working at Vercel as an intern has truly been a dream come true.

每天我都备受鼓舞，因为我深知自己的工作将影响 Vercel 全球数百万用户。能在 Vercel 担任实习生，真真切切地圆了我的职业梦想。

## What did I learn during my internship?

## 我在实习期间学到了什么？

I learned a tremendous amount during my internship that helped me become a better engineer and team player. Here’s some of my key learnings:

实习期间，我收获巨大，不仅提升了工程能力，也成长为更优秀的团队协作者。以下是我一些关键的学习成果：

- **I learned how to work in engineering at scale**. Tools like TypeScript help keep vast codebases spanning multiple years and numerous programmers maintainable.

- **我学会了如何在规模化工程环境中协作开发**。TypeScript 等工具，让横跨多年、由众多工程师共同维护的庞大代码库依然清晰、健壮、易于维护。

- **I learned how to communicate my ideas.** Through design documents and request for comments (RFCs), this helped me get early feedback and buy-in from the team.

- **我掌握了如何高效表达自己的技术构想**。通过撰写设计文档（Design Documents）和征求意见稿（RFCs），我得以在早期就获得团队反馈，并赢得共识与支持。

- **I exercised “design engineering” muscles.** Creating user interfaces that invoke feelings of delight and joy. Attention to detail is important, like this example of a [loading animation I created for v0](https://x.com/aryanvichare10/status/1820666125035642898).

- **我锻炼了“设计型工程”（design engineering）的能力**。即打造能唤起用户愉悦与欣喜之情的用户界面。细节至关重要——例如我为 [v0](https://x.com/aryanvichare10/status/1820666125035642898) 设计的加载动画，便是其中一例。

- **I learned advanced LLM techniques.** Few-shot prompting, chain of thought (CoT) prompting with structured tagging, prompt chaining, and efficient parsing and chunking strategies were all new to me. I also learned how to add an observability and tracing layer on top of LLMs and build robust empirical evaluations (evals for short) to benchmark the performance of our models.

- **我掌握了前沿的大语言模型（LLM）技术**。包括少样本提示（few-shot prompting）、带结构化标签的思维链（Chain-of-Thought, CoT）提示、提示链（prompt chaining），以及高效的解析与分块（parsing and chunking）策略——这些对我而言都是全新知识。此外，我还学习了如何为 LLM 构建可观测性与追踪（observability and tracing）层，并搭建稳健的经验评估体系（简称 evals），以系统性地衡量模型性能。

There is more to being an engineer than your technical skills. I meet with several people across the company for coffee chats, both within Engineering, but also Design, Customer Success, and Sales. These conversations helped uncover soft skills I’ll remember just as well:

工程师的价值远不止于技术能力。我与公司内多位同事开展了轻松的咖啡闲聊（coffee chats）——不仅限于工程团队内部，还覆盖了设计（Design）、客户成功（Customer Success）和销售（Sales）等部门。这些对话让我深刻体会到那些同样值得铭记的软技能：

- **Work in public.** Get in the habit of asking questions aloud and being proactive in posting blockers and updates. This fosters a culture of feedback and collaboration. I would post updates multiple times a day about what I’m working on and send recaps of the major things I did in that week so stakeholders were on the same page. This is especially important in remote working environments.

- **公开协作（Work in public）**。养成主动开口提问的习惯，并积极发布当前阻塞点（blockers）与进展更新。这有助于营造开放反馈与紧密协作的文化氛围。我每天会多次发布自己正在推进的工作内容；每周还会整理一份简明周报，汇总当周完成的关键事项，确保所有相关方信息同步。在远程办公环境中，这一点尤为重要。

- **Communicate clearly and effectively.** Aim for simplicity in your writing and strip complexity. Value people’s time. By decluttering your writing, you can more effectively deliver your message in the clearest way possible. Writing effectively is also about knowing your target audience. Write with the reader in mind.

- **清晰、高效地沟通。** 力求文字简洁，去除冗余与复杂性；尊重他人的时间。通过精简文字，你能以最清晰的方式更有效地传递信息。高效写作还意味着了解你的目标读者——始终以读者为中心进行写作。

- **Pair program more.** Vercel has a strong pair-programming culture and I love it for two reasons: 1) I practice communicating a problem or task at hand with another engineer in real-time and 2) I get to learn how others think and solve problems. I find myself also picking up on productivity tips, which helps me become a more efficient developer.

- **更多地结对编程。** Vercel 拥有浓厚的结对编程文化，我对此十分喜爱，原因有二：1）我得以实时与另一位工程师沟通当前面临的问题或任务；2）我能观察并学习他人思考与解决问题的方式。此外，我也常常从中汲取实用的提效技巧，从而成长为一名更高效的开发者。

- **Iterate to greatness (ITG).** ITG is one of my favorite Vercel values. The term encapsulates the idea of launching and shipping quickly without comprising quality. It’s not about achieving perfection on your first try, but instead, launching an initial version and rapidly iterating on it until it’s great.

- **迭代臻于卓越（Iterate to Greatness, ITG）。** ITG 是我最欣赏的 Vercel 核心价值观之一。这一理念强调在不牺牲质量的前提下快速发布与交付产品。它并非要求你在首次尝试中就追求完美，而是鼓励你先推出初始版本，并通过快速迭代不断优化，直至臻于卓越。

- **Practice managing up.** Regularly update your manager and stakeholders on progress, blockers, and wins (big and small). I would proactively seek feedback weekly, so I’d be continually learning and growing. Make sure to align your work with team and company priorities, and be ready to articulate how your efforts contribute to broader company goals.

- **主动践行“向上管理”。** 定期向你的经理及关键干系人同步工作进展、遇到的阻碍，以及取得的成果（无论大小）。我习惯每周主动寻求反馈，从而持续学习与成长。务必确保个人工作与团队及公司整体优先事项保持一致，并能清晰阐述你的努力如何支撑公司更宏大的战略目标。

## What advice do you have for other interns and engineers?

## 对其他实习生和工程师，你有什么建议？

Finding an internship or full-time job can be a grueling and intimidating. I have experienced this firsthand—spending several months applying to hundreds of companies, constantly preparing for technical leetcode-style interviews, and receiving numerous rejection letters. It’s tough. But when it finally lands, it's worth it. Keep going.

寻找实习或全职工作可能是一段漫长而令人望而生畏的过程。我对此深有体会——曾花费数月时间向数百家公司投递简历，持续准备以 LeetCode 风格为主的各类技术面试，并收到过大量拒信。这确实艰难。但当机会最终来临，一切付出都值得。请坚持下去。

My advice? Build up your experience bank. The process of taking an idea from _zero to deployed_ will teach you what it’s like to think through the software delivery process. I picked up this experience by working on hackathon and side projects. Building real apps that solve your own problems or scratch your own curiosities cannot be understated. In hindsight, this is what helped me the most in getting an internship at Vercel. I was well versed in building and deploying apps with Vercel’s tech stack before I joined. It gave me immense confidence in applying and interviewing.

我的建议？不断积累你的“经验银行”。将一个想法从 _零起步到成功上线_ 的全过程，能让你真正理解软件交付的完整思维链条。我正是通过参与黑客松（hackathon）和业余项目积累了这类经验。亲手构建解决自身实际问题、或满足自身好奇心的真实应用，其价值怎么强调都不为过。回过头看，这恰恰是我最终获得 Vercel 实习机会的最关键因素——在我加入之前，已熟练掌握使用 Vercel 技术栈构建与部署应用的全流程，这让我在申请与面试中充满信心。

Spend time investing in yourself. Build that idea you’ve been sitting on. You never know where it’ll take you.

花时间投资自己。把你一直搁置在脑海中的那个点子付诸实践吧。你永远无法预知它将带你走向何方。
{% endraw %}
