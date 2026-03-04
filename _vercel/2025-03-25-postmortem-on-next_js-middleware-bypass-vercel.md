---
title: "Postmortem on Next.js Middleware bypass - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/postmortem-on-next-js-middleware-bypass"
date: "2025-03-25"
scraped_at: "2026-03-02T09:35:23.304576198+00:00"
language: "en-zh"
translated: true
description: "Last week, we published CVE-2025-29927 and patched a critical severity vulnerability in Next.js. Here’s our post-incident analysis and next steps."
---
{% raw %}

Mar 25, 2025

2025年3月25日

Last week, we published [CVE-2025-29927](https://github.com/vercel/next.js/security/advisories/GHSA-f82v-jwr5-mffw) and patched a critical severity vulnerability in Next.js. Here’s our post-incident analysis and next steps.

上周，我们发布了 [CVE-2025-29927](https://github.com/vercel/next.js/security/advisories/GHSA-f82v-jwr5-mffw)，并修复了 Next.js 中一个严重级别的漏洞。以下是本次事件的复盘分析及后续措施。

## Timeline

## 时间线

### 2025-02-27

### 2025年2月27日

On `27 Feb 2025 06:03:00 GMT`, the vulnerability was disclosed to the Next.js team through GitHub private reporting. The researchers also emailed [security@vercel.com](mailto:security@vercel.com).

`2025年2月27日 06:03:00 GMT`，该漏洞通过 GitHub 私密报告渠道提交至 Next.js 团队；研究人员同时向 [security@vercel.com](mailto:security@vercel.com) 发送了邮件。

The initial report disclosed the vulnerability in older versions of Next.js (12.x). Due to the old version range, this was given lower priority in our triage queue.

初始报告指出该漏洞存在于较旧版本的 Next.js（12.x）中。由于涉及的是旧版本范围，该报告在我们的漏洞分级队列中被赋予较低优先级。

### 2025-03-01

### 2025年3月1日

An additional email was sent at `01 Mar 2025 02:00:00 GMT` in a new thread, which extended the affected scope to more recent versions.

`2025年3月1日 02:00:00 GMT`，研究人员在新邮件线程中发送了补充邮件，将受影响版本范围扩展至更新的版本。

Due to multiple reports submitted and internal conversations, triaging was delayed.

由于同期收到多份报告并伴随内部讨论，漏洞分级工作被推迟。

### 2025-03-05

### 2025年3月5日

We began investigating the report to understand the validity and potential impact.

我们开始调查该报告，以评估其真实性及潜在影响。

Our security team responded at `05 Mar 2025 10:38:00 GMT` outlining our plans to release an LTS policy ( [now published](https://nextjs.org/support-policy)) which would place Next.js 11.x and 12.x out of support for security patches.

我们的安全团队于 `2025年3月5日 10:38:00 GMT` 做出响应，概述了我们发布长期支持（LTS）策略的计划（[现已发布](https://nextjs.org/support-policy)），该策略将使 Next.js 11.x 和 12.x 版本停止接收安全补丁支持。

### 2025-03-14

### 2025年3月14日

Our security team raised the report to the Next.js team to begin researching impact and remediation options at `14 Mar 2025 17:18:00 GMT`. The Next.js engineering team confirmed the vulnerability as valid.

我们的安全团队于 `2025年3月14日 17:18:00 GMT` 将该报告提交至 Next.js 团队，启动对影响范围及修复方案的研究。Next.js 工程团队确认该漏洞确实存在。

Since Next.js can be hosted in multiple ways, all paths needed to be examined.

由于 Next.js 可通过多种方式托管，因此需全面评估所有部署路径。

1. Static exports were immediately ruled out due to Middleware not being available without a server runtime.

1. 静态导出（static exports）被立即排除，因为中间件（Middleware）在无服务端运行时环境中不可用。

2. We then confirmed self-hosted Next.js applications using `next start` and `output: 'standalone'` were impacted.

2. 我们随后确认，使用 `next start` 并配置 `output: 'standalone'` 自行托管的 Next.js 应用受到该漏洞影响。

3. We then investigated impact on Vercel. The Next.js routing logic is decoupled and runs in a separate system, distributed globally. This made Vercel incidentally invulnerable.

3. 我们接着评估了 Vercel 平台所受影响情况。Next.js 的路由逻辑已解耦，并在独立的、全球分布式系统中运行。这使得 Vercel 平台意外地不受该漏洞影响。

4. Our team then examined open-source Next.js adapters for deploying to other infrastructure platforms. Netlify and Cloudflare Workers were confirmed to never have been affected, for the same decoupling of application routing.

4. 我们的团队随后检查了用于将 Next.js 部署至其他基础设施平台的开源适配器。Netlify 和 Cloudflare Workers 均被确认从未受此漏洞影响，原因同样是应用路由逻辑的解耦设计。

On Friday, we determined the best solution for fixing forward was to add validation when the `x-middleware-subrequest` header was passed—then, filter it out if the validation failed. We also listed a workaround for applications unable to upgrade by filtering out the header before it hit the Next.js server. The team began preparing patches for Next.js 15.x and 14.x.

周五，我们确定面向未来的最佳修复方案是：当接收到 `x-middleware-subrequest` 请求头时，增加校验逻辑；若校验失败，则直接过滤掉该请求头。同时，我们也提供了一种临时缓解措施，供暂无法升级的应用采用——即在请求抵达 Next.js 服务器之前，提前过滤掉该请求头。团队随即着手为 Next.js 15.x 和 14.x 版本准备补丁。

### 2025-03-17

### 2025年3月17日

On Monday, a pull request containing the patch was opened on the Next.js GitHub repository on `17 Mar 2025 17:54:00 GMT`.

周一，包含该补丁的拉取请求于 `2025年3月17日 17:54:00 GMT` 在 Next.js 的 GitHub 仓库中提交。

It was then merged at `17 Mar 2025 20:56:00 GMT`.

随后，该拉取请求于 `2025年3月17日 20:56:00 GMT` 被合并。

A patch was released for Next.js 14.2.25 at `17 Mar 2025 22:44:00 GMT` and Next.js 15.2.3 at `18 Mar 2025 00:23:00 GMT`.

Next.js 14.2.25 的补丁于 `2025年3月17日 22:44:00 GMT` 发布，Next.js 15.2.3 的补丁于 `2025年3月18日 00:23:00 GMT` 发布。

### 2025-03-18

### 2025年3月18日

[CVE-2025-29927](https://github.com/advisories/GHSA-f82v-jwr5-mffw) was issued by GitHub at `18 Mar 2025 18:03:00 GMT`.

GitHub 于 `2025年3月18日 18:03:00 GMT` 发布了 [CVE-2025-29927](https://github.com/advisories/GHSA-f82v-jwr5-mffw)。

### 2025-03-21

### 2025年3月21日

[CVE-2025-29927](https://github.com/advisories/GHSA-f82v-jwr5-mffw) was made public at `21 Mar 2025 10:17:00 GMT`.

[CVE-2025-29927](https://github.com/advisories/GHSA-f82v-jwr5-mffw) 于 `2025年3月21日 10:17:00 GMT` 公开披露。

At this time, the only public details available were on the published CVE, which did not cover enough detail to understand the impact of the issue.

此时，唯一公开的细节仅见于已发布的 CVE 条目，但其内容不够详尽，尚不足以全面理解该问题的影响范围。

While we did verify Netlify and Cloudflare Workers were not impacted, we should have communicated this with their team. Further, we could have done a better job of proactive communication with other infrastructure providers and auth partners.

尽管我们已确认 Netlify 和 Cloudflare Workers 并未受此问题影响，但我们本应就此与相关团队进行沟通。此外，我们也本可在与其他基础设施提供商及身份认证合作伙伴的主动沟通方面做得更好。

### 2025-03-22

### 2025年3月22日

Because the CVE did not state immediately whether Vercel applications were impacted (it was later updated), we quickly published a changelog on Vercel stating customers were protected.

由于该 CVE 最初并未明确说明 Vercel 应用是否受影响（后续才更新），我们迅速在 Vercel 官网发布了一则变更日志，声明客户已受到保护。

The changelog used the same template from our last resolution, which mentioned our Firewall. This was confusing and did not provide appropriate level of detail on the vulnerability itself.

该变更日志沿用了上一次事件解决时所用的模板，其中提到了我们的防火墙（Firewall）。这种做法容易引起混淆，且未就该漏洞本身提供足够详尽的技术说明。

We published a [blog post](https://nextjs.org/blog/cve-2025-29927) on the Next.js site explaining the CVE in preparation for the full postmortem to come later, as well as sharing to official social channels.

我们已在 Next.js 官网发布一篇[博客文章](https://nextjs.org/blog/cve-2025-29927)，对本次 CVE 进行说明，为后续完整的事件复盘报告（postmortem）做准备；同时，我们也通过官方社交媒体渠道同步了该信息。

Later that day, we published a backport for Next.js 13.5.9 at `22 Mar 2025 21:21:00 GMT`. While this is outside of our now published [LTS policy](https://nextjs.org/support-policy), we made an exception based on community feedback.

当天晚些时候，我们于 `2025年3月22日 21:21:00 GMT` 发布了 Next.js 13.5.9 版本的安全补丁（backport）。尽管此举超出了我们当前已公布的 [长期支持（LTS）政策](https://nextjs.org/support-policy)，但我们基于社区反馈作出了例外处理。

### 2025-03-23

### 2025年3月23日

We published an additional backport for Next.js 12.3.5 at `23 Mar 2025 06:44:00 GMT`.

我们于 `2025年3月23日 06:44:00 GMT` 额外发布了 Next.js 12.3.5 版本的安全补丁（backport）。

## **Technical analysis**

## **技术分析**

Middleware allows you to redirect, rewrite, or modify the incoming request before producing a response. Because of this, Middleware runs before caching and routing happens.

中间件（Middleware）允许你在生成响应之前，对传入的请求进行重定向、重写或修改。正因如此，中间件的执行优先级高于缓存与路由机制。

A pattern that some Next.js applications adopt is using middleware to optimistically verify a user's authentication state by checking cookies. If an auth cookie is set, you can early redirect to the logged-in application (or block specific routes). We do not recommend Middleware to be the sole method of protecting routes in your application.

部分 Next.js 应用采用一种常见模式：利用中间件通过检查 Cookie 来“乐观地”验证用户身份认证状态。若检测到认证 Cookie 已设置，即可提前将用户重定向至已登录的应用界面（或阻止访问特定路由）。但我们**不建议仅依赖中间件作为应用中路由保护的唯一手段**。

Next.js uses an internal `x-middleware-subrequest` header to detect and prevent recursion—and bypass the execution of Middleware. Middleware happens separately from the rendering process of a page. Because of the Middleware running in a separate process, we had to leverage an internal header to signal to the routing process that the Middleware had already run when doing a fetch to the app from inside the Middleware.

Next.js 使用一个内部的 `x-middleware-subrequest` 请求头来检测并防止递归调用——从而绕过中间件（Middleware）的执行。中间件的执行与页面渲染过程是相互独立的。由于中间件运行在独立进程中，我们必须借助该内部请求头，向路由系统发出信号：当在中间件内部对应用发起 `fetch` 请求时，中间件已经执行完毕。

[Read more](https://zhero-web-sec.github.io/research-and-things/nextjs-and-the-corrupt-middleware) about the vulnerability details from the reporter.

[点击此处阅读](https://zhero-web-sec.github.io/research-and-things/nextjs-and-the-corrupt-middleware) 报告者提供的该漏洞详细信息。

## Next Steps

## 后续步骤

- **合作伙伴邮件列表：** 为更主动地与依赖 Next.js 及其他基础设施提供商的合作伙伴协作，我们将开通一个专属合作伙伴邮件列表。如需加入，请联系 [`partners@nextjs.org`](mailto:partners@nextjs.org)。

- **简化问题上报流程：** 我们已将 [`security@vercel.com`](mailto:security@vercel.com) 和 [`responsible.disclosure@vercel.com`](mailto:responsible.disclosure@vercel.com) 两个邮箱统一整合，今后 Next.js 的安全漏洞仅通过 GitHub 的私有漏洞报告（Private Vulnerability Reporting）机制接收。此举将帮助我们更高效地对收到的报告进行初步分类与响应。

- **优化响应流程：** 我们正在改进团队应对安全披露的响应机制，并完善 Next.js 漏洞处理的标准化操作手册（run books）。具体包括：如何对来自开源社区（尤其是框架类项目如 Next.js）的安全报告进行分级评估，以及加强安全工程师团队与 Next.js 团队之间的协同工作机制。

- **长期支持（LTS）政策：** 我们已发布 [LTS 政策](https://nextjs.org/support-policy)，明确说明哪些 Next.js 版本当前仍处于活跃维护状态，并会持续接收安全补丁与关键修复。

- **部署适配器（Deployment Adapters）：** 本次漏洞利用了一个未公开文档记录的内部请求头。随着我们与 Netlify、Cloudflare 等合作伙伴共同推进官方部署适配器 API 的开发，我们将确保全面记录相关内部请求头，或以更安全、更规范的 API 取而代之。

- **安全评估：** 我们正进一步开展安全审查，以识别中间件（Middleware）中可能存在的其他安全隐患。后续发现的所有相关问题，均将严格遵循新制定的 CVE 报告与响应流程。

## Acknowledgments

## 致谢

Thank you to security researchers Rachid Allam ( [zhero](https://x.com/zhero___)) and Yassir Alam ( [inzo\_](https://x.com/inzo____)) for responsibly disclosing this issue to our team. These researchers were awarded payouts as part of our bug bounty program.

衷心感谢安全研究员 Rachid Allam（[zhero](https://x.com/zhero___)）和 Yassir Alam（[inzo\_](https://x.com/inzo____)）向我方团队负责任地披露此问题。两位研究员已根据我们的漏洞赏金计划获得相应奖励。
{% endraw %}
