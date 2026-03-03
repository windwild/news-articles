---
title: "Zero-configuration Express backends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-express-backends"
date: "2025-09-05"
scraped_at: "2026-03-02T09:29:00.046212008+00:00"
language: "en"
translated: false
description: "Vercel now detects and deploys Express, a fast, unopinionated, minimalist web framework built on web standards, with zero configuration."
---




Sep 5, 2025

![](images/zero-configuration-express-backends-vercel/img_001.jpg)![](images/zero-configuration-express-backends-vercel/img_002.jpg)

Express, a fast, unopinionated, minimalist web framework for [Node.js](https://nodejs.org/en/), is now supported with zero-configuration.

app.ts

```javascript
import express from 'express'

const app = express()



app.get('/', (req, res) => {

5  res.send('Hello World!')

6})



export default app
```

A "Hello World" Express.js app on Vercel

Vercel's [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) now recognizes and deeply understands Express applications. **This update removes the need for redirects in** **`vercel.json`** **or using the** **`/api`** **folder.**

[Deploy Express on Vercel](https://vercel.com/templates/backend/express-js-on-vercel) or [visit the Express on Vercel documentation](https://vercel.com/docs/frameworks/backend/express).