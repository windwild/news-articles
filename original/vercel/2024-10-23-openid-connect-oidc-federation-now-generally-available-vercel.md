---
title: "OpenID Connect (OIDC) Federation now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/openid-connect-federation-now-generally-available"
date: "2024-10-23"
scraped_at: "2026-03-02T09:40:51.448879935+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 23, 2024

![](images/openid-connect-oidc-federation-now-generally-available-vercel/img_001.jpg)![](images/openid-connect-oidc-federation-now-generally-available-vercel/img_002.jpg)

Vercel's OpenID Connect (OIDC) Federation is now generally available. Strengthen your security by replacing long-lived environment variable credentials with short-lived, RSA-signed JWTs for builds and Vercel Functions.

Use Vercel’s OIDC Identity Provider (IdP) to issue tokens for cloud providers and services like AWS, Azure, Firebase, and Salesforce.

With general availability, we are also introducing a new Team Issuer mode, which mints OIDC tokens with a URL unique to your team. This allows you to configure your cloud environment with stricter zero trust configurations.

To enable Vercel OIDC, update your [project's security settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation) and integrate it using the `@vercel/functions` package. If you're already using Vercel OIDC, we recommend opting into Team Issuer mode in those [settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecurity&title=Enable+OIDC+Federation).

```javascript
import { awsCredentialsProvider } from '@vercel/functions/oidc';

import * as s3 from '@aws/client-s3';



const s3client = new s3.S3Client({

5  credentials: awsCredentialsProvider({

6    roleArn: process.env.AWS_ROLE_ARN!,

7  }),

8});
```

Check out the [documentation](https://vercel.com/docs/security/secure-backend-access/oidc) and [blog post](https://vercel.com/blog/enhancing-security-of-backend-connectivity-with-openid-connect) to learn more.