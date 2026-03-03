---
title: "Introducing new token formats and secret scanning - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-token-formats-and-secret-scanning"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.706113117+00:00"
language: "en-zh"
translated: true
description: "Vercel automatically detects and revokes exposed credentials. Learn about new token formats, new automated secret scanning, and partnership in GitHub's secret scanning program."
---

Feb 9, 2026

2026 年 2 月 9 日

![A token entity when the token has been discovered by a secret scan](images/introducing-new-token-formats-and-secret-scanning-vercel/img_001.jpg)![A token entity when the token has been discovered by a secret scan](images/introducing-new-token-formats-and-secret-scanning-vercel/img_002.jpg)

![令牌实体在被密钥扫描发现时的界面示意图](images/introducing-new-token-formats-and-secret-scanning-vercel/img_001.jpg)![令牌实体在被密钥扫描发现时的界面示意图](images/introducing-new-token-formats-and-secret-scanning-vercel/img_002.jpg)

When Vercel API credentials are accidentally committed to public GitHub repositories, gists and npm packages, Vercel now automatically revokes them to protect your account from unauthorized access.

当 Vercel API 凭据意外提交至公开的 GitHub 仓库、Gist 或 npm 包时，Vercel 现在将自动撤销这些凭据，以防止您的账户遭受未授权访问。

When the exposed credentials are detected, you'll receive notifications and can review any discovered [tokens](https://vercel.com/account/settings/tokens) and [API keys](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys) in your dashboard. This detection is powered by [GitHub secret scanning](https://docs.github.com/en/code-security/concepts/secret-security/about-secret-scanning) and brings an extra layer of security to all Vercel and v0 users.

一旦检测到已泄露的凭据，您将收到通知，并可在控制台中审查所有已发现的 [令牌（tokens）](https://vercel.com/account/settings/tokens) 和 [API 密钥（API keys）](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys)。该检测能力由 [GitHub 密钥扫描（GitHub secret scanning）](https://docs.github.com/en/code-security/concepts/secret-security/about-secret-scanning) 提供支持，为所有 Vercel 和 v0 用户增添了一层额外的安全保障。

As part of this change, we've also updated token and API key formats to make them visually identifiable. Each credential type now includes a prefix:

作为本次更新的一部分，我们还调整了令牌与 API 密钥的格式，使其在视觉上更易于识别。每种凭据类型现均带有特定前缀：

- `vcp` for [Vercel personal access tokens](https://docs.vercel.com/docs/rest-api/reference/welcome#authentication)

- `vcp`：用于 [Vercel 个人访问令牌（Vercel personal access tokens）](https://docs.vercel.com/docs/rest-api/reference/welcome#authentication)

- `vci` for [Vercel integration tokens](https://vercel.com/docs/integrations/vercel-api-integrations#create-an-access-token)

- `vci`：用于 [Vercel 集成令牌（Vercel integration tokens）](https://vercel.com/docs/integrations/vercel-api-integrations#create-an-access-token)

- `vca` for [Vercel app access tokens](https://vercel.com/docs/sign-in-with-vercel/tokens#access-token)

- `vca`：用于 [Vercel 应用访问令牌（Vercel app access tokens）](https://vercel.com/docs/sign-in-with-vercel/tokens#access-token)

- `vcr` for [Vercel app refresh tokens](https://vercel.com/docs/sign-in-with-vercel/tokens#refresh-token)

- `vcr`：用于 [Vercel 应用刷新令牌（Vercel app refresh tokens）](https://vercel.com/docs/sign-in-with-vercel/tokens#refresh-token)

- `vck` for [Vercel API keys](https://vercel.com/docs/ai-gateway/authentication#api-key)

- `vck`：用于 [Vercel API 密钥（Vercel API keys）](https://vercel.com/docs/ai-gateway/authentication#api-key)

We recommend reviewing your [tokens](https://vercel.com/account/settings/tokens) and [API keys](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys) regularly, rotating long-lived credentials, and revoking unused ones.

我们建议您定期审查自己的 [令牌](https://vercel.com/account/settings/tokens) 和 [API 密钥](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fai%2Fapi-keys\&title=AI+Gateway+API+keys)，轮换长期有效的凭据，并撤销未使用的凭据。

[Learn more](https://vercel.com/docs/accounts) about account security.

[了解更多](https://vercel.com/docs/accounts) 关于账户安全的信息。