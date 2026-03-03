---
title: "Domains now include their `www` counterpart - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/domains-now-include-their-www-counterpart"
date: "2021-04-02"
scraped_at: "2026-03-02T10:04:58.843476571+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Apr 2, 2021

![](images/domains-now-include-their-www-counterpart-vercel/img_001.jpg)

Adding a domain to a project will now also suggest adding its `www` counterpart. This ensures visitors can always access your site, regardless of whether they type `www` when entering the domain, or not.

Using a `www` domain guarantees that the [Vercel Edge Network](https://vercel.com/blog/new-edge-dev-infrastructure#our-new-edge-infrastructure) can reliably and securely route incoming traffic as quickly as possible, so redirecting non-`www` to the `www` domain is recommended. Redirecting the other way works too if you prefer a cleaner URL address.

Existing domains are not affected by this change, but we recommend ensuring that your project already has a `www` redirect in place.

Check out [the documentation](https://vercel.com/docs/custom-domains#redirecting-domains) as well.