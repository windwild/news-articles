---
title: "Bot Protection is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bot-protection-is-now-in-public-beta"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:20.739713576+00:00"
language: "en-zh"
translated: true
description: "Vercel's Bot Protection managed ruleset allows users to mitigate unwanted bot activity on their projects in a single click"
---
{% raw %}

Apr 23, 2025

2025 年 4 月 23 日

![](images/bot-protection-is-now-in-public-beta-vercel/img_001.jpg)![](images/bot-protection-is-now-in-public-beta-vercel/img_002.jpg)

Vercel Web Application Firewall 现已新增一项 [Bot Protection 托管规则集](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset)，面向所有用户开放 [公测（Public Beta）](https://vercel.com/docs/release-phases#public-beta)。

Bot Protection 可帮助减少来自非浏览器来源的自动化流量，并支持您根据以下两种操作方式进行响应：

- **仅记录操作（Log Only Action）：** 在“防火墙”（Firewall）标签页中记录识别出的机器人流量，但不拦截请求；  
- **质询操作（Challenge Action）：** 向来自非浏览器来源的流量提供 [浏览器质询（browser challenge）](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge)。[已验证机器人（Verified bots）](https://vercel.com/docs/bot-protection#verified-bots) 将被自动排除在外。

为避免干扰尚未被“已验证机器人”覆盖的合法自动化流量，您可使用“绕过（bypass）”操作，通过配置 [自定义 WAF 规则（custom WAF rules）](https://vercel.com/docs/vercel-waf/custom-rules) 对特定请求进行放行。

我们建议您先启用“仅记录”操作，观察实际流量情况，再启用质询操作。

启用该规则集的操作步骤如下：

1. 在您的 [项目仪表板（project dashboard）](https://vercel.com/docs/projects/project-dashboard) 中，进入 [防火墙（Firewall）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) 标签页，点击 **Configure（配置）**

2. Under **Bot Management**, navigate to **Bot Protection**

2. 在 **机器人管理（Bot Management）** 下，导航至 **机器人防护（Bot Protection）**

3. Select **Log** or **Challenge**

3. 选择 **记录（Log）** 或 **挑战（Challenge）**

4. Select **Review Changes** and review the changes to be applied

4. 点击 **查看变更（Review Changes）**，并检查待应用的变更内容

5. Select **Publish** to apply the changes to your production deployment

5. 点击 **发布（Publish）**，将变更应用到您的生产环境部署中

Bot Protection complements Vercel's existing mitigations, which already block common threats like DDoS attacks, low quality traffic, and spoofed traffic. It adds an extra layer of protection for any automated traffic that is not clearly malicious.

机器人防护（Bot Protection）是对 Vercel 现有防护措施的有力补充——Vercel 已能有效拦截常见的网络威胁，例如 DDoS 攻击、低质量流量和伪造流量。该功能进一步为那些并非明显恶意、但属于自动化性质的流量提供额外一层防护。

During this public beta period, we’ve set up a [thread](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174) on the Vercel Community where you can share your feedback, feature requests, and experiences with Bot Protection.

在本次公开测试（public beta）期间，我们已在 Vercel 社区设立了一个[讨论帖](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174)，欢迎您分享对机器人防护（Bot Protection）的使用反馈、功能建议及实际体验。

Learn more about the [Bot Protection managed ruleset](https://vercel.com/docs/vercel-waf/managed-rulesets) and the [Vercel Firewall.](https://vercel.com/docs/vercel-firewall)

了解更多关于 [机器人防护（Bot Protection）托管规则集（managed ruleset）](https://vercel.com/docs/vercel-waf/managed-rulesets) 和 [Vercel 防火墙（Vercel Firewall）](https://vercel.com/docs/vercel-firewall) 的信息。

Edit: During the beta period, we renamed the Bot Filter managed ruleset to Bot Protection

编辑说明：在测试期间，我们将原“机器人过滤器（Bot Filter）托管规则集”更名为“机器人防护（Bot Protection）”。
{% endraw %}
