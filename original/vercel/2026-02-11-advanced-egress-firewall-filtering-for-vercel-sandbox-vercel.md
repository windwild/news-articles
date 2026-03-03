---
title: "Advanced egress firewall filtering for Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/advanced-egress-firewall-filtering-for-vercel-sandbox"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.291765649+00:00"
language: "en"
translated: false
description: "Vercel sandboxes now allow you to restrict access to the internet to keep exfiltration risks to a minimum"
---




Feb 11, 2026

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) can now enforce egress network policies through Server Name Indication (SNI) filtering and CIDR blocks, giving you control over which hosts a sandbox can reach. Outbound TLS connections are matched against your policy at the handshake, unauthorized destinations are rejected before any data is transmitted.

By default, sandboxes have unrestricted internet access. When running untrusted or AI generated code, you can lock down the network to only the services your workload actually needs. A compromised or hallucinated code snippet cannot exfiltrate data or make unintended API calls, traffic to any domain not on your allowlist is blocked.

### Going beyond IP based rules to host based

The modern internet runs on hostnames, not IP addresses, a handful of addresses serve thousands of domains. Traditional IP-based firewall rules can't precisely distinguish between them.

Host-based egress control typically requires an HTTP proxy, but that breaks non-HTTP protocols like Redis and Postgres. Instead, we built an SNI-peeking firewall that inspects the initial unencrypted bytes of a TLS handshake to extract the target hostname. Since nearly all internet traffic is TLS-encrypted today, this covers all relevant cases. For legacy or non-TLS systems, we do also support IP/CIDR-based rules as a fallback.

### Restrict to specific hosts at creation

Define which domains the sandbox can reach. Everything else is denied by default. Wildcard support makes it easy to allowlist services behind CDNs:

```typescript
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create({

4  networkPolicy: {

5    allow: ['ai-gateway.vercel.sh', '*.vercel.com'],

6  },

7});



9// Can reach Vercel AI Gateway and Vercel, nothing else

await sandbox.runCommand('node', ['process-data.js']);
```

### Adjust after initial setup

Policies can be updated dynamically on a running sandbox without restarting the process. Start with full internet access to install dependencies, lock it down before executing untrusted code, reopen to stream results after user approval, and then air gap again with `deny-all`, fully in one session:

```typescript
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();



5// Phase 1: Open network, download everything we need

await sandbox.runCommand('npm', ['install']);

await sandbox.runCommand('aws', ['s3', 'cp', 's3://my-bucket/input-data', './data', '--recursive']);



9// Phase 2: Lock down, only the AI gateway is reachable

await sandbox.updateNetworkPolicy({

11  allow: ['ai-gateway.vercel.sh'],

12});



14// Run the untrusted / agent-driven workload in isolation

await sandbox.runCommand('node', ['agent.js']);



17// Phase 3: Open a narrow hole to post results back

await sandbox.updateNetworkPolicy({

19  allow: ['my-bucket.s3.amazonaws.com'],

20});



await sandbox.runCommand('aws', ['s3', 'cp', './output/results.json', 's3://my-bucket/output/results.json']);



24// Phase 4: Lockdown Internet access

await sandbox.updateNetworkPolicy('deny-all');
```

Read the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/firewall) to learn more about network egress firewall policies, available on all plans.