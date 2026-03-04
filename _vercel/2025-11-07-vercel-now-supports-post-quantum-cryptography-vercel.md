---
title: "Vercel now supports post-quantum cryptography - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/post-quantum-crypto"
date: "2025-11-07"
scraped_at: "2026-03-02T09:25:52.859714828+00:00"
language: "en-zh"
translated: true
description: "Connections to all Vercel deployments now support a new encryption algorithm during TLS handshakes, which protects against future quantum threats."
---

render_with_liquid: false
Nov 7, 2025

2025 年 11 月 7 日

HTTPS connections to the Vercel network are now secured with post-quantum cryptography.

Vercel 网络的 HTTPS 连接现已采用后量子密码学（post-quantum cryptography）进行保护。

Most web encryption today could be broken by future quantum computers. While this threat isn’t immediate, attackers can capture encrypted traffic today and decrypt it later as quantum technology advances.

当前大多数网页加密技术未来可能被量子计算机攻破。尽管这一威胁尚不迫在眉睫，但攻击者如今即可截获加密流量，并在未来量子计算技术成熟后将其解密。

Vercel now supports post-quantum encryption during TLS handshakes, protecting applications against these future risks. Modern browsers will automatically use it with no configuration or additional cost required.

Vercel 现已在 TLS 握手过程中支持后量子加密，从而帮助您的应用抵御此类未来风险。现代浏览器将自动启用该功能，无需任何配置，亦不产生额外费用。

Read more about [encryption](https://vercel.com/docs/encryption#post-quantum-cryptography) and how we secure your deployments.

了解更多关于[加密](https://vercel.com/docs/encryption#post-quantum-cryptography)的信息，以及我们如何保障您部署的安全性。