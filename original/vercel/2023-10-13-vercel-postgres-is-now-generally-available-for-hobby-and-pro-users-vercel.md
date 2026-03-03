---
title: "Vercel Postgres is now generally available for Hobby and Pro users - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-postgres-is-now-available-for-pro-users"
date: "2023-10-13"
scraped_at: "2026-03-02T09:49:58.688234291+00:00"
language: "en"
translated: false
description: "Changelog for (now deprecated) Vercel postgres, our serverless SQL database, general availability for hobby and pro users"
---




Oct 13, 2023

![](images/vercel-postgres-is-now-generally-available-for-hobby-and-pro-users-vercel/img_001.jpg)![](images/vercel-postgres-is-now-generally-available-for-hobby-and-pro-users-vercel/img_002.jpg)

The Vercel KV and Vercel Postgres products have been sunset. You can now deploy alternative storage solutions for [KV](https://vercel.com/marketplace?search=kv) and [Postgres](https://vercel.com/marketplace?search=postgres) through the [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage), with automatic account provisioning and unified billing.

[Vercel Postgres](https://vercel.com/docs/storage/vercel-postgres/quickstart), our serverless SQL database, is now available for Hobby and Pro users.

During the beta period, we reduced cold start times to 100-200ms and fixed several bugs around handling connections. Usage prices have also been **lowered from the beta**:

- Total storage:

**reduced 60% from $0.30/GB to $0.12/GB**

- Written data:

**reduced 4% from $0.10/GB to $0.096/GB**

- Data transfer: **reduced 55% from $0.20/GB to $0.09/GB**


**Billing will begin on October 19th** and Pro users have the following usage included:

- 1 database then $1.00 USD per additional database

- 100 hours of compute time per month then $0.10 USD per additional compute-hour

- 512 MB total storage then $0.12 USD per additional GB

- 512 MB written data per month then $0.096 USD per additional GB

- 512 MB data transfer per month then $0.09 USD per additional GB


If you were a beta participant and want to opt out of using Vercel Postgres, you can backup your database and [delete it](https://vercel.com/docs/storage/vercel-postgres/usage-and-pricing#managing-charges).

[Check out the documentation](https://vercel.com/docs/storage/vercel-postgres) to learn more.