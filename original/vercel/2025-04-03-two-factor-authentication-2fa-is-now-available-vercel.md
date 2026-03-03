---
title: "Two-Factor Authentication (2FA) is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/2fa-is-now-available"
date: "2025-04-03"
scraped_at: "2026-03-02T09:35:05.728406014+00:00"
language: "en"
translated: false
description: "Two-Factor Authentication (2FA) is now available. You can now secure your personal account using Two-Factor Authentication (2FA) with Time-based One-Time Passwords (TOTP)"
---




Apr 3, 2025

![](images/two-factor-authentication-2fa-is-now-available-vercel/img_001.jpg)![](images/two-factor-authentication-2fa-is-now-available-vercel/img_002.jpg)

Users can now secure their accounts using Two-Factor Authentication (2FA) with Time-based One-Time Passwords (TOTP), commonly provided by authenticator apps like Google Authenticator or Authy. Your current Passkeys(WebAuthn keys) can also be used as second factors. 2FA adds an extra security layer to protect your account even if the initial login method is compromised.

**To Enable 2FA:**

1. Navigate to [Authentication](https://vercel.com/account/settings/authentication) in Account Settings and enable 2FA

2. Log in using your existing method (email OTP or Git provider) as your first factor

3. Complete authentication with a TOTP authenticator as your second factor


**Important information:**

- **Passkey logins (WebAuthn)** are inherently two-factor and won't prompt for additional verification

- **Team-scoped SAML SSO logins** delegate authentication responsibility to your identity provider (IdP) and won't require an additional factor within Vercel


Visit your [account settings](https://vercel.com/account/settings/authentication) to enable 2FA today, or check out our [documentation](https://vercel.com/docs/two-factor-authentication) to learn more.