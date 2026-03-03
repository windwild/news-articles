---
title: "Enhanced geolocation information for Vercel Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/enhanced-geolocation-information-available-for-vercel-functions"
date: "2022-08-03"
scraped_at: "2026-03-02T10:01:06.401538291+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Aug 3, 2022

2022 年 8 月 3 日

![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_001.jpg)![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_002.jpg)

![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_001.jpg)![](images/enhanced-geolocation-information-for-vercel-functions-vercel/img_002.jpg)

Serverless 函数与 Edge 函数接收到的请求，现会自动添加包含访问者时区信息的请求头：

例如，来自东京的请求现在将附带以下请求头：

```text
X-Vercel-IP-Latitude: 37.7749

X-Vercel-IP-Longitude: -122.4194

X-Vercel-IP-Timezone: Japan
```

```text
X-Vercel-IP-Latitude: 37.7749

X-Vercel-IP-Longitude: -122.4194

X-Vercel-IP-Timezone: Japan
```

该请求头现已对所有计划（包括新部署和已存在的）Vercel Functions 自动启用——无需修改代码或配置。

也可参阅 [相关文档](http://vercel.com/docs/edge-network/headers#request-headers)。