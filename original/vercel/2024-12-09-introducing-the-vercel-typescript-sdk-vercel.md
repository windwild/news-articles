---
title: "Introducing the Vercel TypeScript SDK - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-vercel-typescript-sdk"
date: "2024-12-09"
scraped_at: "2026-03-02T09:38:46.830802469+00:00"
language: "en"
translated: false
description: "A new type-safe SDK for working with the Vercel REST API."
---




Dec 9, 2024

We’ve published a TypeScript-native SDK for working with the Vercel API.

Terminal

```bash
npm i @vercel/sdk
```

This SDK includes:

- Full type safety for accessing the Vercel REST API with Zod schemas

- New documentation for every function, argument, and type

- Better tree-shaking support with optional standalone functions

- Intuitive error handling and detailed error messages

- Configurable retry strategies (including backoffs)


```tsx
import { Vercel } from '@vercel/sdk';



const vercel = new Vercel({

4  bearerToken: process.env.VERCEL_TOKEN,

5});



const result = await vercel.deployments.getDeployment({

8  idOrUrl: 'dpl_89qyp1cskzkLrVicDaZoDbjyHuDJ'

9});
```

This SDK can be used to automate every part of Vercel’s platform including:

- Deployment automation and management

- Project creation and configuration

- Domain management

- Team and user administration

- Environment variable management

- Logs and monitoring

- Integration configuration


[View the docs](https://vercel.com/docs/rest-api/sdk) or [explore the repo](https://github.com/vercel/sdk).