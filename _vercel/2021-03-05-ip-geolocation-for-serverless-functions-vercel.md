---
title: "IP Geolocation for Serverless Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ip-geolocation-for-serverless-functions"
date: "2021-03-05"
scraped_at: "2026-03-02T10:05:56.173580617+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Mar 5, 2021

2021 年 3 月 5 日

![with cercel → vercel](images/ip-geolocation-for-serverless-functions-vercel/img_001.jpg)

![with cercel → vercel](images/ip-geolocation-for-serverless-functions-vercel/img_001.jpg)

[专业版（Pro）和企业版（Enterprise）团队](https://vercel.com/pricing) 所部署的 Serverless Functions 接收到的请求，现在会自动附带包含访问者地理位置信息的请求头：

- `X-Vercel-IP-Country` —— 发起请求的 IP 地址所属国家的两位字母国家代码。

- `X-Vercel-IP-Country-Region` —— 与该 IP 地址关联的 [ISO 3166-2](https://en.wikipedia.org/wiki/ISO_3166-2) 行政区划编码。

- `X-Vercel-IP-City` —— 与该 IP 地址关联的城市名称。

例如，来自东京的请求现在将自动携带以下请求头：

```text
X-Vercel-IP-Country: JP

X-Vercel-IP-Country-Region: 13

X-Vercel-IP-City: Tokyo
```

```text
X-Vercel-IP-Country: JP

X-Vercel-IP-Country-Region: 13

X-Vercel-IP-City: Tokyo
```

This feature is now automatically activated for all new and existing Serverless Functions on [Pro and Enterprise Teams](https://vercel.com/pricing) — no code or configuration change needed.

该功能现已自动为所有新旧 Serverless Functions 启用，适用于 [Pro 和 Enterprise 团队](https://vercel.com/pricing)，无需修改任何代码或配置。

Check out [the documentation](http://vercel.com/docs/edge-network/headers#request-headers) as well.

也请参阅 [相关文档](http://vercel.com/docs/edge-network/headers#request-headers)。
&#123;% endraw %}
