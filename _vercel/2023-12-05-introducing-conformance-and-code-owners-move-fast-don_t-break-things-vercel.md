---
title: "Introducing Conformance and Code Owners: Move fast, don't break things - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-conformance"
date: "2023-12-05"
scraped_at: "2026-03-02T09:49:34.190018520+00:00"
language: "en-zh"
translated: true
description: "Conformance and Code Owners are now available"
---

render_with_liquid: false
Dec 5, 2023

2023 年 12 月 5 日

Learn about powerful new features on Vercel's Developer Experience Platform to help scale code health, performance, and security.

了解 Vercel 开发者体验平台（Developer Experience Platform）上一系列功能强大的新特性，助力您规模化提升代码健康度、性能与安全性。

As organizations grow, it can become hard to sustain fast release cycles without diminishing code health and letting errors slip into production. It shouldn't be this way. We should be able to move fast _without_ breaking things—making quick updates and innovating while retaining great performance, security, and accessibility.

随着组织规模扩大，若想持续保持快速发布节奏，同时不损害代码健康度、避免错误流入生产环境，将变得愈发困难。这本不该如此。我们理应能够“**快速迭代，而不破坏系统**”——在高效完成更新与创新的同时，依然保障卓越的性能、安全性和可访问性。

Today, we're releasing new features to Vercel's [Developer Experience Platform](https://vercel.com/products/dx-platform) to help [Enterprise teams](https://vercel.com/enterprise) ship higher quality code, with the same velocity even as teams and codebases scale.

今天，我们面向 Vercel 的 [开发者体验平台](https://vercel.com/products/dx-platform) 推出多项新功能，助力 [企业团队](https://vercel.com/enterprise) 在团队规模与代码库持续扩张的情况下，仍以同等速度交付更高质量的代码。

- [**Conformance**](https://vercel.com/docs/workflow-collaboration/conformance) **:** Automate detection of critical issues early in the development lifecycle and prevent them from reaching production.

- [**合规性检查（Conformance）**](https://vercel.com/docs/workflow-collaboration/conformance) **：** 在开发生命周期早期自动识别关键问题，并阻止其进入生产环境。

- [**Code Owners**](https://vercel.com/docs/workflow-collaboration/code-owners) **:** Find who is responsible for the code and make sure that code changes are reviewed by the right people, every time.

- [**代码负责人（Code Owners）**](https://vercel.com/docs/workflow-collaboration/code-owners) **：** 快速定位代码责任人，确保每次代码变更均由恰当的人员进行评审。

- [**A reimagined dashboard experience**](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview) **:** A workspace to surface code health insights, help with cross-team collaboration, and ensure a better onboarding experience for new team members.

- [**全面重构的仪表板体验**](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview) **：** 一个集中呈现代码健康度洞察、促进跨团队协作，并为新成员提供更优入职体验的工作空间。

## **Conformance: Out-of-the-box static analysis**

## **合规性检查（Conformance）：开箱即用的静态分析**

Our Conformance tooling runs [static analysis checks](https://vercel.com/docs/workflow-collaboration/conformance/rules) over your codebase to find critical issues before merging—allowing you to move quickly without compromising quality. It automatically checks for issues that may result in performance, security, or quality problems in your production applications.

Vercel 的合规性检查（Conformance）工具会对您的代码库执行 [静态分析检查](https://vercel.com/docs/workflow-collaboration/conformance/rules)，在代码合并前即识别关键问题——让您在不牺牲质量的前提下加速交付。该工具自动检测可能引发生产环境中性能、安全或质量隐患的问题。

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_001.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_002.jpg)

[**Contact us to get started**  
**立即联系我们，开启使用之旅**

Get in touch to learn how these powerful new features on Vercel's Developer Experience Platform can help your Enterprise team scale code health, performance, and security.  
欢迎联系，了解 Vercel 开发者体验平台（Developer Experience Platform）这些强大新功能，如何助力您的企业团队全面提升代码健康度、性能与安全性。

Contact Us  
联系我们](https://vercel.com/contact/sales)

Conformance rules span multiple files, instead of verifying each file individually, providing a holistic perspective on your codebase. It also adds frontend specific context to issues, classifies and tags issues, as well as assigns a severity with granular ownership of both rules and rule violation exceptions.  
合规性规则（Conformance rules）跨越多个文件进行检查，而非逐个文件单独验证，从而为您提供对整个代码库的全局视角。它还为问题注入前端专属上下文，对问题进行分类与打标，并为每个问题分配严重级别；同时支持对规则本身及规则违规例外情形进行细粒度的所有权管理。

By providing a high-level score and tracking issues in the dashboard, you get a barometer for assessing accumulated technical debt. Much like a performance budget, this score becomes invaluable in understanding when and where to prioritize tasks. Specifically, you can [allowlist a specific number of issues](https://vercel.com/docs/workflow-collaboration/conformance/allowlist) before going to production, then track how you start unlisting them and burning down through the issues to improve code health.  
通过提供高层级综合评分并在仪表板中持续追踪问题，您可获得评估技术债务累积程度的“晴雨表”。这一评分的作用，就如同性能预算（performance budget）一样，在判断任务优先级的时间点与具体场景时极具价值。例如，您可在上线生产环境前，[将特定数量的问题加入白名单（allowlist）](https://vercel.com/docs/workflow-collaboration/conformance/allowlist)，随后持续跟踪这些白名单条目被逐步移除的过程，逐项解决现存问题，切实提升代码健康度。

> “Conformance helped us uncover a lot of small issues that were adding up to impact our performance in a big way. After addressing just the first few, we saw more than 200ms improvement in performance for all of our pages.”  
> “Conformance 帮助我们发现了大量看似微小、却在累积后严重影响性能的问题。仅修复了其中最靠前的几个问题，我们所有页面的性能便提升了超过 200 毫秒。”

> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)  
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)

> **Daniel Brown,** Senior Frontend Engineer at Upstart  
> **Daniel Brown**，Upstart 高级前端工程师

Conformance was built by the creators of [Next.js](https://vercel.com/solutions/nextjs) and [Turborepo](https://turbo.build/repo). By codifying decades of their combined experience crafting high performant web sites and deep knowledge of the framework ecosystem, we're able to go _beyond_ catching errors, towards actually optimizing your application.  
Conformance 由 [Next.js](https://vercel.com/solutions/nextjs) 和 [Turborepo](https://turbo.build/repo) 的创始团队打造。我们将数十年来构建高性能网站的实战经验，以及对框架生态系统的深刻理解，全部沉淀为可执行的规则体系——这使 Conformance 不再止步于“捕获错误”，而是真正迈向“优化应用”。

You can run Conformance within your CI/CD systems or locally to:  
您可在 CI/CD 系统中或本地运行 Conformance，实现以下目标：

- **Next.js:** Use guardrails crafted by the inventors of Next.js to catch common issues that can happen in Next.js applications. For example, detect when `getServerSideProps` is not needed, as there's no use of the context parameter and it could be static generated.  
  **Next.js：** 借助 Next.js 创始人设计的防护机制，识别 Next.js 应用中常见问题。例如，当 `getServerSideProps` 未使用 `context` 参数、完全可替换为静态生成（Static Generation）时，自动检测并提示该函数冗余。

- **Performance:** Catch issues that negatively affect the performance of your website. For example, prevent blocking serial asynchronous calls in your applications.  
  **性能：** 发现损害网站性能的问题。例如，阻止应用程序中出现阻塞式的串行异步调用（blocking serial asynchronous calls）。

- **Code health:** Set general rules that can prevent things from negatively affecting your codebase or code health. For example, require that a workspace package that uses TypeScript files has configured TypeScript correctly for that workspace.  
  **代码健康度：** 设定通用规则，防范可能损害代码库质量或整体健康度的问题。例如，要求任何使用 TypeScript 文件的工作区（workspace）包，必须为其正确配置 TypeScript 编译选项。

- **Security:** Act as a first layer of threat detection for security vulnerabilities. For example, require that important security headers are set correctly for Next.js apps and contain valid directives.  
  **安全：** 作为安全漏洞威胁检测的第一道防线。例如，强制要求 Next.js 应用正确设置关键安全响应头（security headers），且其指令内容合法有效。

> “What we love most about Conformance is the global feedback, as it provides us with a global overview about our code health and it is able to monitor issues that are not pointed out by ESLint. It’s a huge time saver.”  
> “我们最喜爱 Conformance 的一点在于其全局反馈能力——它为我们提供了代码健康状况的全局视图，并能监测 ESLint 未能识别的问题。这极大地节省了时间。”

> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_004.png)  
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_004.png)

> **Stéphane Lavaud,** Frontend Web Development Manager at Origins Digital  
> **Stéphane Lavaud**，Origins Digital 前端网页开发经理

### Accelerate innovation, reduce time spent on bugs  
### 加速创新，减少在缺陷修复上耗费的时间  

Deploying bad code has an outsized impact on a team's velocity.  
部署有缺陷的代码会对团队交付速度造成不成比例的严重影响。

Debugging alone can take away a year's worth of valuable developer time. Conformance strategically places guardrails to redirect brainpower towards creation, rather than time-consuming error detection. By proactively resolving potential issues, Conformance frees developers from unnecessary dependencies, leading to increased productivity and allowing them to channel their efforts into the projects and features that will improve end-customer experiences.  
仅调试工作就可能消耗掉开发者一整年的宝贵时间。Conformance 通过战略性地设置防护机制，将开发者的精力从耗时的错误检测转向创造性工作。通过主动解决潜在问题，Conformance 帮助开发者摆脱不必要的依赖，从而提升整体生产力，使其能够将精力集中于真正改善终端用户体验的项目与功能开发上。

> “Our team had been hesitant to use Remote Caching because early testing showed high bandwidth usage. Conformance helped us uncover easy improvements that made Remote Caching viable for us. We're now saving more than 45 days of CI team work every week with 71% task cache hits.”  
> “此前，我们的团队因早期测试显示远程缓存（Remote Caching）带宽占用过高而对其持观望态度。Conformance 帮助我们发现了若干易于实施的优化点，使远程缓存方案变得切实可行。如今，我们每周可节省超过 45 人日的 CI 团队工作量，任务缓存命中率高达 71%。”

> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)  
> ![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_003.jpg)

> **Daniel Brown,** Senior Frontend Engineer at Upstart  
> **Daniel Brown**，Upstart 高级前端工程师

## **Code Owners: Framework-defined ownership**  
## **代码负责人（Code Owners）：由框架定义的所有权机制**

As your company grows, you need a code ownership system that grows with you.  
随着公司规模扩大，您需要一套能同步演进的代码所有权管理体系。

Code Owners works with your [Git integration](https://vercel.com/docs/deployments/git#), ensuring code reviews with smart reviewer assignments, and an escalation protocol that ensures appropriate individuals review your code and escalate concerns when needed.  
Code Owners 与您的 [Git 集成](https://vercel.com/docs/deployments/git#) 深度协同，实现智能评审人分配，确保代码由合适人员审阅；同时提供升级机制，在必要时将问题及时上报给相关责任人。

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_006.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_007.jpg)  
![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_006.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_007.jpg)

Code Owners mirrors the structure of your organization. This means Code Owners who are higher up in the directory tree act as broader stewards over the codebase and are the fallback if owners files go out of date, such as when developers switch teams. And, with [Modifiers](https://vercel.com/docs/workflow-collaboration/code-owners#modifiers) your organization can tailor your code review process. For example, you can assign reviews in a round-robin style, based on who's on call, or to the whole team.  
Code Owners 映射您组织的实际架构。这意味着目录树中层级更高的 Code Owners 将承担更广泛的代码库守护职责；当 `OWNERS` 文件过期（例如开发者调岗）时，他们亦可作为兜底评审人。此外，借助 [修饰符（Modifiers）](https://vercel.com/docs/workflow-collaboration/code-owners#modifiers)，您的组织还可灵活定制代码评审流程——例如采用轮值制（round-robin）、按值班人员分配，或指派给整个团队。

### **All while elevating application security**

### **在全面提升应用安全性的前提下**

Security remains at the forefront of every feature we release. Creating security rules with Conformance and Code Owners brings your security team into the development process. Conformance catches issues that could become security vulnerabilities, [like unsafe usage of cookies in your application](https://vercel.com/docs/workflow-collaboration/conformance/rules), before they make it to production. Similarly, Code Owners ensures no one on your team becomes a security vulnerability.

我们发布的每一项功能，安全性始终处于首要位置。借助 Conformance 和 Code Owners 创建安全规则，可将您的安全团队深度融入开发流程。Conformance 能在问题进入生产环境前及时识别潜在安全风险——例如[应用程序中对 Cookie 的不安全使用](https://vercel.com/docs/workflow-collaboration/conformance/rules)；而 Code Owners 则确保团队中没有任何成员因权限或流程疏漏而成为新的安全薄弱点。

Using the features together, you can define an allowlist file for Security rules, and then assign your Security team as code owner of that file. So whenever someone tries to add something new to the list, the Security teams needs to approve it.

将这两项功能协同使用，您可以为安全规则定义一个白名单文件，并指定您的安全团队作为该文件的代码负责人（code owner）。这样一来，每当有人尝试向白名单中新增条目时，都必须经过安全团队的审批。

## **A reimagined dashboard experience for monorepos**

## **面向单体仓库（monorepo）的全新仪表盘体验**

When you start using Conformance, you'll also see a [redesigned dashboard](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview) within [vercel.com](http://vercel.com/) that gives developers and leadership team members an overall view of project health. At a glance, any team member can see global code health, Conformance scores, and the teams responsible for those repositories. This means, you can understand problem areas and investigate errors by seeing all of your allowlisted performance, security, or code-quality errors.

启用 Conformance 后，您还将在 [vercel.com](http://vercel.com/) 中看到一个[全新设计的仪表盘](https://vercel.com/docs/workflow-collaboration/conformance/dashboard-overview)，为开发者及管理层提供项目整体健康状况的全局视图。团队成员只需一眼即可掌握全量代码健康度、Conformance 评分，以及各代码仓库对应的责任团队。这意味着，您可通过集中查看所有已白名单化的性能、安全或代码质量类错误，快速定位问题区域并开展根因分析。

![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_008.jpg)![](images/introducing-conformance-and-code-owners-move-fast-don_t-break-things-vercel/img_009.jpg)

## **Move fast, don’t break things**

## **快速迭代，稳如磐石**

[Conformance](https://vercel.com/docs/workflow-collaboration/conformance) and [Code Owners](https://vercel.com/docs/workflow-collaboration/code-owners) are a major step forward in providing developers with the tools and resources they need to build better, more efficient applications.

[Conformance](https://vercel.com/docs/workflow-collaboration/conformance) 与 [Code Owners](https://vercel.com/docs/workflow-collaboration/code-owners) 是我们为开发者赋能的重要里程碑，为其提供了构建更优质、更高效应用所必需的工具与资源。

Today, Conformance and Code Owners are Generally Available on Vercel for Enterprise teams.

即日起，Conformance 与 Code Owners 已正式面向 Vercel 企业版客户全面开放（Generally Available）。

[**Upgrade your workflow today**\\
\\
Reach out to learn more about how you can improve your frontend workflow and empower your team to ship better web experiences with Vercel.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**立即升级您的工作流**\\
\\
联系我们，深入了解如何优化您的前端工作流，并借助 Vercel 赋能团队，交付更卓越的 Web 体验。\\
\\
联系销售](https://vercel.com/contact/sales)