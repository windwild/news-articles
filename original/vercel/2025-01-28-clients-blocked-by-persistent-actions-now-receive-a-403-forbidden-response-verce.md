---
title: "Clients blocked by persistent actions now receive a 403 Forbidden response - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/clients-blocked-by-persistent-actions-now-receive-a-403-forbidden-response"
date: "2025-01-28"
scraped_at: "2026-03-02T09:37:18.111852234+00:00"
language: "en"
translated: false
description: "The Vercel Web Application Firewall blocks clients by persistent actions with a 403 Forbidden response "
---




Jan 28, 2025

Starting today, when the [Vercel Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-waf) blocks a client with a persistent action, it will respond with a 403 Forbidden status instead of failing silently. This change now makes it clear that the connection is being intentionally denied.

Persistent actions in the WAF help reduce edge request load and stop malicious traffic earlier, cutting down unnecessary processing for your applications.

Learn more about [persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions).