---
title: "Safely inject credentials in HTTP headers with Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/safely-inject-credentials-in-http-headers-with-vercel-sandbox"
date: "2026-02-23"
scraped_at: "2026-03-02T09:21:25.662238766+00:00"
language: "en"
translated: false
description: "Sandbox network policies now support HTTP header injection to prevent secrets exfiltration by untrusted code"
---




Feb 23, 2026

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) can now automatically inject HTTP headers into outbound requests from sandboxed code. This keeps API keys and tokens safely outside the sandbox VM boundary, so apps running inside the sandbox can call authenticated services without ever accessing the credentials.

Header injection is configured as part of the network policy using `transform`. When the sandbox makes an HTTPS request to a matching domain, the firewall adds or replaces the specified headers before forwarding the request.

```typescript
const sandbox = await Sandbox.create({

2  timeout: 300_000,

3  networkPolicy: {

4    allow: {

5      "ai-gateway.vercel.sh": [{\
\
6        transform: [{\
\
7          headers: {\
\
8            authorization: `Bearer ${process.env.AI_GATEWAY_API_KEY}`\
\
9          }\
\
10        }],\
\
11      }],

12    },

13  },

14});



16// Code inside the sandbox calls AI Gateway without knowing the API key

const result = await sandbox.runCommand('curl',

18  ['-s', 'https://ai-gateway.vercel.sh/v1/models']

19);
```

This is designed for AI agent workflows where prompt injection is a real threat. Even if an agent is compromised, there's nothing to exfiltrate, as the credentials only exist in a layer outside the VM.

![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_001.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_002.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_003.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_004.jpg)

Injection rules work with all egress network policy configurations, including open internet access. To allow general traffic while injecting credentials for specific services:

```typescript
const sandbox = await Sandbox.create({

2  networkPolicy: {

3    allow: {

4      "ai-gateway.vercel.sh": [{\
\
5        transform: [{\
\
6          headers: {\
\
7            Authorization: `Bearer ${process.env.AI_GATEWAY_API_KEY}`\
\
8          }\
\
9        }],\
\
10      }],

11      "*.github.com": [{\
\
12        transform: [{\
\
13          headers: {\
\
14            Authorization: `Bearer ${process.env.GITHUB_TOKEN}`\
\
15          }\
\
16        }],\
\
17      }],

18      // Allow traffic to all other domains.

19      "*": []

20    }

21  }

22});
```

### Live updates

Like all network policy settings, injection rules can be updated on a running sandbox without restarting it. This enables multi-phase workflows, inject credentials during setup, then remove them before running untrusted code:

```typescript
1// Phase 1: Clone repos with credentials

await sandbox.updateNetworkPolicy({

3  allow: {

4    "api.github.com": [{\
\
5      transform: [{\
\
6        headers: {\
\
7          Authorization: `Bearer ${process.env.GITHUB_TOKEN}`\
\
8        }\
\
9        }],\
\
10    }],

11  }

12});



14// ... clone repos, download data ...



16// Phase 2: Lock down before running untrusted code

await sandbox.updateNetworkPolicy('deny-all');
```

### Key highlights

- Header overwrite: Injection applies to HTTP headers on outbound requests.

- Full replacement: Injected headers overwrite any existing headers with the same name set by sandbox code, preventing the sandbox from substituting its own credentials.

- Domain matching: Supports exact domains and wildcards (e.g., \*.github.com). Injection only triggers when the outbound request matches.

- Works with all policies: Combine injection rules with `allow-all`, or domain-specific allow lists.


Available to all Pro and Enterprise customers. Learn more in the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/firewall#credentials-brokering).