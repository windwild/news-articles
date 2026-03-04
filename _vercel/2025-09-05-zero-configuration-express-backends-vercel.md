---
title: "Zero-configuration Express backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-express-backends"
date: "2025-09-05"
scraped_at: "2026-03-02T09:29:00.046212008+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys Express, a fast, unopinionated, minimalist web framework built on web standards, with zero configuration."
---
{% raw %}

Sep 5, 2025

2025 年 9 月 5 日

![](images/zero-configuration-express-backends-vercel/img_001.jpg)![](images/zero-configuration-express-backends-vercel/img_002.jpg)

Express 是一个快速、无约定、极简的 [Node.js](https://nodejs.org/en/) Web 框架，现已支持零配置部署。

app.ts

```javascript
import express from 'express'

const app = express()



app.get('/', (req, res) => {

5  res.send('Hello World!')

6})
```

```js
export default app
```

```js
export default app
```

A "Hello World" Express.js app on Vercel

在 Vercel 上运行的 “Hello World” Express.js 应用

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands Express applications. **This update removes the need for redirects in** **`vercel.json`** **or using the** **`/api`** **folder.**

Vercel 的 [框架定义基础设施（Framework-Defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure) 现已能够识别并深度理解 Express 应用。**此次更新消除了在** **`vercel.json`** **中配置重定向，或必须将代码置于** **`/api`** **目录下的需求。**

[Deploy Express on Vercel](https://vercel.com/templates/backend/express-js-on-vercel) or [visit the Express on Vercel documentation](https://vercel.com/docs/frameworks/backend/express).

[在 Vercel 上部署 Express](https://vercel.com/templates/backend/express-js-on-vercel)，或 [查阅 Vercel 上的 Express 文档](https://vercel.com/docs/frameworks/backend/express)。
{% endraw %}
