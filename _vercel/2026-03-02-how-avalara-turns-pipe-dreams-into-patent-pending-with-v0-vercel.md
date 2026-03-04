---
title: "How Avalara turns pipe dreams into patent-pending with v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/How-avalara-turns-pipedreams-into-patent-pending-with-v0"
date: "2026-03-02"
scraped_at: "2026-03-03T07:10:16.406233010+00:00"
language: "en-zh"
translated: true
description: "For Chief Strategy and Product Officer Jayme Fishman, the path to modernizing Avalara starts with how it builds."
---
{% raw %}

Mar 2, 2026

2026年3月2日

Avalara shipped an AI-native customer workflow on Vercel.

Avalara 在 Vercel 上推出了原生集成 AI 的客户工作流。

Avalara connects businesses to more than 1,400 systems to automate tax compliance around the world. It’s a massively complex ecosystem that spans ERP systems, finance platforms, and compliance tools, all talking to each other.

Avalara 将企业与全球超过 1,400 个系统连接起来，以自动化税务合规流程。这是一个规模庞大、高度复杂的生态系统，横跨 ERP 系统、财务平台和合规工具，所有这些系统彼此交互、协同运作。

For Chief Strategy and Product Officer Jayme Fishman, the path forward is modernizing how Avalara builds. His mandate is to drive digital transformation, with a sharp focus on AI and innovation.

对于首席战略与产品官 Jayme Fishman 来说，前进的方向在于推动 Avalara 构建方式的现代化。他的使命是引领数字化转型，并将重点明确聚焦于人工智能与创新。

Enter Vercel’s v0, which translates plain language into working prototypes. Within months, the team built two new patent pending products—and along the way, changed how the company builds.

此时，Vercel 的 v0 应运而生——它能将自然语言直接转化为可运行的原型。短短数月内，团队便开发出两款全新且已提交专利申请的产品；与此同时，公司整体的产品构建方式也由此发生转变。

## **Seeing is believing**

## **眼见为实**

Before v0, bringing an idea to life required a mountain of slides, careful specs, and ample interpretation. Fishman might have a strong vision, but getting started meant writing everything down, then waiting for designers and engineers to bring it to life.

在 v0 出现之前，将一个构想落地需要堆积如山的幻灯片、严谨详尽的需求文档，以及大量反复沟通与解读。Fishman 或许拥有清晰而坚定的愿景，但项目启动的第一步却是将一切想法逐字写下，再静待设计师与工程师将其变为现实。

“It could be a significant delay before we even had a conceptual mock-up.”

“在我们甚至获得一个概念性原型之前，就可能已遭遇显著延误。”

That changed overnight.

这一局面一夜之间彻底改变。

One of Avalara's biggest challenges was supporting customers who could be plugging into more than a thousand different systems. "We could provide technical documentation and show customers what to do," Fishman said, "but we couldn't see what they were doing. Once they left our system, we lost visibility… and the ability to help."

支持客户接入上千种不同系统，是 Avalara 面临的最大挑战之一。“我们可以提供技术文档，向客户说明该怎么做，”Fishman 表示，“但我们无法看到他们实际在做什么。一旦客户离开我们的系统，我们就失去了可见性……也失去了及时提供帮助的能力。”

Fishman imagined a solution that could meet customers where they were. What if Avalara built a Chrome extension that could live alongside a user's workflow, walk them through each step of an integration specific to the systems they were using, and stay behind to answer any questions? He described it to a teammate, who went straight into v0.

费什曼构想了一种能够“在客户所处的位置”为其提供支持的解决方案。倘若 Avalara 开发一款 Chrome 扩展程序，使其嵌入用户日常工作流之中，引导用户完成与其所用系统相匹配的集成操作每一步，并持续驻留以随时解答疑问，会怎样？他向一位同事描述了这一构想，对方随即直接着手开发 v0 版本。

"The next morning, there's a video in my Slack. It shows exactly what I described the night before," Fishman recalled. "I showed it to my exec team, and all the light bulbs lit up."

“第二天一早，我的 Slack 里就出现了一段视频——完全还原了我前一晚描述的内容。”费什曼回忆道，“我把它展示给高管团队，所有人瞬间豁然开朗。”

### _“I can describe what I want and wake up to a working demo. It’s tectonically shifting how we build.”_

### _“我能用语言描述我想要什么，醒来时已看到一个可运行的演示版本。这正在从根本上重塑我们的构建方式。”_

That demo—built in v0—became the basis for a new patent, a production build, and a press release, all within about 60 days. “It was one of those moments,” he said, “where you realize you don’t need to talk people into an idea if they can see it.”

这个由 v0 构建而成的演示版本，约 60 天内便催生了一项新专利、一个正式上线版本，以及一份新闻稿。“那是那种令人顿悟的时刻，”他说，“你意识到：只要人们亲眼看见，就不必再费力说服他们接受一个想法。”

## **Driving alignment with product design**

## **以产品设计驱动协同对齐**

Like many SaaS organizations, Avalara’s product and design process used to depend on long handoffs. Product managers wrote PRDs. Designers translated them into Figma files. Engineers reviewed and rebuilt. “There’s desire and intent,” Fishman said, “and then there’s what actually happens—where everyone gets tagged in late and we lose momentum.”

与许多 SaaS 公司类似，Avalara 过去的产品与设计流程严重依赖冗长的跨角色交接：产品经理撰写产品需求文档（PRD）；设计师将其转化为 Figma 文件；工程师再审阅并重新实现。“我们有愿望和意图，”费什曼表示，“但现实却是——所有人往往都被‘@’得过晚，导致项目节奏不断流失。”

With v0, that flow changed completely. Product leads now start directly in the tool, describing what they want in plain language and watching v0 translate intent into a functioning interface. “It’s like you can will it into existence,” Fishman said. “You describe the problem, and five minutes later, you’re looking at a solution.”

而借助 v0，整个流程彻底改变：产品负责人如今直接在工具中启动工作，用平实的语言描述需求，并实时见证 v0 将意图转化为可运行的界面。“就像你能凭意念让其成真一样，”费什曼说，“你描述问题，五分钟后，解决方案已呈现在眼前。”

For designers, the shift has been equally dramatic. “You can just grab someone, show them what you mean, and start iterating,” Fishman explained. “It takes something that used to be async and turns it into a real conversation.”

对设计师而言，这种转变同样意义深远。“你只需拉上一位同事，直观地展示你的想法，然后立刻开始迭代，”费什曼解释道，“它把过去异步进行的工作，转变为一场真正即时的对话。”

## **A new way of building**

## **一种全新的构建方式**

Across Avalara, prototypes have replaced concepts. Fishman calls it “a cultural accelerant.”

在 Avalara 全公司范围内，原型已全面取代抽象概念。费什曼将之称为“一种文化加速器”。

The results speak for themselves: two patent-pending products created in roughly 60 days, faster design and validation cycles, and a company-wide shift toward building through iteration, not interpretation.”

成果不言自明：约60天内便打造出两款正在申请专利的产品，设计与验证周期大幅缩短，并推动全公司转向“通过迭代构建，而非依赖解读”的开发范式。

_**About Avalara:**_  
_**关于 Avalara：**_

_Avalara connects businesses to more than 1,400 systems to automate tax compliance around the world._  
_Avalara 为全球企业连接逾 1,400 个系统，实现税务合规自动化。_
{% endraw %}
