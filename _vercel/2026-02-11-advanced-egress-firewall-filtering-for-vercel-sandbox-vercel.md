---
title: "Advanced egress firewall filtering for Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/advanced-egress-firewall-filtering-for-vercel-sandbox"
date: "2026-02-11"
scraped_at: "2026-03-02T09:21:33.291765649+00:00"
language: "en-zh"
translated: true
description: "Vercel sandboxes now allow you to restrict access to the internet to keep exfiltration risks to a minimum"
---
{% raw %}

Feb 11, 2026

2026年2月11日

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) can now enforce egress network policies through Server Name Indication (SNI) filtering and CIDR blocks, giving you control over which hosts a sandbox can reach. Outbound TLS connections are matched against your policy at the handshake, unauthorized destinations are rejected before any data is transmitted.

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 现在可通过服务器名称指示（SNI）过滤和 CIDR 地址块强制执行出口网络策略，使您能够精确控制沙盒可访问的目标主机。出站 TLS 连接在 TLS 握手阶段即与您的策略进行匹配；任何未授权的目标地址均会在任何数据传输前即被拒绝。

By default, sandboxes have unrestricted internet access. When running untrusted or AI generated code, you can lock down the network to only the services your workload actually needs. A compromised or hallucinated code snippet cannot exfiltrate data or make unintended API calls, traffic to any domain not on your allowlist is blocked.

默认情况下，沙盒拥有无限制的互联网访问权限。但在运行不可信代码或 AI 生成的代码时，您可以将网络严格限制为仅允许工作负载实际所需的那些服务。即使代码片段遭到入侵或产生幻觉（hallucinated），也无法外泄数据或发起非预期的 API 调用——所有未列入白名单的域名流量均会被拦截。

### Going beyond IP based rules to host based

### 超越基于 IP 的规则：实现基于主机名的管控

The modern internet runs on hostnames, not IP addresses, a handful of addresses serve thousands of domains. Traditional IP-based firewall rules can't precisely distinguish between them.

现代互联网以主机名（hostnames）而非 IP 地址为核心运行；少数几个 IP 地址往往承载着成千上万个域名。传统的基于 IP 的防火墙规则无法在这些共享 IP 的域名之间做出精确区分。

Host-based egress control typically requires an HTTP proxy, but that breaks non-HTTP protocols like Redis and Postgres. Instead, we built an SNI-peeking firewall that inspects the initial unencrypted bytes of a TLS handshake to extract the target hostname. Since nearly all internet traffic is TLS-encrypted today, this covers all relevant cases. For legacy or non-TLS systems, we do also support IP/CIDR-based rules as a fallback.

基于主机名的出口管控通常需依赖 HTTP 代理，但这会破坏 Redis、PostgreSQL 等非 HTTP 协议的通信。为此，我们构建了一种“SNI 探查型”（SNI-peeking）防火墙——它通过检查 TLS 握手初期未加密的字节，提取目标主机名。鉴于当今几乎所有互联网流量均已采用 TLS 加密，该机制可覆盖全部典型使用场景。对于遗留系统或非 TLS 协议，我们亦提供基于 IP / CIDR 的规则作为备用方案。

### Restrict to specific hosts at creation

### 在创建沙盒时即限定可访问的特定主机

Define which domains the sandbox can reach. Everything else is denied by default. Wildcard support makes it easy to allowlist services behind CDNs:

定义沙盒可访问的域名范围；其余所有域名默认拒绝访问。通配符（wildcard）支持让 CDN 后端服务的白名单配置变得极为简便：

```typescript
import { Sandbox } from '@vercel/sandbox';
```

```js
const sandbox = await Sandbox.create({

4  networkPolicy: {

5    allow: ['ai-gateway.vercel.sh', '*.vercel.com'],

6  },

7});
```

```js
const sandbox = await Sandbox.create({

4  networkPolicy: {

5    允许访问: ['ai-gateway.vercel.sh', '*.vercel.com'],

6  },

7});
```

// Can reach Vercel AI Gateway and Vercel, nothing else  
// 可访问 Vercel AI 网关和 Vercel，其他均不可访问  

await sandbox.runCommand('node', ['process-data.js']);  
await sandbox.runCommand('node', ['process-data.js']);

### Adjust after initial setup  

### 初始设置后的策略调整  

Policies can be updated dynamically on a running sandbox without restarting the process. Start with full internet access to install dependencies, lock it down before executing untrusted code, reopen to stream results after user approval, and then air gap again with `deny-all`, fully in one session:  

策略可在沙箱运行期间动态更新，无需重启进程。可先开放完整互联网访问以安装依赖，执行不受信任的代码前收紧网络限制，待用户批准后再临时开放以流式传输结果，最后再次启用 `deny-all` 实现完全隔离——所有这些操作均可在单次会话中完成：

```typescript
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();



5// Phase 1: Open network, download everything we need

5// 第一阶段：开放网络，下载所有所需内容

await sandbox.runCommand('npm', ['install']);

await sandbox.runCommand('aws', ['s3', 'cp', 's3://my-bucket/input-data', './data', '--recursive']);



9// Phase 2: Lock down, only the AI gateway is reachable

9// 第二阶段：收紧网络策略，仅允许访问 AI 网关

await sandbox.updateNetworkPolicy({
```

11  allow: ['ai-gateway.vercel.sh'],

11  允许：['ai-gateway.vercel.sh']，

12});

12}）；

14// Run the untrusted / agent-driven workload in isolation

14// 在隔离环境中运行不可信的／由智能体驱动的工作负载

await sandbox.runCommand('node', ['agent.js']);

await sandbox.runCommand('node', ['agent.js']）；

17// Phase 3: Open a narrow hole to post results back

17// 第三阶段：开放一个极窄的网络通道，用于回传结果

await sandbox.updateNetworkPolicy({

await sandbox.updateNetworkPolicy（{  

19  allow: ['my-bucket.s3.amazonaws.com'],

19  允许：['my-bucket.s3.amazonaws.com']，

20});

20}）；

```javascript
await sandbox.runCommand('aws', ['s3', 'cp', './output/results.json', 's3://my-bucket/output/results.json']);
```

```javascript
await sandbox.runCommand('aws', ['s3', 'cp', './output/results.json', 's3://my-bucket/output/results.json']);
```

24// Phase 4: Lockdown Internet access

24// 第四阶段：限制互联网访问

await sandbox.updateNetworkPolicy('deny-all');

await sandbox.updateNetworkPolicy('deny-all');

Read the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/firewall) to learn more about network egress firewall policies, available on all plans.

请阅读[文档](https://vercel.com/docs/vercel-sandbox/concepts/firewall)，了解有关网络出口防火墙策略的更多信息——该功能在所有套餐中均可用。
{% endraw %}
