---
title: "Introducing new developer tools in the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:29.263585219+00:00"
language: "en-zh"
translated: true
description: "The Vercel Toolbar now includes even more developer tools to simplify collaboration, improve accessibility, and enhance your workflow."
---
{% raw %}

May 23, 2024

2024 年 5 月 23 日

Learn about the new tools for accessibility, interaction timing, and Open Graph images—and the ability to use the toolbar in production.

了解全新的无障碍访问（Accessibility）工具、交互时序（Interaction Timing）工具、Open Graph 图像工具——以及在生产环境中使用 Vercel 工具栏的能力。

Vercel’s Frontend Cloud is all about giving you and your team the tools to prioritize the user experience—so you can focus on what makes your product great and quickly iterate together with your team.

Vercel 前端云的核心目标，是为您提供和您的团队一系列工具，以始终将用户体验置于首位——让您能专注于打造产品核心优势，并与团队高效协同、快速迭代。

This collaboration hasn’t always been easy. Either you’re relying on screenshots or simulated experiences, or it requires separate infrastructure to spin up and maintain complex staging pipelines. It can waste weeks of developer time, and at larger organizations, it can mean spending up to 30% more just on the dev, test, and staging environments.

然而，这种协作并非总是一帆风顺：您可能只能依赖静态截图或模拟体验；又或者，不得不额外搭建并维护一套复杂的预发布（staging）流水线基础设施。这不仅可能浪费开发人员数周时间，在大型组织中，甚至可能导致开发、测试与预发布环境的开销额外增加高达 30%。

Vercel integrates deployments directly into your workflow. Whether you use GitHub, Azure DevOps, or your own CI system, Vercel automates the deployment process. Every change committed results in a [live URL](https://vercel.com/docs/deployments/preview-deployments)—a standalone environment to share with collaborators.

Vercel 将部署能力深度集成至您的工作流中。无论您使用 GitHub、Azure DevOps，还是自建 CI 系统，Vercel 均可自动执行部署流程。每一次代码提交，都会生成一个[实时可访问的 URL](https://vercel.com/docs/deployments/preview-deployments)——即一个独立、隔离的环境，供您与协作者即时共享。

This approach allows for faster iteration, enabling you to ship smaller changes without dependencies across teams or branches. Additionally, it facilitates real-world testing across browsers and interactions, ensuring that you can experience your product exactly as your users would.

这一方式显著加速了迭代节奏，使您能够独立交付更小、更聚焦的变更，无需跨团队或跨分支协调依赖。此外，它还支持在真实浏览器环境及真实用户交互场景下开展测试，确保您所体验的产品，与终端用户所见完全一致。

![The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_001.jpg)![The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_002.jpg)The Vercel Toolbar can be programmed to appear on any of your web pages in any environment.

![Vercel 工具栏可被编程配置，以在任意环境下的任意网页中显示。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_001.jpg)![Vercel 工具栏可被编程配置，以在任意环境下的任意网页中显示。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_002.jpg)Vercel 工具栏可被编程配置，以在任意环境下的任意网页中显示。

Beyond automating CI/CD, the Vercel Toolbar offers a suite of tools designed to enhance collaboration and streamline development. And today, we’re announcing some new additions:

除自动化 CI/CD 流程外，Vercel 工具栏还提供了一整套专为提升协作效率、简化开发流程而设计的工具。今天，我们正式宣布新增以下功能：

- Accessibility tool  
- 无障碍访问（Accessibility）工具  

- Open Graph tool  
- Open Graph 工具

- Interaction timing tool  
- 交互时间工具  

- Toolbar in production extension  
- 生产环境扩展中的工具栏  

## Enhancing developer and user experiences  
## 提升开发者与用户体验  

The Vercel Toolbar is designed to improve collaboration and support your efforts to enhance accessibility and optimize performance. By incorporating it into your workflow, you can prioritize the user experience, iterate quickly, and deliver flawless products.  
Vercel 工具栏旨在提升团队协作效率，并助力您增强网页可访问性、优化性能表现。将其集成至您的开发工作流中，即可将用户体验置于首位，实现快速迭代，并交付无瑕疵的产品。

### Accessibility audits  
### 可访问性审计  

Accessibility is a critical aspect of web development, and Vercel makes it easier than ever to ensure usability and compliance.  
可访问性是网页开发的关键环节，而 Vercel 让保障可用性与合规性变得前所未有的简单。

The Vercel Toolbar automatically checks your deployments against [Web Content Accessibility Guidelines 2.1](https://www.w3.org/TR/WCAG21/) Level A and AA rules, grouping them by impact as defined by [Deque axe](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md#wcag-21-level-a--aa-rules). The accessibility audit reporting provides detailed information about failing elements and their associated rules, and you can turn on recording to track issues as you navigate the page.  
Vercel 工具栏会自动依据 [《Web 内容可访问性指南 2.1》（WCAG 2.1）](https://www.w3.org/TR/WCAG21/) A 级与 AA 级标准，对您的部署进行检测，并按照 [Deque axe](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md#wcag-21-level-a--aa-rules) 所定义的影响程度对问题进行分组。可访问性审计报告将详细列出不合规的页面元素及其对应的规则；您还可开启录制功能，在浏览页面过程中实时追踪问题。

![The accessibility audit tool is available on any page of your website and groups issues by impact.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_003.jpg)![The accessibility audit tool is available on any page of your website and groups issues by impact.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_004.jpg)  
![可访问性审计工具可在您网站的任意页面使用，并按影响程度对问题进行分组。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_003.jpg)![可访问性审计工具可在您网站的任意页面使用，并按影响程度对问题进行分组。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_004.jpg)  
The accessibility audit tool is available on any page of your website and groups issues by impact.  
可访问性审计工具可在您网站的任意页面使用，并按影响程度对问题进行分组。

### Open Graph previews  
### Open Graph 预览  

The OG tool lets you see exactly how your OG cards will look on social platforms like X, Slack, Facebook, and LinkedIn.  
OG 工具让您精准预览 Open Graph 卡片在 X（原 Twitter）、Slack、Facebook 和 LinkedIn 等社交平台上的实际呈现效果。

This tool also provides information on any missing metadata your page needs to generate complete link previews.

该工具还会提示您的网页为生成完整链接预览所缺失的任何元数据。

![The OG tool generates previews of social media link cards for any of your web pages.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_005.jpg)![The OG tool generates previews of social media link cards for any of your web pages.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_006.jpg)The OG tool generates previews of social media link cards for any of your web pages.

![OG 工具可为您的任意网页生成社交媒体链接卡片的预览。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_005.jpg)![OG 工具可为您的任意网页生成社交媒体链接卡片的预览。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_006.jpg)OG 工具可为您的任意网页生成社交媒体链接卡片的预览。

### Interaction timing tool

### 交互时序工具

You can optimize your website's responsiveness and user experience by measuring and improving Interaction to Next Paint (INP). INP observes the latency of all click, tap, and keyboard interactions on a page, and reports on their durations.

您可通过测量并优化“交互到下一次绘制时间”（Interaction to Next Paint，简称 INP）来提升网站响应速度与用户体验。INP 会监测页面上所有点击、触摸及键盘交互的延迟，并报告其持续时长。

A low INP means the page can consistently respond quickly to the vast majority of user interactions. Ensuring your pages respond quickly means providing your users with the best experiences and preventing them from exiting your site early.

较低的 INP 值意味着页面能够持续快速响应绝大多数用户交互。确保页面快速响应，即意味着为用户提供最佳体验，并防止其过早离开您的网站。

![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_007.jpg)![The interaction timing tool allows you to see and optimize your website's responsiveness.](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_008.jpg)The interaction timing tool allows you to see and optimize your website's responsiveness.

![交互时序工具让您直观查看并优化网站响应性能。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_007.jpg)![交互时序工具让您直观查看并优化网站响应性能。](images/introducing-new-developer-tools-in-the-vercel-toolbar-vercel/img_008.jpg)交互时序工具让您直观查看并优化网站响应性能。

### Using the toolbar in production

### 在生产环境中使用工具栏

Lastly, you can really customize your workflows by leveraging the toolbar in production with our new, [zero-config Chrome extension](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost#adding-the-toolbar-using-the-chrome-extension). This means that if you encounter an issue, suggestion, or typo while using your site, you can quickly flag it.

最后，您可通过我们全新推出的[零配置 Chrome 扩展程序](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost#adding-the-toolbar-using-the-chrome-extension)，在生产环境中启用工具栏，从而深度定制工作流。这意味着，当您在使用网站时遇到问题、改进建议或拼写错误，均可快速标记反馈。

Tools like INP, layout shift, accessibility audits, and feature flag overrides can now be evaluated on your live site, providing additional insights. When in production, the toolbar is only visible to team members, making it the perfect internal bug-reporting tool.

诸如 INP、布局偏移（layout shift）、无障碍性审计（accessibility audits）以及功能开关覆盖（feature flag overrides）等工具，如今均可直接在您的线上站点中运行评估，为您带来更深入的洞察。在生产环境中，工具栏仅对团队成员可见，使其成为理想的内部缺陷上报工具。

## The toolbar toolkit keeps growing

## 工具栏工具集持续扩展

These new additions join an already robust set of tooling:

这些新功能加入了一个本已十分完善的工具集：

- [Comments](https://vercel.com/docs/workflow-collaboration/comments): Give feedback directly on deployments with the Vercel Toolbar. Comment on anything from pricing pages to documentation and add screenshots and emojis for context. Then, convert comments into tickets in your tracking system (Linear, Jira, GitHub, or Slack) so you can close the loop quickly.

- [评论功能（Comments）](https://vercel.com/docs/workflow-collaboration/comments)：通过 Vercel Toolbar 直接在部署页面上提供反馈。您可对定价页、文档等任意内容发表评论，并添加截图与表情符号以增强上下文表达。随后，还可将评论一键转换为任务单（Ticket），同步至您的追踪系统（如 Linear、Jira、GitHub 或 Slack），从而快速闭环问题。

- [Content](https://vercel.com/docs/integrations/cms): For teams using Vercel as the head for their headless applications, the toolbar provides a quick link to view and edit content in your CMS. When editable content is detected, a pencil icon appears, allowing you to link directly to that field in your CMS. Plus, you can toggle Draft Mode to preview changes before they go live—perfect for blog posts and landing page updates.

- [内容管理（Content）](https://vercel.com/docs/integrations/cms)：对于将 Vercel 用作无头应用（Headless Application）前端的团队，该工具栏提供快捷入口，助您直接查看和编辑 CMS 中的内容。当检测到可编辑内容时，工具栏将显示铅笔图标，点击即可跳转至 CMS 中对应字段进行修改。此外，您还可启用“草稿模式（Draft Mode）”，在内容上线前预览变更效果——特别适用于博客文章和落地页更新。

- [Layout shift](https://vercel.com/docs/workflow-collaboration/layout-shift-tool): Identify and analyze layout shifts on your page, and get a summary of what caused the shift and how many elements were affected. You can replay and animate these shifts to see them again.

- [布局偏移分析（Layout Shift）](https://vercel.com/docs/workflow-collaboration/layout-shift-tool)：识别并分析页面中的布局偏移（Layout Shift），获取导致偏移的原因摘要及受影响元素数量统计。您还可回放并动态演示这些偏移，以便更直观地复现和排查问题。

- [Quick links](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#using-the-command-menu): Switch between branches on preview and production branches or navigate to other deployments, teams, and projects.

- [快捷链接（Quick Links）](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#using-the-command-menu)：在预览分支与生产分支之间快速切换，或导航至其他部署、团队及项目。

Explore the Vercel Toolbar today and experience truly collaborative iteration in your development. Visit our [documentation](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) to learn more and start enhancing your projects with Vercel's powerful tools. With Vercel, iterating on your product is no longer a separate step—it's a seamless part of your workflow.

今天就体验 Vercel Toolbar，亲身感受真正协作式的开发迭代。访问我们的[文档](https://vercel.com/docs/workflow-collaboration/vercel-toolbar)，深入了解并立即使用 Vercel 强大的工具提升您的项目开发效率。借助 Vercel，产品迭代不再是一个孤立环节——它已无缝融入您的整个工作流。
{% endraw %}
