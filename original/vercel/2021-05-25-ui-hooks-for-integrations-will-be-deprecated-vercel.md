---
title: "UI Hooks for Integrations will be deprecated - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ui-hooks-for-integrations-will-be-deprecated"
date: "2021-05-25"
scraped_at: "2026-03-02T10:04:56.555684741+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 25, 2021

![](images/ui-hooks-for-integrations-will-be-deprecated-vercel/img_001.jpg)

Since the launch of the [Integration Marketplace](https://vercel.com/integrations), any newly submitted Integration was expected to provide UI Hooks for integrating its UI into the Vercel Dashboard.

As this constraint required a lot of additional work to be done by third-party services that already had their Integration UI available in their own dashboard, UI Hooks will now be deprecated in favor of allowing Integration authors to re-use existing interfaces outside Vercel.

UI Hooks have already become unavailable for newly created Integrations, but they will soon also be removed from all existing Integrations, meaning that:

- Integration UI Hooks will no longer be shown on the Dashboard.

- The respective configuration field will be removed from the Integration Console.

- The API endpoint `/v1/integrations/configuration/:id/metadata` will become unavailable.


These changes will be applied on **August 20th, 2021**, which is the same date as the one that was announced for the [Deprecation of old Integration Webhooks](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure).

Check out [the updated documentation](https://vercel.com/docs/integrations#upgrading-your-integration) to learn more about upgrading your Integration.