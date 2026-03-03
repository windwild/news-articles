---
title: "Manage your Vercel Functions CPU and memory in the dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard"
date: "2024-03-11"
scraped_at: "2026-03-02T09:46:26.093035184+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Mar 11, 2024

![](images/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard-vercel/img_001.jpg)![](images/manage-your-vercel-functions-cpu-and-memory-in-the-dashboard-vercel/img_002.jpg)

You can now configure Function CPU from the project settings page, where you can change your project’s default memory, and by extension CPU. Previously, this could only be changed in `vercel.json`.

The memory configuration of a function determines how much memory and CPU the function can use while executing. This new UI makes it more clear increasing memory boosts vCPU, which can result in better performance, depending on workload type.

Existing workloads (that have not modified `vercel.json`) are using the cost-effective basic option. Increasing function CPU increases the cost for the same duration, but may result in a faster function. This faster function may make the change net-neutral (or a price decrease in some cases).

[Check out the documentation](https://vercel.com/docs/functions/configuring-functions/memory) to learn more.