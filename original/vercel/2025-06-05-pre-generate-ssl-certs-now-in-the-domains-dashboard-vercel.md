---
title: "Pre-generate SSL certs, now in the Domains dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/pre-generate-domain-ssl-certs-now-in-dashboard"
date: "2025-06-05"
scraped_at: "2026-03-02T09:32:43.052323949+00:00"
language: "en"
translated: false
description: "The Domains Dashboard now enables zero-downtime migration by allowing SSL certificates to be pre-provisioned before migrating domains."
---




Jun 5, 2025

You can now pre-generate SSL certificates directly from the Vercel Domains dashboard, enabling zero-downtime domain migrations without using the CLI.

After adding an existing domain to your project, select Pre-Generate Certificate to issue certificates before updating DNS records and initiating the remainder of your domain migration.

You can still import a zone file or [use Domain Connect](https://vercel.com/changelog/automated-dns-configuration-with-domain-connect-3kcmg61eR38Q5MzKc4D6P) to migrate DNS records from your previous provider.

[Try it out](https://vercel.com/d?to=/%5Bteam%5D/~/domains/&title=Pre-Generate+your+SSL+certificates) or learn more in [the docs](https://vercel.com/docs/domains/pre-generating-ssl-certs).