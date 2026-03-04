---
title: "How Vercel enables Wunderman Thompson to launch global brands - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-enables-wunderman-thompson-to-launch-global-brands"
date: "2023-01-17"
scraped_at: "2026-03-02T09:57:03.112372354+00:00"
language: "en-zh"
translated: true
description: "Launching a global brand with Vercel and Wunderman Thompson, unlocking the potential of international brands through strategic, digital-led growth."
---

render_with_liquid: false
Jan 17, 2023

2023年1月17日

[Wunderman Thompson](https://www.wundermanthompson.com/) 通过以战略为引领、以数字技术为驱动的增长路径，释放国际品牌的潜力。随着 Web 技术的快速演进，该机构选择 Vercel 为其动态网站构建统一、可靠的基础架构。

“通常，网站上线时我们很难安心入睡。” Wunderman Thompson 工程与设计总监 Rodrigo Barona 表示，“但现在，这已不是我的事了——而是 Vercel 的事。”

Vercel 通过处理全球分布式、边缘就绪（edge-ready）网络的复杂性，集成主流技术栈，并支持实时页面内协作（live on-page collaboration），使 Wunderman Thompson 能够专注于其最擅长的事：“以文化的节奏疾速前行”。

## 兼容任意技术栈，速度媲美 Turbo

Wunderman Thompson 服务来自全球各地的客户，而这些客户的构想往往已适配于不同的内容管理、电商及数据解决方案。能否快速建站，可能直接决定客户是留存还是流失；而该机构最不愿做的，就是一切从零开始。

Barona 所带领的精干团队将此视为一次契机：将 Vercel 与 [Turborepo](https://turbo.build/repo) 深度结合，实现“需求当日抵达、站点当日上线”的敏捷交付。具体流程如下：

1. Wunderman Thompson 借助单体仓库（monorepo）中的 UI 组件库为网站搭建骨架——该组件库汇集了该机构为各大品牌沉淀的所有设计思路与交互模式。依托 Turborepo，团队可即时向全体开发者共享 UI 组件库，并利用 [远程缓存（remote caching）](https://vercel.com/blog/turborepo-remote-cache-nextjs-publish-times-80-percent)，确保无论单体仓库规模多大，开发周期始终高效迅捷。

2. 在 [Vercel 的集成生态体系（integrations ecosystem）](https://vercel.com/integrations) 内，该机构采用无头架构（headless approach），轻量接入客户自有数据源。初期接入的内容可能仅限 CMS 中的品牌基础要素（如主色调、Logo 和字体），但这一架构自始即具备高度可扩展性，便于后续无缝整合客户全部内容资产。

3. 借助 Vercel 流畅无缝的 [Git 推送工作流（Git push workflow）](https://vercel.com/docs/concepts/git)，团队只需数次点击，即可在数秒内完成线上站点部署。凭借如此极致的速度，他们得以在项目早期便邀请客户深度参与，共同打磨具象化创意方案。此后，网站通常经历三至四轮迭代优化，客户全程体验始终被充分尊重与满足。

4. Vercel 保障代理机构网站的透明度，提供一套专属工具集，以持续观测关键性能指标。[Vercel Analytics](https://vercel.com/docs/concepts/analytics) 为其提供有关网站受众群体与核心性能指标（Core Web Vitals）的深度洞察。此外，他们还将众多钟爱的测试工具集成至与部署功能共处的同一便捷仪表盘中。

> “仅凭无需自行维护任何服务器这一项，Vercel 就已物超所值。而当我们深入平台内部，进一步了解预览环境、Git 提交记录、部署流程等细节……整个体验几乎如魔法般顺畅。”  
> “仅凭无需自行维护任何服务器这一项，Vercel 就已物超所值。而当我们深入平台内部，进一步了解预览环境、Git 提交记录、部署流程等细节……整个体验几乎如魔法般顺畅。”  
>   
> ![](images/how-vercel-enables-wunderman-thompson-to-launch-global-brands-vercel/img_001.jpg)  
>   
> **罗德里戈·巴拉奥纳（Rodrigo Barona）**，Wunderman Thompson

### 面向线上站点的流畅协作

当 Wunderman Thompson 及其客户需要针对眼前正在运行的网站快速迭代时，他们如何清晰、高效地传达反馈意见？

巴拉奥纳表示：“通常情况下，我们会截取网页截图，再通过各种通信平台发送出去。”“Vercel 推出评论功能后，我们立刻感到非常欣喜——我甚至在发布当天就完成了安装，大约是在上线后两小时。”

[Vercel Comments](https://vercel.com/blog/introducing-commenting-on-preview-deployments) 允许您直接在网站预览版本上以可视化方式添加反馈评论。由于这些评论内置于 Vercel 仪表盘之中，因此与您所需的其他所有工具紧密相邻；同时，借助 Vercel 全新推出的[精细化通知中心](https://vercel.com/blog/building-a-powerful-notification-system-for-vercel-with-knock-app)，您还可自主定制接收更新的方式，精准掌控信息流。

巴拉奥纳表示，他们目前已将该功能应用于绝大多数客户项目中。原本耗时一周的反复沟通与修改，如今已大幅缩短为当日即可完成部署。

> “评论功能显著优化了我们的反馈流程：对内，提升了市场团队与设计师之间的协作效率；对外，则强化了与全球客户的协同体验——所有讨论均集中于预览环境（Preview）中进行，再无信息因来回传输截图而遗失或混淆。”  
> “评论功能显著优化了我们的反馈流程：对内，提升了市场团队与设计师之间的协作效率；对外，则强化了与全球客户的协同体验——所有讨论均集中于预览环境（Preview）中进行，再无信息因来回传输截图而遗失或混淆。”  
>   
> ![](images/how-vercel-enables-wunderman-thompson-to-launch-global-brands-vercel/img_001.jpg)  
>   
> **罗德里戈·巴拉奥纳（Rodrigo Barona）**，Wunderman Thompson

### 全球化无服务器架构，零运维负担

试想一下：为一个雄心勃勃的全球性品牌部署其官网——这背后意味着需构建一张覆盖全球的网络基础设施，确保网站能以最优速度触达每一个目标区域。请描绘一下你脑海中从创意构想到系统架构的设计路径。现在，请将这条路径乘以 20。

“We don’t have $10k to develop every website,” says Barona, “but we still continue to develop 15, 20 websites at a time. We offer this only because of Vercel.”

“我们没有每开发一个网站就投入 10,000 美元的预算，”巴拉纳说道，“但我们仍能同时开发 15 到 20 个网站。之所以能做到这一点，全靠 Vercel。”

Wunderman Thompson came to Vercel from the world of Wordpress and PHP deploys. They were used to renting servers and sweating out long build times in hopes that there would be no site-breaking errors.

Wunderman Thompson 原本深耕于 WordPress 和 PHP 部署领域，后转向 Vercel。过去，他们习惯租用服务器，并在漫长的构建过程中提心吊胆，只盼着上线时不会出现导致网站崩溃的错误。

Now, with Vercel, they push their code directly from Github and move to the next task, knowing that if there’s a site-breaking issue, [Vercel Checks](https://vercel.com/docs/integrations/checks-overview) will catch it before the site goes live.

如今，借助 Vercel，他们可直接从 GitHub 推送代码，随即投入下一项任务——因为他们清楚：一旦存在可能导致网站崩溃的问题，[Vercel Checks](https://vercel.com/docs/integrations/checks-overview) 将在网站上线前自动捕获并预警。

> “We can manage and run projects in the Vercel user interface like it’s a normal email or any other platform. This is the feel: new project, connect, choose a project, deploy, domain, check. I don’t need to have any skills, or any CLI concepts, or anything. We can manage and run projects in the Vercel user interface like it’s a normal email or any other platform. This is the feel: new project, connect, choose a project, deploy, domain, check. I don’t need to have any skills, or any CLI concepts, or anything.”
>
> > “我们能在 Vercel 用户界面中像操作普通邮件或任何其他平台一样，轻松管理与运行项目。整个流程直观自然：新建项目 → 关联代码库 → 选择项目 → 部署 → 绑定域名 → 运行检查。我无需掌握任何专业技能，也不必了解命令行（CLI）相关概念，更不需要其他额外知识。我们能在 Vercel 用户界面中像操作普通邮件或任何其他平台一样，轻松管理与运行项目。整个流程直观自然：新建项目 → 关联代码库 → 选择项目 → 部署 → 绑定域名 → 运行检查。我无需掌握任何专业技能，也不必了解命令行（CLI）相关概念，更不需要其他额外知识。”
>
> ![](images/how-vercel-enables-wunderman-thompson-to-launch-global-brands-vercel/img_001.jpg)
>
> **Rodrigo Barona,** Wunderman Thompson
>
> **罗德里戈·巴拉纳（Rodrigo Barona），** Wunderman Thompson

When a client asks how long until the next version of their site is online, Barona says he’s able to tell them, “It’s already up.”

当客户询问下一个版本的网站还需多久才能上线时，巴拉纳总能自信地回答：“它已经上线了。”

[_Launch your brand_](https://vercel.com/contact/sales) _with Vercel today._

[立即使用 Vercel 打造您的品牌](https://vercel.com/contact/sales)