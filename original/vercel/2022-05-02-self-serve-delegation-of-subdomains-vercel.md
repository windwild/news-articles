---
title: "Self-serve delegation of subdomains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/self-serve-delegation-of-subdomains"
date: "2022-05-02"
scraped_at: "2026-03-02T10:02:20.492203423+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 2, 2022

![](images/self-serve-delegation-of-subdomains-vercel/img_001.jpg)![](images/self-serve-delegation-of-subdomains-vercel/img_002.jpg)

If you host multiple subdomains on Vercel throughout separate accounts, you are now able to verify ownership of those subdomains in a self-serve manner via the Vercel Dashboard and API. Adding a subdomain to a project no longer requires the apex domain. Ownership is established via a token that is generated when the subdomain is added to a project and published in the domain owner’s DNS records. This change makes it easier to share domains for Platforms, teams, and collaborators on Vercel.

To learn more check out the [UI docs](https://vercel.com/docs/concepts/projects/custom-domains#verification-challenge) or REST API docs to [add a domain to a project](https://vercel.com/docs/rest-api#endpoints/projects/add-a-domain-to-a-project) and [verify that domain](https://vercel.com/docs/rest-api#endpoints/projects/verify-project-domain) if needed.