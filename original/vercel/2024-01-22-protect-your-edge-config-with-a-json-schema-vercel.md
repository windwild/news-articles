---
title: "Protect your Edge Config with a JSON schema - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/protect-your-edge-config-with-a-json-schema"
date: "2024-01-22"
scraped_at: "2026-03-02T09:48:49.672893405+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 22, 2024

![An Edge Config with a JSON schema attached, and the editor displaying a validation error.](images/protect-your-edge-config-with-a-json-schema-vercel/img_001.jpg)![An Edge Config with a JSON schema attached, and the editor displaying a validation error.](images/protect-your-edge-config-with-a-json-schema-vercel/img_002.jpg)

You can now protect your [Edge Config](https://vercel.com/docs/storage/edge-config) with a [JSON schema](https://json-schema.org/). Use schema protection to prevent unexpected updates that may cause bugs or downtime.

Edge Config is a low latency data store accessed from [Vercel Functions](https://vercel.com/docs/concepts/functions/serverless-functions) or [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware). It is ideal for storing experimentation data like feature flags and A/B testing cohorts, as well as configuration data for Middleware routing rules like redirects or blocklists.

To protect an Edge Config with a schema:

- Select the **Storage** tab in the dashboard and then create or select your Edge Config

- Toggle the **Schema** button to open the schema editing tab. Enter your JSON schema into the editor, and Vercel will use the schema to validate your data in real-time

- Click **Save**. This will save changes to both the schema and data


Check out [the documentation](https://vercel.com/docs/storage/edge-config/edge-config-dashboard#schema-validation) to learn more.