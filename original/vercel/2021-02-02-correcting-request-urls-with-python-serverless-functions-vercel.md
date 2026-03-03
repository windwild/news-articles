---
title: "Correcting Request URLs with Python Serverless Functions - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/correcting-request-urls-with-python-serverless-functions"
date: "2021-02-02"
scraped_at: "2026-03-02T10:06:02.412322793+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 2, 2021

![](images/correcting-request-urls-with-python-serverless-functions-vercel/img_001.jpg)

At the moment, the URLs of incoming requests to Python Serverless Functions deployed on Vercel are decoded automatically.

Because this behavior is not consistent with a "standalone" Python server, Vercel will stop decoding them for newly created Serverless Functions starting **March 2nd, 2021**. Existing Deployments will not be affected.

As an example, take a look at the Python Serverless Function code shown above and imagine that the URL of the incoming request ends in `/hi%21`:

- With the incorrect behavior, `self.path` will be set to `/hi!`.

- With the updated correct behavior, `self.path` will be set to `/hi%21`, which matches the behavior of the built-in `HTTPServer` class in Python.


To try out this change, define a `FORCE_RUNTIME_TAG` Environment Variable for your project, set it to `canary` and create a new Deployment.