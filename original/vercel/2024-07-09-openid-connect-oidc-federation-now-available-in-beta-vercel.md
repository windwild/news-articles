---
title: "OpenID Connect (OIDC) Federation now available in Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/oidc-federation-now-available-in-beta"
date: "2024-07-09"
scraped_at: "2026-03-02T09:43:18.788943316+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jul 9, 2024

![](images/openid-connect-oidc-federation-now-available-in-beta-vercel/img_001.jpg)![](images/openid-connect-oidc-federation-now-available-in-beta-vercel/img_002.jpg)

Vercel now supports OpenID Connect (OIDC) Federation, enabling you to enhance your security by replacing long-lived environment variable credentials with short-lived, RSA-signed JWTs for external requests in both builds and Vercel Functions.

You can now leverage Vercel's OIDC Identity Provider (IdP) to issue persistent tokens for cloud providers such as AWS, Azure, GCP, and more.

Enable OIDC in your project's security settings and leverage the `@vercel/functions` package for integration with third-party providers, like this:

```javascript
import { awsCredentialsProvider } from '@vercel/functions/oidc';

import * as s3 from '@aws/client-s3';



const s3client = new s3.S3Client({

5  credentials: awsCredentialsProvider({

6    roleArn: process.env.AWS_ROLE_ARN!,

7  }),

8});
```

Learn more about OpenID Connect Federation in the [documentation](https://vercel.com/docs/security/secure-backend-access/oidc).