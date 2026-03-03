---
title: "Building a viral application to visualize train routes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-a-viral-application-to-visualize-train-routes"
date: "2022-09-10"
scraped_at: "2026-03-02T10:00:38.089768708+00:00"
language: "en"
translated: false
description: "How Benjamin Td built a viral application called Chronotrains to visualize train routes across Europe."
---




Sep 10, 2022

When inspiration struck [Benjamin Td](https://twitter.com/_benjamintd) to visualize train routes across Europe, he created a Next.js application on Vercel in the moment of inspiration. To his surprise, his project ended up generating over a million views, reaching the top of Hacker News and going viral on Twitter.

## Scale to vacation

Right after launching Chronotrains, Benjamin went on vacation. [It went viral](https://twitter.com/_benjamintd/status/1552983329116504064). And with [Next.js on Vercel](https://vercel.com/solutions/nextjs), he peacefully enjoyed his vacation.

> “I posted Chronotrains and went on vacation. By the time I came back, there were more than a million visits. The site was quoted by politicians and newspapers. It started debates about infrastructure, public policy, green transportation, and rail service quality in many different languages. I never had to think about load or response times.I posted Chronotrains and went on vacation. By the time I came back, there were more than a million visits. The site was quoted by politicians and newspapers. It started debates about infrastructure, public policy, green transportation, and rail service quality in many different languages. I never had to think about load or response times.”
>
> ![](images/building-a-viral-application-to-visualize-train-routes-vercel/img_001.jpg)
>
> **Benjamin Td**

Benjamin’s project was called [Chronotrains](https://www.chronotrains.com/) – an interactive map showing how far you can travel from each station in Europe in less than 5 hours. Benjamin knew he needed an easy way to get a fullstack application online, including support for deploying API Routes that could cache data about the train routes, so he chose Next.js on Vercel.

## How Chronotrains works

Every mouse movement on Chronotrains triggers a network request to get to corresponding geometries for the hovered stations. Using Next.js API Routes deployed as Vercel Functions, Benjamin was able to [easily cache](https://github.com/benjamintd/chronotrains/blob/fe9cca3915b9236a2b3d00989acbb799163bcb58/src/pages/api/stations.ts#L47-L48) the “isochrone” results on Vercel’s Edge Network for optimal response times and to ensure the experience was seamless.

![Visualizing different train route permutations with Chronotrains.](images/building-a-viral-application-to-visualize-train-routes-vercel/img_002.jpg)Visualizing different train route permutations with Chronotrains.

Each of the geometries is pre-computed using scripts that map travel times between different pairings of stations. This builds a graph of all possible journeys between train stations for different durations between one to five hours. The results of these computations are stored in a PostgreSQL database hosted with [Supabase](https://vercel.com/integrations/supabase).

Chronotrains also takes advantage of [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) to help reduce the load on the Postgres database. This helped Chrontrains scale even when there were thousands of visitors viewing the site at the same time. With this architecture, there was at most one request per station per day. Benjamin could make updates to the database peacefully without worrying about scaling the frontend.

> “I’ve been a Vercel user for years and really love the platform. Vercel makes it easy for me to start new projects and scale them with ease. This helps me validate ideas quickly.I’ve been a Vercel user for years and really love the platform. Vercel makes it easy for me to start new projects and scale them with ease. This helps me validate ideas quickly.”
>
> ![](images/building-a-viral-application-to-visualize-train-routes-vercel/img_001.jpg)
>
> **Benjamin Td**

The code for Chronotains is now [open source](https://github.com/benjamintd/chronotrains). [Check out the site](https://www.chronotrains.com/) and [follow Benjamin](https://twitter.com/_benjamintd) for more updates.