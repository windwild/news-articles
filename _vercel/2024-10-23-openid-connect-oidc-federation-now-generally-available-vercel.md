---
title: "OpenID Connect (OIDC) Federation now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openid-connect-federation-now-generally-available"
date: "2024-10-23"
scraped_at: "2026-03-02T09:40:51.448879935+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Oct 23, 2024

2024 年 10 月 23 日

![](images/openid-connect-oidc-federation-now-generally-available-vercel/img_001.jpg)![](images/openid-connect-oidc-federation-now-generally-available-vercel/img_002.jpg)

Vercel's OpenID Connect (OIDC) Federation is now generally available.

Vercel 的 OpenID Connect（OIDC）联邦功能现已正式发布（GA）。

Strengthen your security by replacing long-lived environment variable credentials with short-lived, RSA-signed JWTs for builds and Vercel Functions.

通过以短期有效的、RSA 签名的 JWT 替代长期有效的环境变量凭据，增强构建过程与 Vercel Functions 的安全性。

Use Vercel’s OIDC Identity Provider (IdP) to issue tokens for cloud providers and services like AWS, Azure, Firebase, and Salesforce.

使用 Vercel 提供的 OIDC 身份提供商（IdP），为 AWS、Azure、Firebase 和 Salesforce 等云服务商及平台签发令牌。

With general availability, we are also introducing a new Team Issuer mode, which mints OIDC tokens with a URL unique to your team. This allows you to configure your cloud environment with stricter zero trust configurations.

伴随正式发布，我们同步推出全新的「团队签发者（Team Issuer）模式」：该模式生成的 OIDC 令牌将包含专属于您团队的唯一 URL，从而支持您在云环境中配置更严格的零信任（Zero Trust）安全策略。

To enable Vercel OIDC, update your [project's security settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation) and integrate it using the `@vercel/functions` package. If you're already using Vercel OIDC, we recommend opting into Team Issuer mode in those [settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation).

如需启用 Vercel OIDC，请更新您的 [项目安全设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation)，并借助 `@vercel/functions` 包完成集成。若您已在使用 Vercel OIDC，我们建议您在上述 [设置页面](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation) 中启用「团队签发者模式」。

```javascript
import { awsCredentialsProvider } from '@vercel/functions/oidc';

import * as s3 from '@aws/client-s3';



const s3client = new s3.S3Client({

5  credentials: awsCredentialsProvider({

5  credentials: awsCredentialsProvider({

6    roleArn: process.env.AWS_ROLE_ARN!,

6    roleArn: process.env.AWS_ROLE_ARN!,

7  }),

7  }),

8});

8});

Check out the [documentation](https://vercel.com/docs/security/secure-backend-access/oidc) and [blog post](https://vercel.com/blog/enhancing-security-of-backend-connectivity-with-openid-connect) to learn more.

请参阅[文档](https://vercel.com/docs/security/secure-backend-access/oidc)和[博客文章](https://vercel.com/blog/enhancing-security-of-backend-connectivity-with-openid-connect)，了解更多信息。
&#123;% endraw %}
