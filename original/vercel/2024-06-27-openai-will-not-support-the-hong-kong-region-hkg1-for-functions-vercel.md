---
title: "OpenAI will not support the Hong Kong region (hkg1) for Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openai-will-not-support-the-hong-kong-region-hkg1-for-functions"
date: "2024-06-27"
scraped_at: "2026-03-02T09:43:37.712248681+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jun 27, 2024

Vercel customers making API requests to OpenAI from Functions in Hong Kong ( [hkg1](https://vercel.com/docs/edge-network/regions#region-list)) may have received an email from OpenAI identifying API traffic from a region that OpenAI does not currently support.

OpenAI will take additional steps to block API traffic from unsupported countries and territories on **July 9**. We understand this block will include Functions in the Hong Kong region on Vercel. While the majority of functions _do not_ execute in this region, Edge Functions may require updates to the execution region.

You can prevent this change affecting your deployments by specifying allowed regions for your functions and [excluding Hong Kong](https://vercel.com/docs/functions/configuring-functions/region#setting-regions-in-your-function). Changing regions requires a redeployment of your application.

Learn more about [OpenAI's supported regions](https://platform.openai.com/docs/supported-countries).