---
title: "Zero-configuration support for NestJS - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/zero-configuration-support-for-nestjs"
date: "2025-10-17"
scraped_at: "2026-03-02T09:26:53.170411263+00:00"
language: "en"
translated: false
description: "Vercel now detects and deploys NestJS, a framework for building efficient, scalable Node.js server-side applications, with zero configuration."
---




Oct 17, 2025

![](images/zero-configuration-support-for-nestjs-vercel/img_001.jpg)![](images/zero-configuration-support-for-nestjs-vercel/img_002.jpg)

Vercel now supports [NestJS](https://nestjs.com/) applications, a popular framework for building efficient, scalable [Node.js](https://nodejs.org/) server-side applications, with zero-configuration.

src/main.ts

```typescript
import 'reflect-metadata';

import { Controller, Get, Module } from '@nestjs/common';

import { NestFactory } from '@nestjs/core';



5@Controller()

class AppController {

7  @Get()

8  getHello() {

9    return 'Hello, world!';

10  }

11}



13@Module({

14  controllers: [AppController],

15})

class AppModule {}



NestFactory.create(AppModule).then(app => app.listen(3000));


```

A "Hello World" NestJS app on Vercel

Backends on Vercel use [Fluid compute](https://vercel.com/fluid) with [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute) by default. This means your NestJS app will automatically scale up and down based on traffic, and you only pay for what you use.

[Deploy NestJS on Vercel](https://vercel.com/templates/backend/nestjs-on-vercel) or visit the [NestJS on Vercel documentation](https://vercel.com/docs/frameworks/backend/nestjs)