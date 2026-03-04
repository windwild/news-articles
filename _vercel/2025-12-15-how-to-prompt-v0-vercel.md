---
render_with_liquid: false
title: "How to prompt v0 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-prompt-v0"
date: "2025-12-15"
scraped_at: "2026-03-02T09:24:06.325149124+00:00"
language: "en-zh"
translated: true
description: "The best v0 prompts include three things. What you're building, who uses it and when, and your design constraints. This guide walks through the framework with side-by-side tests showing faster generat..."
---
render_with_liquid: false
render_with_liquid: false

Dec 15, 2025

2025 年 12 月 15 日

Better prompts = better results, faster

更优的提示词 = 更佳的结果，更快的产出

Working with v0 is like working with a highly skilled teammate who can build anything you need. v0 is more than just a tool, it’s your building partner. And like with any great collaborator, the quality of what you get depends on how clearly you communicate.

与 v0 协作，就像与一位技艺高超的队友合作——它能构建出你所需的任何东西。v0 不仅仅是一个工具，更是你的共建伙伴。正如与任何优秀的协作者共事一样，你最终获得成果的质量，取决于你表达的清晰程度。

The more specific you are, the better v0's output becomes. From our testing, good prompts consistently deliver:

你越具体，v0 的输出就越出色。根据我们的测试，优质的提示词始终能带来以下效果：

- Faster generation time (30-40% faster with less unnecessary code, fewer credits spent)

- 更快的生成速度（代码冗余更少，耗时缩短 30–40%，所用积分更少）

- Smarter UX decisions (v0 understands intent and optimizes accordingly)

- 更智能的用户体验决策（v0 能理解你的意图，并据此优化）

- Cleaner, more maintainable code

- 更简洁、更易维护的代码

This guide shows you a framework that consistently produces these results.

本指南将为你介绍一个可稳定产出上述效果的提示词框架。

## The framework: Three inputs that drive great prompts

## 框架：驱动优质提示词的三大输入

After building hundreds of applications ourselves and learning from v0's power users, we’ve noticed that the best prompts always include three core inputs:

在我们亲自构建了数百个应用、并深入学习 v0 高阶用户经验后，我们发现：最出色的提示词始终包含以下三个核心输入：

1. **Product surface**

1. **产品界面**

2. **Context of use**

2. **使用场景**

3. **Constraints & taste**

3. **约束条件与审美倾向**

Here's the template:

Here's the template:

```markdown
Build [product surface: components, data, actions].



Used by [who],

in [what moment],

to [what decision or outcome].

```

Constraints:

约束条件：

8- platform / device  
8- 平台 / 设备  

9- visual tone  
9- 视觉风格  

10- layout assumptions  
10- 布局假设  

```

Let's break down each input.

让我们逐项拆解每个输入。

## Product surface

## 产品界面

**What specifically are you building?**

**你具体在构建什么？**

List the actual components, features, and data. Not “a dashboard”, but what data it shows, what actions users can take, and what the key sections are.

请列出实际的组件、功能和数据。不要笼统地说“一个仪表盘”，而应说明它展示哪些数据、用户可以执行哪些操作，以及关键区域有哪些。

**Example:**

**示例：**

```markdown
Dashboard displaying: top 5 performers with
```  

```markdown
仪表盘展示内容：表现最佳的前 5 名人员，包括
```

names and revenue, team revenue vs quota

名称与收入，团队收入对比配额

progress bar, deal pipeline with stages

进度条，分阶段的交易销售漏斗

4(Leads → Qualified → Demo → Closed),

4 个阶段（线索 → 已筛选 → 演示 → 已成交）

56-month revenue trend chart.

56 个月收入趋势图。

```

When you’re specific about the product surface, v0 doesn’t waste time inventing features you don’t need or missing ones you do.

当你对产品界面（product surface）的描述足够具体时，v0 就不会浪费时间去设计你并不需要的功能，也不会遗漏你真正需要的功能。

## Context of use

## 使用场景

**Who’s using this, and in what moment?**

**谁在使用该功能？在什么情境下使用？**

Be specific about your users and how they interact with the product in real life. Their role, technical comfort level, time constraints, and environment shape how v0 designs the UX.

请具体说明你的用户群体，以及他们在真实生活中如何与该产品互动。用户的岗位角色、技术熟悉程度、时间限制和使用环境，都将影响 v0 对用户体验（UX）的设计。

Ask yourself:

请自问：

- Who uses this?  

- 谁在使用该功能？

- When do they use it?  
- 他们何时使用它？

- What decision are they trying to make?  
- 他们试图做出什么决策？

- How much time do they have?  
- 他们有多少时间？

**Example:**  
**示例：**

```markdown
Sales managers (non-technical) who check

this during morning standups on desktop

monitors to quickly spot underperformers and

celebrate wins with the team.
```

```markdown
在晨会期间于桌面显示器上查看此内容的销售经理（非技术人员），以便快速识别绩效欠佳者，并与团队共同庆祝成果。
```

v0 optimizes for assumed usage. If you don’t define the context of use, it will guess.  
v0 针对“假设的使用场景”进行优化。如果你未明确定义使用情境，它将自行猜测。

## Constraints & taste  
## 约束条件与审美偏好

**How should it work and look**

**它应该如何工作和呈现**

Constraints tell v0 what not to invent.

约束条件告诉 v0 有哪些内容是不应凭空生成的。

Include:

包括：

- Style preferences

- 风格偏好

- Platform or device assumptions

- 平台或设备假设

- Layout expectations

- 布局预期

- Color systems

- 色彩系统

- Responsiveness or accessibility needs

- 响应式设计或无障碍访问需求


**Example:**

**示例：**

```markdown
Professional but approachable. Use card-based
```

layout with clear hierarchy. Color code: green for  
布局具有清晰的层级结构。颜色编码：绿色表示“按计划进行”，黄色表示“存在风险”，红色表示“低于目标”。

on-track, yellow for at-risk, red for below target.  
按计划进行，黄色表示存在风险，红色表示低于目标。

Desktop-first since they use large monitors. Make  
采用桌面端优先设计，因为他们使用大尺寸显示器。让产品  

it feel like a real SaaS product.  
呈现出真实 SaaS 产品的质感。

```

v0’s defaults are good. Specific constraints make them great while keeping code cleaner.  

v0 的默认配置已相当优秀。而具体约束条件则使其更臻完善，同时保持代码更加简洁。

## Show the difference: Real test results  

## 展现差异：真实测试结果  

I tested this framework by building the same applications with different levels of context. Each test isolates one element to show its impact:  

我通过在不同上下文深度下构建相同的应用程序，对该框架进行了测试。每次测试均聚焦于单一要素，以清晰展现其影响：

### Test 1: The impact of context of use  

### 测试 1：使用场景上下文的影响  

**Without context of use:**  

**未提供使用场景上下文：**  

```markdown  
Build an e-commerce site with product grid, filters, and shopping features.  
```

![](images/how-to-prompt-v0-vercel/img_001.jpg)![](images/how-to-prompt-v0-vercel/img_002.jpg)![](images/how-to-prompt-v0-vercel/img_003.jpg)![](images/how-to-prompt-v0-vercel/img_004.jpg)

**v0 chat:** [**https://v0.link/6vSzuSI**](https://v0.link/6vSzuSI)

**v0 聊天：** [**https://v0.link/6vSzuSI**](https://v0.link/6vSzuSI)

**With context of use:**

**使用场景说明：**

```markdown
Fashion e-commerce site targeting millennials (25-35)

who browse on mobile during commutes. They compare

multiple items quickly before buying. Build a product page

with: swipeable image gallery, product title, price, description,

size/color selectors, add to cart button. Include minimal header

with back button and cart icon. Clean, premium aesthetic.
```

```markdown
面向千禧一代（25–35 岁）的时尚电商网站，

用户主要在通勤途中使用手机浏览，倾向于快速比价后下单。

请构建一个商品详情页，包含：可滑动图片画廊、商品标题、价格、描述、

尺码/颜色选择器、“加入购物车”按钮；页眉需简洁，含返回按钮和购物车图标；

整体风格干净、高端。
```

![](images/how-to-prompt-v0-vercel/img_005.jpg)![](images/how-to-prompt-v0-vercel/img_006.jpg)![](images/how-to-prompt-v0-vercel/img_007.jpg)![](images/how-to-prompt-v0-vercel/img_008.jpg)

**v0 chat:** [**https://v0.link/CcOTmsI**](https://v0.link/CcOTmsI)

**v0 聊天：** [**https://v0.link/CcOTmsI**](https://v0.link/CcOTmsI)

**What changed:**

**发生了哪些变化：**

The version with context took 26 seconds longer but delivered a completely functional product. The version without context had:

启用上下文的版本耗时多出 26 秒，但交付了一个完全可用的产品。而未启用上下文的版本存在以下问题：

- Non-functional search (placeholder only)

- 搜索功能不可用（仅保留占位符）

- Non-functional cart

- 购物车功能不可用

- NOT responsive

- 不具备响应式设计

The version with context had:

启用上下文的版本具备以下特性：

- Fully functional search and cart with quantity controls

- 搜索与购物车功能完整，支持商品数量调节

- 100% mobile responsive

- 100% 移动端响应式适配

- Sophisticated mobile-first design

- 精心设计的移动优先（mobile-first）界面

- Quick view modals and category filters

- 快速查看模态框和分类筛选器


**The real cost:**

**真实成本：**

Without context would have required 1-2 more prompts to add the missing functionality, totaling ~5 minutes and ~1.5 credits. Better context saved multiple iterations.

若缺乏上下文，则需额外 1–2 轮提示才能补全缺失功能，总计耗时约 5 分钟、消耗约 1.5 个积分。更充分的上下文显著减少了迭代次数。


### Test 2: The impact of product surface

### 测试 2：产品界面具体程度的影响

**Vague product surface:**

**模糊的产品界面描述：**

```markdown
Build a user profile page.
```

```markdown
构建一个用户个人资料页面。
```

![](images/how-to-prompt-v0-vercel/img_009.jpg)![](images/how-to-prompt-v0-vercel/img_010.jpg)![](images/how-to-prompt-v0-vercel/img_011.jpg)![](images/how-to-prompt-v0-vercel/img_012.jpg)

**v0 chat:** [**https://v0.link/1Gev1Gi**](https://v0.link/1Gev1Gi)

**v0 聊天记录：** [**https://v0.link/1Gev1Gi**](https://v0.link/1Gev1Gi)

**Specific product surface:**

**具体的产品界面描述：**

```markdown
Build a user profile page showing: profile photo,
```

```markdown
构建一个用户个人资料页面，需展示：头像、
```

display name, username, email, bio, member since

显示名称、用户名、邮箱、个人简介、加入时间

date, activity stats (posts, comments, followers),

日期、活动统计（发帖数、评论数、关注者数）

recent activity feed with timestamps, edit profile

带时间戳的近期动态信息流、“编辑个人资料”按钮

and settings buttons.

以及“设置”按钮。

```

![](images/how-to-prompt-v0-vercel/img_013.jpg)![](images/how-to-prompt-v0-vercel/img_014.jpg)![](images/how-to-prompt-v0-vercel/img_015.jpg)![](images/how-to-prompt-v0-vercel/img_016.jpg)

**v0 chat:** [**https://v0.link/690wE6f**](https://v0.link/690wE6f)

**v0 聊天链接：** [**https://v0.link/690wE6f**](https://v0.link/690wE6f)

**Results:**

**结果：**

- Vague: **1m 38s**, 595 lines, 0.173 credits

- 模糊提示：**1分38秒**，595 行，0.173 积分

- Specific: **1m 19s**, 443 lines, 0.160 credits

- 具体提示：**1分19秒**，443 行，0.160 积分

**19 seconds faster, 152 fewer lines, lower cost.**

**快 19 秒，减少 152 行代码，成本更低。**

模糊的提示迫使 v0 进行猜测。而明确具体的提示则精准生成了我们所需的内容：所有要求的字段均结构清晰，活动统计数据突出醒目，信息架构完全正确。

当产品界面需求明确时，v0 就不会浪费时间去臆造你并不需要的功能，也不会遗漏你真正需要的功能。

### Test 3: 约束条件与设计品位的影响

### 测试 3：约束条件与设计品位的影响

**基础约束条件：**

**基础约束条件：**

```markdown
Build a support ticket dashboard. Shows: open

tickets, response time, agent performance,

recent activity.
```

```markdown
构建一个工单支持看板。需展示：待处理工单数、响应时长、客服人员绩效、近期活动。
```

![](images/how-to-prompt-v0-vercel/img_017.jpg)![](images/how-to-prompt-v0-vercel/img_018.jpg)![](images/how-to-prompt-v0-vercel/img_019.jpg)![](images/how-to-prompt-v0-vercel/img_020.jpg)

**v0 chat:** [**https://v0.link/jrNW2FX**](https://v0.link/jrNW2FX)

**v0 聊天页面：** [**https://v0.link/jrNW2FX**](https://v0.link/jrNW2FX)

**详细约束条件：**  

**详细约束条件：**

Build a support ticket dashboard. Shows: open tickets,

response time, agent performance, recent activity.

构建一个支持工单仪表板。显示：待处理工单、

响应时间、客服人员绩效、近期活动。

Mobile-first design (team leads check this on phones

while on the floor).

移动优先设计（团队主管在办公现场时通过手机查看）。

Light theme, high contrast. Color code: red for urgent

(>24h), yellow for medium, green for on-time. Maximum

83-column layout. Include loading states for real-time data.

浅色主题，高对比度。颜色编码规则：红色表示紧急（>24 小时未响应），黄色表示中等优先级，绿色表示按时处理。最大宽度为 83 列布局。需包含实时数据加载状态。

![](images/how-to-prompt-v0-vercel/img_021.jpg)![](images/how-to-prompt-v0-vercel/img_022.jpg)![](images/how-to-prompt-v0-vercel/img_023.jpg)![](images/how-to-prompt-v0-vercel/img_024.jpg)

**v0 chat:** [**https://v0.link/ZtsFTeb**](https://v0.link/ZtsFTeb)

**Results:**

**结果：**

- Basic: **1m 42s**, 679 lines, 0.133 credits

- 基础版：**1 分 42 秒**，679 行代码，0.133 积分

- Detailed: **1m 52s**, 569 lines, 0.130 credits

- 详细版：**1 分 52 秒**，569 行代码，0.130 积分


**Took 10 seconds longer but generated 110 fewer lines and cost less.**

**耗时多出 10 秒，但生成代码行数减少 110 行，且成本更低。**

The difference: basic version "works on mobile" (desktop layout that shrinks). Detailed version is "mobile-first" (designed from the ground up for mobile, single column expanding to 3 max, intentional color coding with red/yellow/green urgency levels, agent status badges, high contrast for outdoor visibility).

差异在于：基础版“可在移动设备上运行”（即基于桌面端布局、通过缩放适配移动端）；而详细版采用“移动优先”（mobile-first）设计（从底层专为移动端构建：单列布局，最多扩展至三列；采用有意为之的红/黄/绿颜色编码表示紧急程度；添加座席状态徽章；高对比度设计以保障户外可视性）。

v0's defaults are good. Specific constraints make them great while keeping code cleaner.

v0 的默认设置已相当出色。而加入具体约束条件，既能进一步提升输出质量，又能保持代码更简洁清晰。

## Iterating on your generations

## 迭代优化你的生成结果

Once v0 generates your app, you have two main ways to iterate:

当 v0 生成你的应用后，你主要有两种方式进行迭代优化：

**Prompt for changes:** Describe what you want to change, add, or remove. Best for functional changes, adding features, or restructuring layouts.

**通过提示词修改：** 描述你希望更改、添加或删除的内容。最适合功能调整、新增特性或重构页面布局等场景。

**Design Mode:** Click Design Mode, select any element visually, and adjust properties directly. Faster for quick visual changes like colors, spacing, or typography.

**设计模式（Design Mode）：** 点击进入设计模式，通过可视化方式选中任意元素，并直接调整其属性。对于快速修改颜色、间距、字体排印等视觉细节尤为高效。

Use prompts for logic and structure. Use Design Mode for visual tweaks.

使用提示词（prompts）来定义逻辑与结构；使用设计模式（Design Mode）进行视觉微调。

## Quick reference: Prompt template

## 快速参考：提示词模板

Here's the template again, this time with a fully expanded example:

以下再次呈现该模板，并附上一个完整展开的示例：

**Template:**

**模板：**

```markdown
Build [product surface: components, data, actions].



Used by [who],

in [what moment],

to [what decision or outcome].
```

Constraints:

约束条件：

8- platform / device  
8- 平台 / 设备  

9- visual tone  
9- 视觉风格  

10- layout assumptions  
10- 布局假设  

```

**Example:**

```

**示例：**

```markdown
Build a support dashboard showing: open tickets count,

average response time, tickets by priority (high/medium/low),

agent performance list with current workload, recent ticket activity feed.



Used by support team leads (managing 5–10 agents),
构建一个支持团队仪表盘，展示：未关闭工单数量、  
平均响应时间、按优先级（高/中/低）划分的工单分布、  
坐席绩效列表（含当前工作负载）、近期工单活动动态流。  

使用者为支持团队主管（管理 5–10 名坐席）。

on their phones while walking the floor,

员工在巡视现场时，通过手机实时查看。

to prevent agent burnout and maintain response-time SLAs.

以防止坐席过度疲劳，并保障响应时间服务水平协议（SLA）。

Checked every 30 minutes to identify overloaded agents

每30分钟自动检查一次，识别超负荷坐席，

and redistribute work.

并重新分配工作任务。

Constraints:

约束条件：

Mobile-first, light theme, high contrast.

移动优先设计，采用浅色主题与高对比度。

Color code by priority: red for urgent, yellow for medium, green for low.

按优先级进行颜色编码：红色表示紧急，黄色表示中等，绿色表示低优先级。

Show agent status badges (busy/available).

显示坐席状态徽章（忙碌 / 空闲）。

Maximum 2 columns on mobile.

移动端最多显示2列。

[**Ready to build?**  
\\  
Try it yourself.  
Next time you use v0, try being more specific. Add context about who's using your creation. Explain why it needs to exist. Describe how it should work.  
\\  
Start building](https://v0.dev/)

[**准备开始构建了吗？**  
\\  
亲自试一试。  
下次使用 v0 时，尝试更具体地描述需求：说明谁将使用你的创作，解释它为何有必要存在，并描述其预期工作方式。  
\\  
立即开始构建](https://v0.dev/)

### Want to go deeper?

### 想深入了解？

- [v0 Documentation](https://v0.dev/docs) \- Complete guide to all features

- [v0 文档](https://v0.dev/docs) \- 全功能完整指南

- [Design Systems Guide](https://v0.app/docs/design-systems) \- Learn how to create and use design systems

- [设计系统指南](https://v0.app/docs/design-systems) \- 学习如何创建和使用设计系统

- [Project Instructions](https://v0.app/docs/instructions) \- Set up rules that apply to all generations

- [项目指令](https://v0.app/docs/instructions) \- 设置适用于所有生成结果的规则

- [v0 Templates](https://v0.dev/templates) \- Pre-built starting points for common use cases

- [v0 模板](https://v0.dev/templates) \- 针对常见用例预构建的入门起点

- [Community Platform](https://community.vercel.com/c/v0/59) \- Ask for help, share prompt ideas, and chat about AI projects with the community

- [社区平台](https://community.vercel.com/c/v0/59) \- 向社区寻求帮助、分享提示词创意，并就 AI 项目展开交流