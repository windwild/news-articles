---
title: "Domains can now be redirected with a custom status code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/domains-can-now-be-redirected-with-a-custom-status-code"
date: "2021-02-18"
scraped_at: "2026-03-02T10:05:25.967772405+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 18, 2021

![](images/domains-can-now-be-redirected-with-a-custom-status-code-vercel/img_001.jpg)

You can now select a temporary or permanent **status code** for [Domain Redirects](https://vercel.com/blog/redirecting-domains).

There are some subtle differences between these [status codes](https://developer.mozilla.org/en-US/docs/Web/HTTP/Redirections):

- **307 Temporary Redirect:** Not cached by client, method and body never changed.

- **302 Found:** Not cached by client, method may or may not be changed to GET.

- **308 Permanent Redirect:** Cached by client, method and body never changed.

- **301 Moved Permanently:** Cached by client, method may or may not be changed to GET.


We recommend using status code 307 or 308 to avoid the ambiguity of non-GET methods, which is necessary when your application needs to redirect a public API.

Check out [the documentation](https://vercel.com/docs/custom-domains#redirecting-domains) as well.