---
title: "OpenAI will not support the Hong Kong region (hkg1) for Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-will-not-support-the-hong-kong-region-hkg1-for-functions"
date: "2024-06-27"
scraped_at: "2026-03-02T09:43:37.712248681+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jun 27, 2024

2024 年 6 月 27 日

从香港（[hkg1](https://vercel.com/docs/edge-network/regions#region-list)）地区的 Vercel Functions 向 OpenAI 发起 API 请求的 Vercel 客户，可能已收到 OpenAI 发来的邮件，指出其检测到的 API 流量来自 OpenAI 当前尚未支持的地区。

OpenAI 将于 **7 月 9 日** 进一步采取措施，屏蔽来自不支持国家及地区的 API 流量。我们了解到，此次屏蔽将涵盖 Vercel 香港地区（Hong Kong region）的 Functions。尽管绝大多数 Functions _并不会_ 在该地区执行，但 Edge Functions 可能需要更新其执行区域设置。

您可通过为 Functions 明确指定允许的执行区域，并[排除香港](https://vercel.com/docs/functions/configuring-functions/region#setting-regions-in-your-function)，来避免此次变更影响您的部署。更改执行区域需重新部署您的应用。

了解更多关于 [OpenAI 支持的地区](https://platform.openai.com/docs/supported-countries)。
{% endraw %}
