---
title: "Devolver ships game websites 73% faster with Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/devolver-ships-game-websites-73-faster-with-vercel"
date: "2024-08-21"
scraped_at: "2026-03-02T09:41:42.955129214+00:00"
language: "en-zh"
translated: true
description: "How Devolver ships game websites 73% faster with built-in CI/CD, zero-configuration integrations, Preview URLs on each pull request, and more."
---
&#123;% raw %}

Aug 21, 2024

2024年8月21日

无忧部署、更快反馈，以及更多提升工作流效率的功能。

作为多款知名独立游戏的发行商，Devolver 团队的工作从不匮乏。但作为一个规模较小的工程团队，他们却受限于笨重的基础设施——花在系统管理上的时间远超实际所需。迁移到 Vercel 后，Devolver 团队将系统管理与配置所花费的时间减少了超过一半，**使游戏官网的上线速度提升了 73%**。采用 Vercel 不久后，该团队甚至在一场仅持续 30 分钟的新闻发布会上，毫无差错地同步上线了五个网站。

_**“我们的网站始终稳定运行。我们再也不用‘随时待命’来应对突发问题；也无需为流量激增提前规划。Vercel 就是我们的云运维（CloudOps）团队，而我们将精力全部投入在开发炫酷的彩蛋功能上。” —— Devolver 网页开发工程师 Eli Penner**_

网页开发工程师 Eli Penner 与互动内容总监 Vieko Franetovic 一直以来都坚持极简主义的创意与建站流程：先形成一个想法，随即着手构建原型。整个过程轻松随意——而这恰恰正是他们能快速搭建网站的关键所在。

遗憾的是，此前所用的部署方案极不稳定：热门游戏官网时常因流量激增而崩溃；错误提示会毫无征兆地突然弹出；有时回退到旧版网站进行更新时，竟又发现此前并不存在的新错误。从耗时冗长的初始配置，到 CI 流程中繁复的前置规划，他们根本无法按需规模化地创建理想中的网站。

为优化工作流，Devolver 团队全面迁移至 Vercel。

- **无忧部署：** 借助零配置的 [集成](https://vercel.com/integrations) 和内置 CI/CD 功能，Devolver 不再需要自行管理基础设施，从而得以以前所未有的速度，将创意迅速转化为上线的游戏官网。

- **更快反馈：** 每次 Pull Request 均自动生成 [预览 URL](https://vercel.com/features/previews)，使 Devolver 团队能够高频迭代，并即时与团队成员共享进展，显著缩短反馈周期。

- **可靠的本地测试：** 无需每次测试 API 路由都重新部署，Vercel CLI 让 Devolver 团队可在本地精准模拟生产环境，轻松验证各项变更。

- **Reliable support:** Even when problems arise, the Devolver team can submit a ticket and get a Vercel support team member to troubleshoot in minutes.  
- **可靠的支持：** 即便出现问题，Devolver 团队也能提交工单，并在几分钟内获得 Vercel 支持团队成员的故障排查协助。

Their first project on Vercel was a revamped [Enter the Gungeon](https://enterthegungeon.com/) website, and they haven’t looked back. They no longer have to spend time looking up error codes, triaging broken sites, or worrying about infrastructure. Now they can focus on what they love: Playing games and working on their websites.  
他们在 Vercel 上的第一个项目是全面重构的 [《挺进地牢》（Enter the Gungeon）](https://enterthegungeon.com/) 官网，自此便一往无前。他们再也不必耗费时间查阅错误代码、排查网站故障，或为基础设施问题而担忧。如今，他们得以专注于真正热爱的事情：玩游戏，以及打造自己的网站。

With all this growth and time and frustration saved, they’re even looking to expand their team to a fourth engineer. If you want to move faster and have a more streamlined frontend workflow like Devolver, [reach out to learn more about Vercel can help](https://vercel.com/contact).  
得益于这一系列增长，以及节省下来的时间与精力，他们甚至正计划将工程团队扩充至第四位工程师。如果你也希望能像 Devolver 一样加速交付、拥有更高效的前端工作流，[欢迎联系我们，进一步了解 Vercel 如何助你成功](https://vercel.com/contact)。
&#123;% endraw %}
