---
title: "Sunsetting UI-Hooks and Legacy Webhooks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sunsetting-ui-hooks-and-legacy-webhooks"
date: "2021-08-20"
scraped_at: "2026-03-02T10:04:23.194316691+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Aug 20, 2021

![](images/sunsetting-ui-hooks-and-legacy-webhooks-vercel/img_001.jpg)

As [previously mentioned](https://vercel.com/changelog/ui-hooks-for-integrations-will-be-deprecated) (on May 25th, 2021) Vercel will be removing UI Hooks for integrations.

UI Hooks have already become unavailable for newly created Integrations, but they will also be removed from all existing Integrations, meaning that:

- Integrations with UI Hooks can't be installed anymore.

- Integration UI Hooks will no longer be shown on the Dashboard.

- The respective configuration field will be removed from the Integration Console.

- The API endpoint

`/v1/integrations/configuration/:id/metadata`

will become unavailable.


Furthermore, we also deprecated the manual webhook creation through our API. See our [previous announcement](https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure) about this change. This means that:

- The API endpoint

`/v1/integrations/webhooks`

will become unavailable.

- The API endpoint

`/v1/integrations/webhooks/:id`

will become unavailable.

- `DELETE`

requests to the configured generic Webhook URL will be not send anymore.


Check the [updated documentation](https://vercel.com/docs/integrations#upgrading-your-integration) to learn more about upgrading your Integration.