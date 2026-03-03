---
title: "Supabase improves their DX with Turborepo - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-supabase-elevated-their-developer-experience-with-turborepo"
date: "2023-01-24"
scraped_at: "2026-03-02T09:56:18.941292678+00:00"
language: "en"
translated: false
description: "Supabase and Turborepo"
---




Jan 24, 2023

[Supabase](https://supabase.com/) is an open-source alternative to Firebase that provides all the backend features you need to ship a project in a weekend. Their growing 60-person development team has been using [Next.js on Vercel](https://vercel.com/solutions/nextjs) from the beginning to quickly ship their documentation, marketing site, and dashboard to thousands users. Yet with a user base that continues to grow, the team is ready to ship even faster.

![Turborepo + Supabase](images/supabase-improves-their-dx-with-turborepo-vercel/img_001.jpg)![Turborepo + Supabase](images/supabase-improves-their-dx-with-turborepo-vercel/img_002.jpg)Turborepo + Supabase

Making changes to their UI has never been easier with [Turborepo](https://turbo.build/repo). Before, something as simple as changing the class name of a UI component required their devs to make updates in the repo, create an npm release, then pull the code back in from npm to finally deploy to production. It was a complex process with too much overhead for such a simple change.

Now, a single developer can make one change in one place in one pull request—lowering the barrier to entry for contributions and dramatically improving their developer experience. The entire Supabase system can be ran locally with one terminal command and Supabase community members can, from outside the core organization, contribute meaningful code that is ready to be deployed to production in one pass.

> “Before Turborepo, making a change to the UI required a careful process and several steps. Now that we’re using Turborepo, our Tailwind, TypeScript, and linting configuration all just magically work in our repo. No one needs to manage it, and it all just works. It's amazing.”Before Turborepo, making a change to the UI required a careful process and several steps. Now that we’re using Turborepo, our Tailwind, TypeScript, and linting configuration all just magically work in our repo. No one needs to manage it, and it all just works. It's amazing.””
>
> ![](images/supabase-improves-their-dx-with-turborepo-vercel/img_003.png)
>
> **Terry Sutton,** Frontend Developer

Supabase’s developers also take advantage of [Vercel Preview Deployments](https://vercel.com/features/previews) with commenting capabilities to enable collaboration with external teams. By sharing a live link and gathering stakeholder feedback via comments, this distributed team of 60 can deliver expert-level work quickly.

As part of a company that deploys hundreds of times per day during peak season, the ability to streamline this process was a game changer for Jonathan and his team.

> “Part of what’s great about Vercel and Next.js is that you can just open a PR, merge, and it’s live.Part of what’s great about Vercel and Next.js is that you can just open a PR, merge, and it’s live.”
>
> ![](images/supabase-improves-their-dx-with-turborepo-vercel/img_004.png)
>
> **Jonathan Summers-Muir,** Frontend Developer

So what’s next for Supabase’s dev team? They’re looking forward to exploring more of what Turborepo has to offer: Remote Caching on Vercel, build time improvements, and more.

**If you’d like to experience how Turborepo and Vercel can improve your own developer experience,** [**get in touch**](https://vercel.com/contact) **.**