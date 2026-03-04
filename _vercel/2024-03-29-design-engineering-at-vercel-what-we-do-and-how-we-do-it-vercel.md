---
title: "Design Engineering at Vercel: What we do and how we do it - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/design-engineering-at-vercel"
date: "2024-03-29"
scraped_at: "2026-03-02T09:45:52.247071824+00:00"
language: "en-zh"
translated: true
description: "Design Engineers at Vercel blend aesthetic sensibility with technical skills. Learn about Vercel's philosophy on what Design Engineering is and how we work."
---
{% raw %}

Mar 29, 2024

2024年3月29日

了解什么是“设计工程师”（Design Engineer），以及他们在 Vercel 的工作内容。

“设计工程师”是一个日益流行的新职位——既令人困惑，又充满吸引力。人们对优质软件在视觉呈现与交互体验上的期待，已达到前所未有的高度。而设计工程师，正是超越这一期待的核心力量。

本文将深入幕后，介绍 Vercel 的设计工程实践：我们的工作内容、所需技能，以及我们如何助力产品以极高的完成度（polish）与性能（performance）交付上线。

## What is a Design Engineer?

## 什么是设计工程师？

Vercel 的设计工程师兼具审美素养与技术能力。这使我们能够深入理解问题本质，并独立完成从设计、开发到交付的全过程。

这支团队由具备多元技能且充满好奇心的成员组成。我们持续探索各类新兴工具与媒介。这种跨学科的方法，推动着我们在 Web 领域不断突破可能性的边界。

## What do Design Engineers care about?

## 设计工程师关注什么？

设计工程师致力于交付卓越的用户体验，让终端用户产生深刻共鸣。对 Web 而言，这意味着：

- 令人愉悦的用户交互与直观易用的操作提示（affordances）

- Building reusable components/primitives  
- 构建可复用的组件/基础元素  

- Page speed  
- 页面加载速度  

- Cross-browser support  
- 跨浏览器兼容性  

- Support for inclusive input modes (touch, pointers, etc.)  
- 支持包容性输入方式（触控、指针设备等）  

- Respecting user preferences  
- 尊重用户偏好设置  

- Accessible to users of assistive technology  
- 对辅助技术使用者友好  

There is a lot of work behind the pretty pixels. Design Engineers must go beyond visual appeal and ensure the other pieces that make an exceptional user experience are taken care of.  
华丽像素背后，蕴藏着大量工作。设计工程师不能止步于视觉美感，还需确保构成卓越用户体验的其他关键环节均得到妥善处理。

## What do Design Engineers do?  
## 设计工程师的工作内容是什么？

At Vercel, Design Engineers work across the company, contributing to branding, marketing, product development, and the internal design system. This collaboration falls under these workflows:  
在 Vercel，设计工程师横跨公司多个部门，参与品牌建设、市场营销、产品开发以及内部设计系统建设。此类协作涵盖以下工作流程：

### Design collaboration  
### 设计协作

Design Engineers work closely with designers to implement designs, skipping the traditional handoff process. Instead of handing off a completed design, a Designer sketches the start and iterates with a Design Engineer in Figma or code to produce the final design. Lots of technical exploration is done to push the designs.

设计工程师与设计师紧密协作，共同实现设计方案，跳过传统的“设计交接”流程。设计师不再交付一份已完成的设计稿，而是先绘制初步草图，再与设计工程师在 Figma 或代码中协同迭代，最终产出完整设计。在此过程中，会开展大量技术探索，以突破设计的边界。

This close collaboration between Designer and Design Engineer starts from idea to production. Design Engineers consult Designers on aspects like:

这种设计师与设计工程师之间的深度协作贯穿从创意构思到产品上线的全过程。设计工程师会在以下方面向设计师提供咨询与建议：

- Considering implementation cost versus the impact on experience—for example, some animations are unnecessary because they are not the main focus.

- 权衡实现成本与用户体验影响——例如，某些动画并非核心关注点，因而并无必要实现。

- Deciding if a component is one-off or built for reusability.

- 判断某个组件是一次性使用，还是应构建为可复用的通用组件。

- Providing guidance based on web practices or experience.

- 基于 Web 最佳实践或实际经验提供建议与指导。

- Prototyping design explorations that are easier to do outside of Figma—for example, animations, keyboard controls, and touch are better implemented in code to save the time and effort of reimplementing them from a different medium to the web.

- 对那些在 Figma 外更易实现的设计探索进行原型开发——例如动画、键盘操作和触控交互，直接通过代码实现可避免将设计从其他媒介重新适配至 Web 所带来的额外时间与人力成本。

Collaboration happens through Slack messages, screenshots, videos, preview links, and Zoom calls.

协作方式包括 Slack 消息、截图、录屏视频、预览链接以及 Zoom 会议。

### Product team integration

### 与产品团队融合

Design Engineers are embedded in a product team to help launch features that usually take more than a month. A Designer may or may not assist. When a Designer does help, the Design Engineer implements the UI while the product team implements the API and infrastructure.

设计工程师嵌入产品团队，协助上线通常需耗时一个月以上的功能。设计师可能参与，也可能不参与。当设计师参与时，设计工程师负责实现用户界面（UI），而产品团队则负责实现 API 和基础设施。

When a Designer isn’t helping, it doesn’t mean the Design Engineer works alone on the design and implementation. The Design Engineer creates the initial sketch and gets feedback from both Designers and Engineers.

当设计师未参与时，并不意味着设计工程师需独自完成全部设计与实现工作。设计工程师会先创建初始草图，并同步向设计师与工程师团队征询反馈意见。

### Independent ownership

### 独立所有权

This happens for features that are related to a user pain point and takes a few days to weeks to launch. The Design Engineer will sketch in Figma or code a solution, socialize the change, incorporate feedback, then ship it.

这种情况适用于那些直击用户痛点的功能，其开发周期通常为数天至数周。设计工程师会在 Figma 中绘制原型，或直接编写代码实现方案，随后向团队同步变更、收集反馈，并最终上线发布。

The team also works on design-led projects. Being part of the Design team gives Design Engineers the autonomy and ability to work on things that would often get deprioritized in an Engineering backlog.

团队同时推进以设计为驱动的项目。作为设计团队的一员，设计工程师拥有充分的自主权，能够专注于那些在工程团队待办事项（Engineering backlog）中常被降级或搁置的工作。

The team puts resources towards polished interactions, no dropped frames, no cross-browser inconsistencies, and accessibility. Examples of design-led projects are:

团队将资源投入于打磨交互细节、确保零掉帧、消除跨浏览器不一致问题，并全面保障可访问性（accessibility）。以设计为驱动的项目示例如下：

1. [Vercel’s Geist font](https://vercel.com/font): A Sans and Mono font. An interactive playground to see every glyph and try the font.

1. [Vercel 的 Geist 字体](https://vercel.com/font)：一款无衬线体（Sans）与等宽字体（Mono）家族。提供交互式体验平台，可预览全部字形并实时试用该字体。

2. [Vercel’s design system documentation](https://vercel.com/geist/introduction): An interactive docs playground used by engineers across the company to ship Vercel.

2. [Vercel 的设计系统文档](https://vercel.com/geist/introduction)：一个交互式文档沙盒，供公司内所有工程师使用，助力高效交付 Vercel 产品。

3. [Vercel’s Design Team homepage](https://vercel.com/design): An exploratory page for testing new web techniques and providing design resources.

3. [Vercel 设计团队主页](https://vercel.com/design)：一个探索性页面，用于试验前沿 Web 技术，并向团队提供设计资源支持。

4. [Delighters in the Vercel Dashboard](https://vercel.com/changelog/hints-now-available-when-creating-environment-variables): Features in the Vercel Dashboard that bring it to life and delight the user.

4. [Vercel 控制台中的“愉悦点”功能（Delighters）](https://vercel.com/changelog/hints-now-available-when-creating-environment-variables)：控制台中一系列让界面更生动、提升用户愉悦感的功能特性。

No matter the workflow, we are given space to prioritize quality over quantity. We recognize that what we ship is never in a perfect state. _Iterate to Greatness_ is one of Vercel’s principles, allowing us to balance business goals with craft by shipping continuous improvements and avoiding the perfection trap.

无论采用何种工作流程，我们都拥有充分空间，将质量置于数量之上。我们深知，任何交付成果都不可能臻于完美。“持续迭代，臻于卓越（Iterate to Greatness）”是 Vercel 的核心原则之一——它使我们得以在商业目标与工程匠心之间取得平衡：通过持续交付渐进式改进，规避对“完美”的执念陷阱。

## The Design Engineering toolbox

## 设计工程工具箱

There’s no fixed toolset for a Design Engineer. There’s no best background. Everyone has different origins and has accumulated good taste. This diversity is essential because everyone’s skills complement the team.

设计工程师没有固定的工具集，也没有所谓“最佳”的背景。每个人的成长路径各不相同，却都逐步培养出了良好的审美判断力。这种多样性至关重要，因为每位成员的专长都能为团队能力形成有效补充。

While no individual is expected to have all the skills, the team collectively is able to execute on ambitious designs because we can:

尽管并不要求每位成员掌握全部技能，但团队整体却能落地执行富有雄心的设计方案，因为我们具备以下能力：

- Design in Figma  
- 在 Figma 中进行设计  

- Design in code  
- 以代码方式进行设计  

- Write production code  
- 编写可用于生产的代码  

- Debug browser performance  
- 调试浏览器性能问题  

- Write GLSL shaders  
- 编写 GLSL 着色器  

- Write copy  
- 撰写文案  

- Create 3D experiences with Three.js  
- 使用 Three.js 构建 3D 交互体验  

- Create 3D models/scenes in Blender  
- 在 Blender 中创建 3D 模型/场景

- Edit videos using CGI and practical camera effects  
- 使用计算机生成图像（CGI）与实拍镜头特效进行视频剪辑  

We collaborate on everything because of each person’s unique background and skills. While each person can execute independently, we’ve found that our best work is done through collaboration. None of us is process/tools-driven. We care about the outcome, not the process/tool.  
我们开展一切协作，源于每位成员独特的背景与技能。尽管每位成员均可独立完成任务，但我们发现，最出色的工作成果始终诞生于协作之中。我们中无人以流程或工具为导向；我们关注的是结果，而非流程或工具本身。

## Examples of Design Engineering  
## 设计工程实践案例  

You can see our team’s work across Vercel:  
您可在 Vercel 的各项产品中看到我们团队的工作成果：

- Creating and maintaining components for the [internal design system](https://vercel.com/design/components) used on everything from [Vercel.com](http://vercel.com/) to the [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) and the [Next.js documentation](https://nextjs.org/docs).  
- 为内部设计系统（[internal design system](https://vercel.com/design/components)）创建并维护组件，该系统广泛应用于 [Vercel.com](http://vercel.com/)、[Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) 及 [Next.js 文档](https://nextjs.org/docs) 等各类产品。

- Websites like the [Next.js Conf website](https://nextjs.org/conf/registration) and [Vercel’s product pages.](https://vercel.com/ai)  
- 如 [Next.js Conf 官网](https://nextjs.org/conf/registration) 与 [Vercel 产品页面](https://vercel.com/ai) 等网站。

- Product work and docs for Vercel and Next.js.  
- Vercel 与 Next.js 的产品功能开发及配套文档编写。

- Building proof of concepts for branding and marketing.  
- 为品牌建设与市场营销构建概念验证（Proof of Concept）原型。

- Improving the accessibility of all Vercel web properties.  
- 提升所有 Vercel 网站资产的可访问性（Accessibility）。

## Join Vercel  
## 加入 Vercel

Design Engineering at Vercel means more than being a designer and an engineer. It’s about shifting from owning a specific part of the product development process to owning results.

Vercel 的设计工程（Design Engineering）远不止于同时担任设计师与工程师的角色；它意味着从负责产品开发流程中的某个特定环节，转变为对最终成果负责。

Interested? We’re hiring Design Engineers. Apply even if you’ve never had the Design Engineer title. As you’ve read, there’s no correct background or skills for a Design Engineer. [Check out the job posting](https://vercel.com/careers/design-engineer-uk-us-5056771004).

感兴趣吗？我们正在招聘设计工程师（Design Engineers）。即使你从未拥有过“设计工程师”这一头衔，也欢迎申请！正如你所读到的，成为一名设计工程师并无所谓“正确”的背景或技能要求。[查看职位详情](https://vercel.com/careers/design-engineer-uk-us-5056771004)
{% endraw %}
