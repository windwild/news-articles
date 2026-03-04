---
title: "Protection against React Router and Remix vulnerabilities - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/protection-against-react-router-and-remix-vulnerabilities-cve-2025-43864"
date: "2025-04-26"
scraped_at: "2026-03-02T09:34:57.795875619+00:00"
language: "en-zh"
translated: true
description: "Security researchers reviewing the Remix web framework have discovered two high-severity vulnerabilities in React Router. Vercel proactively deployed mitigation to the Vercel Firewall and Vercel custo..."
---
{% raw %}

Apr 26, 2025

2025年4月26日

Security researchers reviewing the Remix web framework have discovered two high-severity vulnerabilities in React Router. Vercel proactively deployed mitigation to the Vercel Firewall and **Vercel customers are protected**.

安全研究人员在审查 Remix 网络框架时，发现了 React Router 中的两个高危漏洞。Vercel 已主动在 Vercel 防火墙中部署了缓解措施，**Vercel 客户已受到保护**。

[CVE-2025-43864](https://nvd.nist.gov/vuln/detail/CVE-2025-43864) and [CVE-2025-43865](https://nvd.nist.gov/vuln/detail/CVE-2025-43865) enable an external party to modify the response using certain request headers, which can lead to cache poisoning Denial of Service (DoS). CVE 43865 enables vulnerabilities such as stored Cross Site Scripting (XSS).

[CVE-2025-43864](https://nvd.nist.gov/vuln/detail/CVE-2025-43864) 和 [CVE-2025-43865](https://nvd.nist.gov/vuln/detail/CVE-2025-43865) 允许外部攻击者利用特定请求头篡改响应，从而导致缓存污染型拒绝服务（DoS）攻击。CVE-2025-43865 还可引发诸如存储型跨站脚本（XSS）等漏洞。

## Impact and analysis

## 影响范围与分析

When we learned about the vulnerability, we started analyzing the impact to the Vercel platform. Here are our findings and recommendations:

在获悉该漏洞后，我们立即启动了对 Vercel 平台影响范围的分析。以下是我们的发现与建议：

- We were able to reproduce the vulnerability and demonstrate that cache poisoning is trivial, including stored Cross Site Scripting (XSS) injections

- 我们成功复现了该漏洞，并证实缓存污染极易实现，包括注入存储型跨站脚本（XSS）代码。

- The only precondition is that the customer used an impacted version of Remix / React Router (v7.0.0 branch prior to version v7.5.2) and `Cache-Control` headers

- 唯一前提条件是客户使用了受影响版本的 Remix / React Router（v7.0.0 分支、早于 v7.5.2 的版本），且应用中配置了 `Cache-Control` 响应头。

- The impact can extend to any visitor of the application after the cache is poisoned, regardless of authentication state or any other request headers

- 缓存一旦被污染，其影响将波及该应用的所有访问者，无论其身份认证状态或其他任何请求头如何。

- Vercel customers using React Router between v7.0.0 and v7.5.1 were impacted before our Firewall mitigation

- 在我们通过防火墙部署缓解措施之前，使用 React Router v7.0.0 至 v7.5.1 版本的 Vercel 客户均受到影响。

- We have deployed mitigations for attacks by stripping the `X-React-Router-Spa-Mode` and `X-React-Router-Prerender-Data` headers from the request in the Vercel Firewall. New requests are now protected across all deployments on the Vercel platform. We confirmed our mitigation approach with the Remix / React Router team.

- 我们已在 Vercel 防火墙中部署缓解措施：在请求到达应用前，自动移除 `X-React-Router-Spa-Mode` 和 `X-React-Router-Prerender-Data` 请求头。目前，所有部署在 Vercel 平台上的新请求均已受到保护。该缓解方案已获得 Remix / React Router 团队的确认。

- In addition to mitigating future requests, we have preemptively purged CDN response caches on our network out of caution.

- 除了缓解后续请求外，我们出于谨慎考虑，已主动清除了网络中 CDN 的响应缓存。

Both issues have been patched in React Router 7.5.2. We recommend updating to the latest version and redeploying.

上述两个问题已在 React Router 7.5.2 中修复。我们建议升级至最新版本并重新部署。

If you are using additional layers of caching, including Cloudflare or other CDNs, we recommend purging those caches separately. Thank you to [zhero](https://x.com/zhero___) for disclosing the vulnerability.

如果您使用了额外的缓存层（包括 Cloudflare 或其他 CDN），我们建议您单独清除这些缓存。感谢 [zhero](https://x.com/zhero___) 报告该漏洞。
{% endraw %}
