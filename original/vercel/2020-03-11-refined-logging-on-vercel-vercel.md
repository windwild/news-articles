---
title: "Refined Logging on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/refined-logging"
date: "2020-03-11"
scraped_at: "2026-03-02T10:07:03.701989414+00:00"
language: "en"
translated: false
description: "The refined UI for Build and Serverless Function logs makes consuming logs a pleasure."
---




Mar 11, 2020

With the launch of [Log Drains](https://zeit.co/blog/log-drains), we made it easy to pipe the invocation logs of your Serverless Functions or Static Files to a log inspection tool like [LogDNA](https://zeit.co/integrations/logdna) or [Datadog](https://zeit.co/integrations/datadog-logs).

Handing off this piece of your production workflow to a service dedicated to this purpose allowed us to tighten our focus around what we do best: Plug-and-play realtime logs.

## Better Build Logs

When creating a new Deployment, you are always presented with detailed logs showcasing how your source code is getting built. Today, we are introducing a new look for them:

![Inspecting the Build Logs of a Deployment.](images/refined-logging-on-vercel-vercel/img_001.jpg)Inspecting the Build Logs of a Deployment.

## Better Serverless Function Logs

If you want to inspect the logs of your Serverless Functions in a detailed manner, we recommend installing one of our [Log Drain integrations](https://zeit.co/integrations?category=logging).

Should you only want to take a quick glance at your Real-time Requests, the refined "Functions" tab will make that process very pleasant:

![Inspecting the Realtime Requests of a Deployment.](images/refined-logging-on-vercel-vercel/img_002.jpg)Inspecting the Realtime Requests of a Deployment.

The same also goes for errors, which are especially important:

![Inspecting the Errors of a Deployment.](images/refined-logging-on-vercel-vercel/img_003.jpg)Inspecting the Errors of a Deployment.

## Conclusion

With the help of the refined Build and Serverless Functions Logs, understanding how your Deployment behaves while building or in production is now possible at a glance.

For more complex needs, such as storing logs, we recommend installing a [Log Drain integration](https://zeit.co/integrations?category=logging).

[Let us know what you think](https://zeit.co/contact) about this change.