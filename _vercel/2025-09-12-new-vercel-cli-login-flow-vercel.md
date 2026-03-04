---
title: "New Vercel CLI login flow - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-vercel-cli-login-flow"
date: "2025-09-12"
scraped_at: "2026-03-02T09:28:36.635049181+00:00"
language: "en-zh"
translated: true
description: "Simplified Vercel CLI login with OAuth 2.0 Device Flow. Sign in securely from any browser. Email and provider-based logins deprecated Feb 1. Upgrade now."
---
{% raw %}

Sep 12, 2025

2025 年 9 月 12 日

![Authorize Device Flow](images/new-vercel-cli-login-flow-vercel/img_001.jpg)![Authorize Device Flow](images/new-vercel-cli-login-flow-vercel/img_002.jpg)

![授权设备流程](images/new-vercel-cli-login-flow-vercel/img_001.jpg)![授权设备流程](images/new-vercel-cli-login-flow-vercel/img_002.jpg)

The `vercel login` command now uses the industry-standard [OAuth 2.0 Device Flow](https://datatracker.ietf.org/doc/html/rfc8628), making authentication more secure and intuitive. You can sign in from any browser-capable device.

`vercel login` 命令现已采用业界标准的 [OAuth 2.0 设备授权流程（Device Flow）](https://datatracker.ietf.org/doc/html/rfc8628)，使身份验证更安全、更直观。您可从任意支持浏览器的设备完成登录。

When approving a login, be sure to verify the location, IP, and request time before granting access to your Vercel account.

在批准登录请求时，请务必核对登录地点、IP 地址及请求时间，再授予对您 Vercel 账户的访问权限。

Email-based login (`vercel login your@email.com`) and the flags `--github`, `--gitlab`, `--bitbucket`, `--oob`, and `team` are deprecated. These methods will no longer be supported beginning **February 26, 2026**, except for the `team` method (SAML-based login), which remains supported until **June 1, 2026**.

基于邮箱的登录方式（`vercel login your@email.com`）以及 `--github`、`--gitlab`、`--bitbucket`、`--oob` 和 `team` 等参数均已弃用。除 `team` 方法（基于 SAML 的登录）外，上述方法将于 **2026 年 2 月 26 日起停止支持**；`team` 方法则将持续支持至 **2026 年 6 月 1 日**。

_Note: Support had previously been extended from the original deprecation date of February 1, 2026 to June 1, 2026. To prioritize user security, we are moving the deprecation date forward: most of these methods will be removed on February 26, 2026, with the_ _`team`_ _method following on June 1, 2026._

_注：此前已将原定弃用日期（2026 年 2 月 1 日）延长至 2026 年 6 月 1 日。为优先保障用户安全，我们决定提前执行弃用计划：其中大部分方法将于 2026 年 2 月 26 日起正式移除，仅 `team` 方法延后至 2026 年 6 月 1 日停用。_

**Upgrade today with** **`npm i vercel@latest`**

**立即升级：** **`npm i vercel@latest`**

Learn more in the [docs](https://vercel.com/docs/cli/login).

更多详情请参阅 [文档](https://vercel.com/docs/cli/login)。
{% endraw %}
