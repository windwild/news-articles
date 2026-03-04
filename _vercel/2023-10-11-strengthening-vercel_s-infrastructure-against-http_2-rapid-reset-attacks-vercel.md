---
title: "Strengthening Vercel's Infrastructure against HTTP/2 Rapid Reset Attacks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/strengthening-vercels-infrastructure-against-http-2-rapid-reset-attacks"
date: "2023-10-11"
scraped_at: "2026-03-02T09:50:14.704682107+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Oct 11, 2023

2023 年 10 月 11 日

At Vercel, we consistently monitor and update our security protocols to address emerging threats. A new vulnerability, known as the HTTP/2 Rapid Reset Attack ( [CVE-2023-44487](https://www.cve.org/CVERecord?id=CVE-2023-44487)), has the potential to disrupt HTTP/2-enabled web servers.

在 Vercel，我们持续监控并更新安全协议，以应对新出现的威胁。一种名为“HTTP/2 快速重置攻击”（[CVE-2023-44487](https://www.cve.org/CVERecord?id=CVE-2023-44487)）的新漏洞，可能干扰启用 HTTP/2 的 Web 服务器。

Rapid Reset is a vulnerability possible in the HTTP/2 protocol involving quickly initiating and canceling streams. It can be used to launch large denial-of-service attacks, negatively affecting performance and availability.

“快速重置”是 HTTP/2 协议中可能存在的一种漏洞，其原理是快速建立并取消大量流（streams）。该漏洞可被用于发起大规模拒绝服务（DoS）攻击，从而严重影响系统性能与可用性。

We've taken proactive steps to refine our infrastructure and strengthen our defenses. Our improved system can now more efficiently handle the HTTP/2 Rapid Reset Attack.

我们已采取主动措施，优化基础设施并强化防御能力。升级后的系统现已能更高效地抵御 HTTP/2 快速重置攻击。

An essential component of our defense strategy is inline network traffic monitoring, where we identify malicious TCP connections and terminate them. Limiting abuse over a single connection has enabled Vercel to protect against HTTP/2 Rapid Reset Attack.

我们防御策略的关键一环是内联网络流量监控（inline network traffic monitoring）：实时识别恶意 TCP 连接并立即终止。通过限制单个连接内的滥用行为，Vercel 已成功实现对 HTTP/2 快速重置攻击的有效防护。

Combining our existing system with new improvements, all applications on Vercel are even further resistant to the HTTP/2 Rapid Reset Attack.

将现有系统与新增改进措施相结合后，部署在 Vercel 上的所有应用对 HTTP/2 快速重置攻击具备更强的抵御能力。

We want to assure you that your web assets are protected against the HTTP/2 Rapid Reset Attack. We're committed to consistently improving our security measures in response to new threats to ensure safety and reliability for all users.

我们谨向您保证：您的 Web 资产已受到针对 HTTP/2 快速重置攻击的有效保护。我们将持续响应新型安全威胁，不断优化安全机制，全力保障所有用户的安全性与可靠性。
{% endraw %}
