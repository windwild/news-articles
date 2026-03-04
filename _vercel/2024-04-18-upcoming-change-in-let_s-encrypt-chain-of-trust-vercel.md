---
title: "Upcoming change in Let's Encrypt Chain of Trust - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/upcoming-change-in-lets-encrypt-chain-of-trust"
date: "2024-04-18"
scraped_at: "2026-03-02T09:45:48.381364350+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Apr 18, 2024

2024 年 4 月 18 日

**Important:** This change does _**not**_ impact customers currently using custom certificates issued by commercial CAs and using them on Vercel via the [custom certificate](https://vercel.com/docs/projects/domains/custom-SSL-certificate) feature.

**重要提示：** 此变更 _**不会**_ 影响当前正在使用由商业证书颁发机构（CA）签发的自定义证书、并通过 Vercel 的 [自定义证书](https://vercel.com/docs/projects/domains/custom-SSL-certificate) 功能将其部署到 Vercel 的客户。

Vercel uses [Let's Encrypt](https://letsencrypt.org/) as its certificate authority (CA) to auto-provision TLS certificates to enable secure connections by default. When using custom domains in your Vercel app, traffic between clients and Vercel Edge Network is encrypted and protected using the auto-provisioned Let's Encrypt certificate.

Vercel 使用 [Let’s Encrypt](https://letsencrypt.org/) 作为其证书颁发机构（CA），默认自动签发 TLS 证书，以启用安全连接。当您的 Vercel 应用使用自定义域名时，客户端与 Vercel 边缘网络之间的流量将通过自动签发的 Let’s Encrypt 证书进行加密和保护。

[As planned](https://letsencrypt.org/2023/07/10/cross-sign-expiration.html), on **September 30th, 2024**, the current Let’s Encrypt cross-sign [DST Root CA X3](https://letsencrypt.org/certificates/) root certificate issued by IdenTrust will expire and no longer be available. Considering the small proportion of internet users with older devices today, Let's Encrypt has decided to officially sunset this cross-sign certificate chain. This change has been planned by Let's Encrypt over the past few years, under their mission of providing safe and secure communication to everyone who uses the Web. You can read more about this change in their [blog post](https://letsencrypt.org/2023/07/10/cross-sign-expiration.html).

根据既定计划（参见 [Let’s Encrypt 博客公告](https://letsencrypt.org/2023/07/10/cross-sign-expiration.html)），**2024 年 9 月 30 日**，由 IdenTrust 签发的当前 Let’s Encrypt 交叉签名根证书 [DST Root CA X3](https://letsencrypt.org/certificates/) 将正式过期并停止可用。鉴于目前仍在使用老旧设备的互联网用户比例已非常小，Let’s Encrypt 决定正式终止该交叉签名证书链。这一变更已在过去数年中由 Let’s Encrypt 持续规划推进，旨在践行其“为所有网络用户提供安全可靠通信”的使命。您可进一步阅读其 [官方博客文章](https://letsencrypt.org/2023/07/10/cross-sign-expiration.html) 了解详情。

After **September 30th, 2024**, clients accessing your websites hosted on Vercel must be able to trust the latest [ISRG Root X1](https://letsencrypt.org/certificates/) root certificate from their local trust store. Modern operating systems and browsers trust this certificate, and it should not cause any noticeable impacts on your users. However, some older devices, such as Android 7.0 or earlier, may be unable to trust the new chain by default.

自 **2024 年 9 月 30 日起**，访问您托管在 Vercel 上网站的客户端，必须能够从其本地信任库中验证最新的 [ISRG Root X1](https://letsencrypt.org/certificates/) 根证书。主流现代操作系统及浏览器均默认信任该证书，因此对绝大多数用户不会造成任何明显影响。但部分较旧设备（例如 Android 7.0 及更早版本）可能默认无法信任新的证书链。

You can check more details about this change and review remedy options in our [public announcement](https://github.com/orgs/vercel/discussions/6374) on the GitHub community forum.

您可在 GitHub 社区论坛的 [公开公告](https://github.com/orgs/vercel/discussions/6374) 中查阅有关此次变更的更多细节，并评估可行的应对方案。
{% endraw %}
