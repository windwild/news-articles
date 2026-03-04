---
title: "OpenID Connect (OIDC) Federation now available in Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/oidc-federation-now-available-in-beta"
date: "2024-07-09"
scraped_at: "2026-03-02T09:43:18.788943316+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Jul 9, 2024

2024 年 7 月 9 日

![](images/openid-connect-oidc-federation-now-available-in-beta-vercel/img_001.jpg)![](images/openid-connect-oidc-federation-now-available-in-beta-vercel/img_002.jpg)

Vercel 现已支持 OpenID Connect（OIDC）联邦身份认证（Federation），使您能够通过使用短期有效的、RSA 签名的 JWT 令牌替代长期有效的环境变量凭据，从而增强安全性——该机制适用于构建（builds）过程及 Vercel Functions 中发起的外部请求。

您现在可利用 Vercel 提供的 OIDC 身份提供商（IdP）为云服务商（如 AWS、Azure、GCP 等）签发持久化令牌。

在项目的安全设置中启用 OIDC，并借助 `@vercel/functions` 包与第三方服务商集成，例如：

```javascript
import { awsCredentialsProvider } from '@vercel/functions/oidc';

import * as s3 from '@aws/client-s3';



const s3client = new s3.S3Client({

5  credentials: awsCredentialsProvider({

6    roleArn: process.env.AWS_ROLE_ARN!,

7  }),

8});
```

有关 OpenID Connect 联合身份认证的更多信息，请参阅[文档](https://vercel.com/docs/security/secure-backend-access/oidc)。
&#123;% endraw %}
