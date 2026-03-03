---
title: "Introducing new token formats and secret scanning - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-token-formats-and-secret-scanning"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.706113117+00:00"
language: "en"
translated: false
description: "Vercel automatically detects and revokes exposed credentials. Learn about new token formats, new automated secret scanning, and partnership in GitHub's secret scanning program."
---




Feb 9, 2026

![A token entity when the token has been discovered by a secret scan](images/introducing-new-token-formats-and-secret-scanning-vercel/img_001.jpg)![A token entity when the token has been discovered by a secret scan](images/introducing-new-token-formats-and-secret-scanning-vercel/img_002.jpg)

When Vercel API credentials are accidentally committed to public GitHub repositories, gists and npm packages, Vercel now automatically revokes them to protect your account from unauthorized access.

When the exposed credentials are detected, you'll receive notifications and can review any discovered [tokens](https://vercel.com/account/settings/tokens) and [API keys](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys) in your dashboard. This detection is powered by [GitHub secret scanning](https://docs.github.com/en/code-security/concepts/secret-security/about-secret-scanning) and brings an extra layer of security to all Vercel and v0 users.

As part of this change, we've also updated token and API key formats to make them visually identifiable. Each credential type now includes a prefix:

- `vcp` for [Vercel personal access tokens](https://docs.vercel.com/docs/rest-api/reference/welcome#authentication)

- `vci` for [Vercel integration tokens](https://vercel.com/docs/integrations/vercel-api-integrations#create-an-access-token)

- `vca` for [Vercel app access tokens](https://vercel.com/docs/sign-in-with-vercel/tokens#access-token)

- `vcr` for [Vercel app refresh tokens](https://vercel.com/docs/sign-in-with-vercel/tokens#refresh-token)

- `vck` for [Vercel API keys](https://vercel.com/docs/ai-gateway/authentication#api-key)


We recommend reviewing your [tokens](https://vercel.com/account/settings/tokens) and [API keys](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys) regularly, rotating long-lived credentials, and revoking unused ones.

[Learn more](https://vercel.com/docs/accounts) about account security.