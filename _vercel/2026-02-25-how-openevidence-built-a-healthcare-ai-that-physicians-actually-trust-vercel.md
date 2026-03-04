---
render_with_liquid: false
title: "How OpenEvidence built a healthcare AI that physicians actually trust - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-openevidence-built-a-healthcare-ai-that-physicians-can-trust"
date: "2026-02-25"
scraped_at: "2026-03-02T09:21:23.422479866+00:00"
language: "en-zh"
translated: true
description: "For Chief Strategy and Product Officer Jayme Fishman, the path to modernizing Avalara starts with how it builds."
---
render_with_liquid: false
render_with_liquid: false

Feb 25, 2026

2026年2月25日

Startup speed. Hospital reliability. Zero compromises.

启动速度。医院级可靠性。零妥协。

Andy Yoon was scrolling through Slack when he saw the message: OpenEvidence had gone viral on TikTok.

安迪·尹（Andy Yoon）正在浏览 Slack，突然看到一条消息：OpenEvidence 在 TikTok 上爆火了。

Not "gaining traction.” _Actually_ viral, reaching around two million views in less than a week.

并非“初具势头”——而是真正意义上的病毒式传播，在不到一周时间内获得了约两百万次观看。

This is usually when you rally the troops, spin up emergency capacity, and start making phone calls you really didn't want to make.

通常此时，你得紧急召集团队、快速扩容、并开始拨打那些你本不想打的电话。

Andy, Lead Frontend Engineer, did none of those things.

但身为首席前端工程师的安迪却一件都没做。

Instead, he watched the numbers climb. He checked the logs—everything green. Response times: still fast. Error rates: still near zero. Then he went back to whatever he was doing before, because there was nothing to fix.

他只是静静看着各项数据持续攀升；查看日志——一切正常（全为绿色）；响应时间依然飞快；错误率仍近乎为零。随后，他便回到之前的工作中，因为根本无需修复任何问题。

"Vercel has just completely scaled with that usage," he says. "We've never had it fall over due to capacity or had to provision anything extra. Just being able to trust that it's there, to the point where we don't really even think about it, is amazing."

“Vercel 完全随流量增长实现了自动弹性伸缩，”他说，“我们从未因容量不足而宕机，也从未需要额外配置任何资源。能如此信赖它的存在——信赖到几乎完全无需操心——这简直令人惊叹。”

It was proof that they'd solved a problem most healthcare tech companies haven't figured out yet: how to move at startup speed while meeting hospital-grade reliability standards.

这恰恰印证了他们已成功解决一个大多数医疗科技公司至今尚未攻克的难题：如何在满足医院级可靠性标准的同时，保持初创公司的敏捷与速度。

## **When failure isn't an option**

## **当失败绝非选项**

The stakes are different for companies like OpenEvidence. If their product fails, it could result in someone making a bad medical decision.

对于 OpenEvidence 这样的公司而言，风险截然不同。一旦其产品出现故障，可能导致医生做出错误的医疗决策。

OpenEvidence is the most widely used clinical decision support platform among U.S. clinicians, supporting over 20 million clinical consultations in January 2026. Over 100 million Americans were treated by a doctor using OpenEvidence last year.

OpenEvidence 是目前美国临床医生中使用最广泛的临床决策支持平台，仅在 2026 年 1 月就支撑了逾 2000 万次临床会诊。去年，全美超过 1 亿民众曾由使用 OpenEvidence 的医生提供诊疗服务。

A general-purpose model can afford to be wrong, but a clinical tool cannot. Physicians expect speed, but they also expect stability, clarity, and trust.

通用大模型容许出错，但临床工具绝不允许。医生既要求响应迅速，也要求系统稳定、输出清晰、结果可信。

This pressure sits on top of every technical decision at OpenEvidence: it has to work, every time.

这种压力渗透于 OpenEvidence 每一项技术决策之中：系统必须始终可靠运行，一次都不能失败。

## **A frontend engineer and a team of Python developers**

## **一名前端工程师与一支 Python 开发团队**

When Andy joined OpenEvidence about three years ago, he discovered something that would make most frontend engineers nervous: he was basically the only one.

三年前 Andy 加入 OpenEvidence 时，发现了一件足以令大多数前端工程师紧张的事：他几乎是团队中唯一的前端工程师。

"I was pretty much the only engineer on our team coming from an actual frontend background," he says. "Most of our team works in Python and machine learning."

“我基本上是我们团队中唯一一位真正具备前端开发背景的工程师，”他说，“我们团队的大部分成员都专注于 Python 和机器学习。”

They couldn't afford infrastructure that needed constant babysitting. They needed something that would just work. Deploy code, it goes live. Traffic increases, it scales.

他们无法承担需要持续人工维护的基础设施；他们需要的是开箱即用、稳定可靠的方案：部署代码，立即上线；流量增长，自动扩容。

So OpenEvidence uses a hybrid architecture. The backend is built in Python and runs on Google Cloud Platform. It handles data ingestion, model orchestration, and core business logic, while the frontend is built with Next.js and deployed on ‌Vercel. ‌﻿‌

因此，OpenEvidence 采用混合架构：后端基于 Python 构建，运行于 Google Cloud Platform（GCP），负责数据接入、模型编排及核心业务逻辑；而前端则采用 Next.js 构建，并部署在 Vercel 上。

"Given the makeup of our engineering team, Vercel has really scaled with our frontend so well," Andy notes.

Andy 指出：“考虑到我们工程团队的技术构成，Vercel 确实与我们的前端发展高度契合，扩展性极佳。”

Each commit deploys automatically. Production deploys take five minutes. Preview URLs appear for every branch. For a small team supporting millions of medical consultations daily for almost half of all physicians in the US, it’s been indispensable.

每次提交都会自动部署。生产环境部署耗时五分钟。每个分支均生成可访问的预览 URL。对于一个小型团队而言——该团队每天为美国近一半的医生支持数百万次医疗咨询——这一能力已成为不可或缺的关键基础设施。

## **Prototyping at speed**

## **极速原型开发**

Before OpenEvidence became what it is today, it was dozens of other things first. Each proof of concept was deployed on Vercel as its own project with a custom domain.

在 OpenEvidence 发展成今日形态之前，它曾以数十种不同形态进行过探索。每个概念验证（PoC）均作为独立项目部署在 Vercel 上，并配备专属自定义域名。

Vercel made it simple. Spin up a new project, connect a custom domain, push code, and you have what looks like a production environment. Stakeholders could click around and test workflows.

Vercel 让这一切变得极为简单：新建一个项目、绑定自定义域名、推送代码——转眼间便拥有了一个看似真实的生产环境。相关方可以自由点击浏览、测试完整业务流程。

This ability to spin up projects in minutes helped the team find product-market fit. It also made it easier to win early enterprise partnerships.

这种几分钟内即可启动新项目的敏捷能力，助力团队快速验证并确立产品与市场的契合点（product-market fit），同时也显著提升了早期企业级合作伙伴的签约成功率。

When building out new features, preview deployments give them shareable links for live demos. Changes can be rolled out safely, because they can be reverted instantly if needed.

在开发新功能时，预览部署可为其生成可共享的实时演示链接。所有变更均可安全上线，因为一旦需要，即可瞬时回滚。

## **The 90% surprise**

## **90% 成本骤降之惊喜**

As OpenEvidence scaled to 1000x growth, the lead infrastructure engineer, Micah Smith, kept a close eye on compute costs. When Vercel introduced Fluid compute, it changed how serverless workloads run—combining on-demand execution with server-like efficiency, lower latency, and better performance under load.

随着 OpenEvidence 实现千倍规模增长，首席基础设施工程师 Micah Smith 持续密切关注计算成本。当 Vercel 推出 Fluid Compute（流式计算）时，它彻底改变了无服务器（serverless）工作负载的运行方式——将按需执行能力与类似服务器的高效性、更低延迟以及高负载下的更优性能融为一体。

The team enabled Fluid compute to see what would happen, and their serverless spend dropped by 90%. Same reliability. Faster speed. Fewer cold starts.

团队启用 Fluid Compute 后观察效果，结果其无服务器计算支出骤降 90%。可靠性保持不变，响应速度更快，冷启动次数大幅减少。

### "We reduced our serverless spend by 90% while maintaining the same performance, and even as we've scaled up to 1000x growth, Vercel is less than 5% of our overall infra spend." — _Micah Smith, VP Engineering_

### “我们在维持同等性能的前提下，将无服务器计算支出降低了 90%；即便业务已扩展至原先的 1000 倍，Vercel 在我们整体基础设施支出中所占比例仍不足 5%。” — _Micah Smith，工程副总裁_

The infrastructure is almost invisible, meaning more time spent on product experience and less time debugging tools or provisioning servers.

基础设施几乎“隐形”，意味着团队能将更多时间投入产品体验优化，而减少在调试工具或配置服务器上的耗时。

## **Threading the needle**

## **精准平衡**

"A lot of doctors and medical professionals are used to really outdated software," Andy says.

安迪表示：“许多医生和医疗专业人士长期使用的是非常陈旧的软件。”

He's not wrong. Hospital software often looks like it was designed in the '90s, but those tools are reliable. OpenEvidence has to thread the needle, building a modern solution that upholds the reliability bar.

他所言非虚。医院使用的软件界面往往还停留在上世纪90年代的设计风格，但这些工具却极为可靠。OpenEvidence 必须精准平衡——既要打造现代化的解决方案，又必须坚守医疗级可靠性这一硬性标准。

Their viral moment proved the platform could handle a sudden influx while maintaining hospital-grade reliability.

它曾经历的一次“病毒式传播”高峰，验证了平台在流量激增情况下仍能维持医院级可靠性的能力。

It did.

它确实做到了。

Since launching, OpenEvidence has grown to serve over 40% of physicians in the United States. The frontend team is still small. The infrastructure still just works.

自上线以来，OpenEvidence 已覆盖全美逾40%的执业医师。前端团队规模依然精干，而基础设施始终稳定运行。

_**About OpenEvidence:**_ _OpenEvidence is the fastest-growing clinical decision support platform in the United States, and the most widely used medical search engine among U.S. clinicians. OpenEvidence is trusted by hundreds of thousands of verified healthcare professionals to make high-stakes clinical decisions at the point of care that are sourced, cited, and grounded in peer-reviewed medical literature. Founded with the mission to help doctors save lives and improve patient care, OpenEvidence is actively used daily, on average, by over 40% of physicians in the United States, spanning more than 10,000 hospitals and medical centers nationwide. Learn more at_ [_openevidence.com._](https://openevidence.com./)

_**关于 OpenEvidence：**_ OpenEvidence 是美国增长最快的临床决策支持平台，也是美国临床医生使用最广泛的医学搜索引擎。数十万经认证的医疗专业人士信赖 OpenEvidence，在诊疗一线做出高风险临床决策——所有建议均源自、引用并扎根于同行评议的医学文献。OpenEvidence 创立使命是助力医生挽救生命、改善患者照护；目前，全美平均每天有逾40%的执业医师活跃使用该平台，覆盖全国超过10,000家医院及医疗中心。了解更多，请访问 [_openevidence.com_](https://openevidence.com./)。