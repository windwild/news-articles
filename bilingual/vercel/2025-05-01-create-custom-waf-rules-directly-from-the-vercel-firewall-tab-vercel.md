---
title: "Create custom WAF rules directly from the Vercel Firewall tab - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/create-custom-waf-rules-directly-from-the-vercel-firewall-tab"
date: "2025-05-01"
scraped_at: "2026-03-02T09:34:14.246039419+00:00"
language: "en-zh"
translated: true
description: "Vercel customers can now create custom WAF rules directly from the chart displayed on the Firewall tab of the Vercel dashboard."
---

May 1, 2025

2025年5月1日

![](images/create-custom-waf-rules-directly-from-the-vercel-firewall-tab-vercel/img_001.jpg)![](images/create-custom-waf-rules-directly-from-the-vercel-firewall-tab-vercel/img_002.jpg)

You can now create [custom WAF rules](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules) directly from the chart displayed on the Firewall tab of the Vercel dashboard.

您现在可以直接从 Vercel 控制台“防火墙”（Firewall）标签页中显示的图表创建[自定义 WAF 规则](https://vercel.com/docs/vercel-firewall/vercel-waf/custom-rules)。

When viewing your traffic grouped by a parameter (like IP address, user agent, or request path), you can now select "Create Custom Rule" within the actions menu of any displayed time series. This automatically generates an editable draft of the custom WAF rule that matches the selected parameter.

当您按某一参数（例如 IP 地址、用户代理 User Agent 或请求路径）对流量进行分组查看时，现在可在任意显示的时间序列的操作菜单中选择“创建自定义规则”（Create Custom Rule）。系统将自动生成一条与所选参数匹配的、可编辑的自定义 WAF 规则草稿。

Once the WAF rule is saved and published, it's immediately propagated across our global network.

该 WAF 规则一旦保存并发布，便会立即同步至我们的全球网络。

This feature is available to all users across all plans at no additional cost.

此功能面向所有计划的所有用户免费提供，无需额外付费。

Learn more about the [Vercel Firewall](https://vercel.com/docs/vercel-firewall).

了解更多关于[Vercel 防火墙](https://vercel.com/docs/vercel-firewall)的信息。