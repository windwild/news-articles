---
title: "MongoDB Atlas is now available on the Vercel Marketplace  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mongodb-atlas-is-now-available-on-the-vercel-marketplace"
date: "2025-09-10"
scraped_at: "2026-03-02T09:28:46.104799185+00:00"
language: "en"
translated: false
description: "MongoDB Atlas is now available on the Vercel Marketplace, enabling developers to provision, manage, and scale fully managed MongoDB databases directly from the Vercel dashboard."
---




Sep 10, 2025

[MongoDB Atlas](https://vercel.com/marketplace/mongodbatlas) is now available on the Vercel Marketplace. Developers can now provision a fully managed MongoDB database directly from your Vercel dashboard and connect it to your project without leaving the platform.

Adding a database to your project typically means managing another account, working through connection setup, and coordinating billing across services. The Vercel Marketplace brings these tools into your existing workflow, so you can focus on building rather than configuring.

![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_001.jpg)![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_002.jpg)

## Ship faster with a unified workflow

Provisioning Atlas through Vercel automatically configures your project's environment variables and integrates billing into your Vercel account. Database setup and management gets handled by MongoDB Atlas while you maintain your existing workflow on Vercel.

> “We’re excited to partner with MongoDB to bring Atlas into the Vercel Marketplace. By combining MongoDB’s flexible data platform with Vercel’s focus on developer experience, we’re giving our joint community a faster path to build and scale intelligent applications on the AI Cloud.We’re excited to partner with MongoDB to bring Atlas into the Vercel Marketplace. By combining MongoDB’s flexible data platform with Vercel’s focus on developer experience, we’re giving our joint community a faster path to build and scale intelligent applications on the AI Cloud.”
>
> ![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_003.png)
>
> **Tom Occhino,** Chief Product Officer at Vercel

**Other key benefits include:**

- **One-click setup:** No separate MongoDB Atlas signup needed. Your Atlas account gets created automatically and linked if you don't already have one

- **Integrated management:** Atlas is managed from your Vercel dashboard with integrated billing and provisioning. Monitor your app and database from one place

- **Flexible, scalable data:** MongoDB Atlas provides a document data model that works with structured or unstructured data, plus horizontal scaling with replica sets and sharding. Choose from free, pre-provisioned, or serverless deployment options

- **Built-in search and AI readiness:** Atlas includes full-text search, vector search, and semantic search for AI applications, giving your Vercel apps advanced querying and AI/ML capabilities out-of-the-box

- **High performance and security:** Low-latency data access with global replicas, plus built-in security features like encryption and access controls


> “Vercel powers many of the best experiences on the web, with an exceptional focus on developer experience from open source to their AI Cloud. We are thrilled to be launching onto the Vercel Marketplace, supercharging our joint community with the power of MongoDB's flexible document model with integrated search and vector search.Vercel powers many of the best experiences on the web, with an exceptional focus on developer experience from open source to their AI Cloud. We are thrilled to be launching onto the Vercel Marketplace, supercharging our joint community with the power of MongoDB's flexible document model with integrated search and vector search.”
>
> ![](images/mongodb-atlas-is-now-available-on-the-vercel-marketplace-vercel/img_004.png)
>
> **Andrew Davidson,** SVP Products at MongoDB

This integration provides a fast, modern data layer to power web and AI applications on Vercel. Once you provision Atlas through the Marketplace, connecting to your database is straightforward:

mongodb.ts

```tsx
import { MongoClient, MongoClientOptions } from 'mongodb';

import { attachDatabasePool } from '@vercel/functions';



const options: MongoClientOptions = {

5  appName: "devrel.vercel.integration",

6  maxIdleTimeMS: 5000

7};

const client = new MongoClient(process.env.MONGODB_URI, options);



10// Attach the client to ensure proper cleanup on function suspension

attachDatabasePool(client);



13// Export a module-scoped MongoClient to ensure the client can be shared across functions.

export default client;
```

The `MONGODB_URI` environment variable gets configured automatically when you provision Atlas through Vercel, so you can start building immediately.

### Get started with MongoDB Atlas on Vercel

[MongoDB Atlas](https://vercel.com/marketplace/mongodbatlas) is available on the Vercel Marketplace for customers on all plans.

Deploy the [MongoDB Atlas Forum template](https://vercel.com/templates/next.js/mongodb-atlas-forum) on Vercel.