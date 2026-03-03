---
title: "Integration Webhooks are now easier to configure - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/integration-webhooks-are-now-easier-to-configure"
date: "2021-04-20"
scraped_at: "2026-03-02T10:04:59.640461088+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 20, 2021

![](images/integration-webhooks-are-now-easier-to-configure-vercel/img_001.jpg)

You can now specify a **generic Webhook URL** in your [Integration](https://vercel.com/docs/integrations) settings. If your Integration relies on Webhooks, it will now be much easier to configure and use them. Each of the following events will be sent as a `POST` request:

- [Deployment Created](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment), [Deployment Ready](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment-ready), and [Deployment Error](https://vercel.com/docs/api#integrations/webhooks/event-payloads/deployment-error) events can be sent for each Project your Integration is installed to.

- [Integration Removed](https://vercel.com/docs/api#integrations/webhooks/event-payloads/integration-configuration-removed) and [Permission Updated](https://vercel.com/docs/api#integrations/webhooks/event-payloads/integration-configuration-permission-updated) events can be sent for each Integration Configuration created by your Integration.

- [Project Created](https://vercel.com/docs/api#integrations/webhooks/event-payloads/project-created) and [Project Removed](https://vercel.com/docs/api#integrations/webhooks/event-payloads/project-removed) events can be sent when an Integration has access to all Projects in a Vercel scope, and a Project was created or removed in that scope.


It's been possible to manually list, create, and delete Webhooks via the Vercel API, but this API is deprecated and will be removed on **August 20th, 2021**.

We no longer support a Delete Hook URL that receives a `DELETE` request when an Integration Configuration was removed. If a Delete Hook URL was set, it is now set as a Webhook URL, and "Integration Removed" is turned on. At the moment, the Integration Removed event is sent as two events (a `POST` request and a `DELETE` request). The `DELETE` requests will no longer be sent starting **August 20th, 2021**.

Check out [the updated documentation](https://vercel.com/docs/integrations#webhooks) and [API reference](https://vercel.com/docs/integrations#webhooks/events) to learn more.