---
render_with_liquid: false
title: "Zero-configuration support for NestJS - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-support-for-nestjs"
date: "2025-10-17"
scraped_at: "2026-03-02T09:26:53.170411263+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys NestJS, a framework for building efficient, scalable Node.js server-side applications, with zero configuration."
---
render_with_liquid: false
render_with_liquid: false

Oct 17, 2025

2025年10月17日

![](images/zero-configuration-support-for-nestjs-vercel/img_001.jpg)![](images/zero-configuration-support-for-nestjs-vercel/img_002.jpg)

Vercel now supports [NestJS](https://nestjs.com/) applications, a popular framework for building efficient, scalable [Node.js](https://nodejs.org/) server-side applications, with zero-configuration.

Vercel 现已支持 [NestJS](https://nestjs.com/) 应用——这是一款广受欢迎的框架，用于构建高效、可扩展的 [Node.js](https://nodejs.org/) 服务端应用，且无需任何配置。

src/main.ts

src/main.ts

```typescript
import 'reflect-metadata';

import { Controller, Get, Module } from '@nestjs/common';

import { NestFactory } from '@nestjs/core';



5@Controller()

class AppController {
```

7  @Get()

7  @Get()

8  getHello() {

8  getHello() {

9    return 'Hello, world!';

9    返回 'Hello, world!'；

10  }

10  }

11}

11}

13@Module({

13@Module({

14  controllers: [AppController],

14  controllers: [AppController],

15})

15})

class AppModule {}

class AppModule {}

NestFactory.create(AppModule).then(app => app.listen(3000));


```

A "Hello World" NestJS app on Vercel

在 Vercel 上运行的后端默认使用 [Fluid compute](https://vercel.com/fluid) 及其 [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) 模式。这意味着您的 NestJS 应用将根据流量自动扩缩容，您只需为实际使用的资源付费。

[在 Vercel 上部署 NestJS](https://vercel.com/templates/backend/nestjs-on-vercel) 或访问 [NestJS on Vercel 文档](https://vercel.com/docs/frameworks/backend/nestjs)