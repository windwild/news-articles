---
title: "Introducing the Vercel Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-vercel-marketplace"
date: "2024-08-28"
scraped_at: "2026-03-02T09:41:51.869862299+00:00"
language: "en"
translated: false
description: "The Vercel Marketplace adds support for EdgeDB, Redis, and Supabase with unified billing and simpler installations."
---




Aug 28, 2024

Our first version of the Vercel Marketplace with support for three new database options.

Last year, we added [storage solutions](https://vercel.com/blog/vercel-storage) to our platform, introducing our first-party Blob and Edge Config, as well as partner solutions like Postgres by Neon and KV by Upstash. We heard your feedback—you want more providers and different types of integrations.

Today, we’re launching the first version of the Vercel Marketplace. It supports storage solutions from [Supabase](https://vercel.com/marketplace/supabase), [Redis](https://vercel.com/marketplace/redis-cloud), and [EdgeDB](https://vercel.com/marketplace/edgedb), at the same price as going direct. These integrations come with features like integrated billing, direct connections to provider consoles, and more.

## One platform, many products

Managing multiple logins, setup configurations, and billing systems can be a hassle. The Vercel Marketplace helps you find and integrate services that work well with your Vercel projects.

You can log into provider dashboards without needing separate logins, making access easier. Managing your subscriptions and billing is straightforward since it’s all handled directly in the Vercel dashboard. Plus, you can explore pricing options and free plans that can grow with your projects.

![](images/introducing-the-vercel-marketplace-vercel/img_001.jpg)![](images/introducing-the-vercel-marketplace-vercel/img_002.jpg)

## Focusing on flexible and reliable storage first

We're starting with storage integrations given how important databases are for building applications. These storage solutions are available on Hobby, Pro, and Enterprise plans through a self-service flow. Our initial integrations include:

- **Supabase:** A leading provider of developer-first Postgres databases, offering auth, real-time, and vector services with a focus on performance and reliability.

- **Redis:** Ideal for creating fast, dynamic apps that can scale effortlessly, such as AI agents, chatbots, and personalization engines, while ensuring your data is always accessible and fast.

- **EdgeDB:** A modern relational database based on Postgres, featuring a high-level object data model, integrated migrations engine, high-performance query language, and more.


![](images/introducing-the-vercel-marketplace-vercel/img_003.jpg)![](images/introducing-the-vercel-marketplace-vercel/img_004.jpg)

## What’s next for Vercel Postgres and Vercel KV?

Since launching last year, Vercel Postgres (powered by Neon) and Vercel KV (powered by Upstash) have become trusted by hundreds of thousands of developers.

Our partner teams at Neon and Upstash have been actively improving their platforms and introducing new features. Starting in November, we’ll begin automatically migrating all Vercel Postgres and Vercel KV stores to the marketplace to get access to these features.

- **Vercel Postgres** will transition to **Neon**, providing enhanced scalability, flexibility, and features.

- **Vercel KV** will transition to **Upstash**, a serverless Redis solution known for its cost efficiency and high performance.


Until November, you can continue using them as usual, and new projects will be migrated later.

These transitions will happen with no downtime and no work needed on your part. After the migration, you’ll have full access to the Neon and Upstash feature sets, and you’ll manage new stores through their Marketplace integrations. Pricing and limits will match what you’d get by going direct to Neon and Upstash.

## How to get started

The Vercel Marketplace, featuring Supabase, Redis, and EdgeDB is live today. You can explore the integrations at [vercel.com/marketplace](https://vercel.com/marketplace), where detailed documentation will help you get started quickly.

We'll be adding more integrations to the Marketplace based on your feedback. Our goal is to build a simple, convenient place to get access to the best developer tools in the ecosystem.

If you're a service provider interested in joining the Marketplace, feel free to reach out to us at integrations@vercel.com.