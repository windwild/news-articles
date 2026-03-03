---
title: "AWS databases now available on the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/aws-databases-now-available-on-the-vercel-marketplace"
date: "2025-12-17"
scraped_at: "2026-03-02T09:23:40.246774637+00:00"
language: "en"
translated: false
description: "AWS Databases Now Available on the Vercel Marketplace with their AWS Aurora PostgreSQL, Amazon DynamoDB, and Aurora DSQL "
---




Dec 17, 2025

![](images/aws-databases-now-available-on-the-vercel-marketplace-vercel/img_001.jpg)![](images/aws-databases-now-available-on-the-vercel-marketplace-vercel/img_002.jpg)

Today we’re introducing native support for [AWS](https://vercel.com/marketplace/aws) databases including Amazon Aurora PostgreSQL, Amazon Aurora DSQL, and Amazon DynamoDB on the [Vercel Marketplace](https://vercel.com/marketplace/category/database).

This gives developers a direct path to provision and manage scalable, production-ready AWS databases from within the Vercel dashboard with no manual setup required, and:

- **One-click support** for creating a new AWS account, provisioning new AWS databases and linking them to your Vercel projects.

- **Improved developer experience** with simplified region selection, secure credential handling, and unified monitoring of AWS database resources from Vercel.

- **Automatic environment variable** for connection strings and credentials, securely stored within your Vercel project.

- **Free starter plan** for new AWS customers, including **$100 in credits**, with deep links to manage or upgrade plans in the AWS console.

- **And coming soon:** Provision databases into your existing AWS account, attach them to your projects, and access AWS databases directly inside [v0](https://v0.app/).


lib/postgres.ts

```tsx
import { Signer } from "@aws-sdk/rds-signer";

import { awsCredentialsProvider } from "@vercel/functions/oidc";

import { attachDatabasePool } from "@vercel/functions";

import { Pool } from "pg";



const signer = new Signer({

7  hostname: process.env.PGHOST,

8  port: Number(process.env.PGPORT),

9  username: process.env.PGUSER,

10  region: process.env.AWS_REGION,

11  credentials: awsCredentialsProvider({

12    roleArn: process.env.AWS_ROLE_ARN,

13    clientConfig: { region: process.env.AWS_REGION },

14  }),

15});



export const pool = new Pool({

18  host: process.env.PGHOST,

19  user: process.env.PGUSER,

20  database: process.env.PGDATABASE || "postgres",

21  password: () => signer.getAuthToken(),

22  port: Number(process.env.PGPORT),

23  ssl: { rejectUnauthorized: false },

24});

attachDatabasePool(pool);


```

Setup a database client

### **Getting started**

1. Navigate to the [Vercel Marketplace](https://vercel.com/marketplace) and select [**AWS**](https://vercel.com/marketplace/aws)

2. Choose **Create new** account to provision a database

3. Select your database type, region, and plan (including a free starter plan with $100 in credits for new AWS customers) and hit create

4. Connect it to your project. Vercel automatically handles credentials and configuration


You can also try a working example by deploying the [Movie Fetching Database](https://vercel.com/templates/next.js/next-js-vercel-app-with-aurora-postgresql) template to see the integration end-to-end.