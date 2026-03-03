---
title: "Two-Factor Authentication (2FA) is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/2fa-is-now-available"
date: "2025-04-03"
scraped_at: "2026-03-02T09:35:05.728406014+00:00"
language: "en-zh"
translated: true
description: "Two-Factor Authentication (2FA) is now available. You can now secure your personal account using Two-Factor Authentication (2FA) with Time-based One-Time Passwords (TOTP)"
---

Apr 3, 2025

2025年4月3日

![](images/two-factor-authentication-2fa-is-now-available-vercel/img_001.jpg)![](images/two-factor-authentication-2fa-is-now-available-vercel/img_002.jpg)

Users can now secure their accounts using Two-Factor Authentication (2FA) with Time-based One-Time Passwords (TOTP), commonly provided by authenticator apps like Google Authenticator or Authy. Your current Passkeys (WebAuthn keys) can also be used as second factors. 2FA adds an extra security layer to protect your account even if the initial login method is compromised.

用户现在可以使用基于时间的一次性密码（TOTP）——通常由 Google Authenticator 或 Authy 等身份验证器应用提供——来启用双重身份验证（2FA），从而增强账户安全性。您当前的通行密钥（WebAuthn 密钥）也可作为第二重验证因素使用。即使初始登录方式遭到破坏，2FA 仍能为您的账户提供额外的安全防护层。

**To Enable 2FA:**

**如何启用 2FA：**

1. Navigate to [Authentication](https://vercel.com/account/settings/authentication) in Account Settings and enable 2FA

1. 前往账户设置中的 [身份验证](https://vercel.com/account/settings/authentication) 页面，启用 2FA

2. Log in using your existing method (email OTP or Git provider) as your first factor

2. 使用您现有的登录方式（邮箱一次性验证码或 Git 提供商）作为第一重验证因素完成登录

3. Complete authentication with a TOTP authenticator as your second factor

3. 使用 TOTP 身份验证器完成第二重验证

**Important information:**

**重要说明：**

- **Passkey logins (WebAuthn)** are inherently two-factor and won't prompt for additional verification

- **通行密钥登录（WebAuthn）** 本身即具备双重验证特性，因此不会要求额外的验证步骤

- **Team-scoped SAML SSO logins** delegate authentication responsibility to your identity provider (IdP) and won't require an additional factor within Vercel

- **面向团队的 SAML 单点登录（SSO）** 将身份验证责任委托给您的身份提供商（IdP），因此在 Vercel 平台内无需额外验证因素

Visit your [account settings](https://vercel.com/account/settings/authentication) to enable 2FA today, or check out our [documentation](https://vercel.com/docs/two-factor-authentication) to learn more.

请立即访问您的[账户设置](https://vercel.com/account/settings/authentication)以启用双重身份验证（2FA），或查阅我们的[文档](https://vercel.com/docs/two-factor-authentication)了解更多信息。