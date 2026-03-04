---
title: "Domains now include their `www` counterpart - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/domains-now-include-their-www-counterpart"
date: "2021-04-02"
scraped_at: "2026-03-02T10:04:58.843476571+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Apr 2, 2021

2021年4月2日

![](images/domains-now-include-their-www-counterpart-vercel/img_001.jpg)

![](images/domains-now-include-their-www-counterpart-vercel/img_001.jpg)

Adding a domain to a project will now also suggest adding its `www` counterpart. This ensures visitors can always access your site, regardless of whether they type `www` when entering the domain, or not.

向项目添加域名时，系统现在还会建议同时添加其对应的 `www` 域名。这能确保访问者无论在输入域名时是否包含 `www`，均能正常访问您的网站。

Using a `www` domain guarantees that the [Vercel Edge Network](https://vercel.com/blog/new-edge-dev-infrastructure#our-new-edge-infrastructure) can reliably and securely route incoming traffic as quickly as possible, so redirecting non-`www` to the `www` domain is recommended. Redirecting the other way works too if you prefer a cleaner URL address.

使用 `www` 域名可确保 [Vercel 边缘网络（Vercel Edge Network）](https://vercel.com/blog/new-edge-dev-infrastructure#our-new-edge-infrastructure) 能够可靠、安全地以最快速度路由入站流量；因此，我们推荐将非 `www` 域名重定向至 `www` 域名。若您偏好更简洁的 URL 地址，反向重定向（即 `www` → 非 `www`）同样可行。

Existing domains are not affected by this change, but we recommend ensuring that your project already has a `www` redirect in place.

此变更不会影响已有的域名，但我们建议您确认项目中已配置好 `www` 域名的重定向规则。

Check out [the documentation](https://vercel.com/docs/custom-domains#redirecting-domains) as well.

请参阅 [相关文档](https://vercel.com/docs/custom-domains#redirecting-domains)。
{% endraw %}
