---
render_with_liquid: false
title: "Safely inject credentials in HTTP headers with Vercel Sandbox - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/safely-inject-credentials-in-http-headers-with-vercel-sandbox"
date: "2026-02-23"
scraped_at: "2026-03-02T09:21:25.662238766+00:00"
language: "en-zh"
translated: true
description: "Sandbox network policies now support HTTP header injection to prevent secrets exfiltration by untrusted code"
---
render_with_liquid: false
render_with_liquid: false

Feb 23, 2026

2026 年 2 月 23 日

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 现在可自动将 HTTP 请求头注入沙盒代码发出的出站请求中。此举可确保 API 密钥和令牌安全地保留在沙盒虚拟机边界之外，从而使沙盒内运行的应用程序无需直接访问凭据，即可调用需身份验证的服务。

请求头注入通过网络策略中的 `transform` 配置实现。当沙盒向匹配的域名发起 HTTPS 请求时，防火墙会在转发请求前添加或替换指定的请求头。

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



16// 沙箱内部的代码在调用 AI Gateway 时，无需知晓 API 密钥

const result = await sandbox.runCommand('curl',

18  ['-s', 'https://ai-gateway.vercel.sh/v1/models']

19);
```

该设计面向 AI Agent 工作流，其中提示注入（prompt injection）是一种真实存在的威胁。即使 Agent 被攻破，也无敏感信息可被窃取，因为凭据仅存在于虚拟机（VM）外部的独立层级中。

![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_001.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_002.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_003.jpg)![](images/safely-inject-credentials-in-http-headers-with-vercel-sandbox-vercel/img_004.jpg)

注入规则与所有出口网络策略（egress network policy）配置兼容，包括开放互联网访问。若需在允许通用网络流量的同时，仅为特定服务注入凭据，可按如下方式配置：

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

18      // 允许流向所有其他域名的流量。

19      "*": []

20    }

21  }

22});
```

### 实时更新

### Live updates

Like all network policy settings, injection rules can be updated on a running sandbox without restarting it. This enables multi-phase workflows, inject credentials during setup, then remove them before running untrusted code:

像所有网络策略设置一样，注入规则可以在沙箱运行过程中动态更新，而无需重启沙箱。这支持多阶段工作流：在初始化阶段注入凭据，然后在执行不可信代码前将其移除：

```typescript
1// Phase 1: Clone repos with credentials

1// 第一阶段：使用凭据克隆代码仓库

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

14// …… 克隆代码仓库、下载数据 ……
```

16// Phase 2: Lock down before running untrusted code

16// 第二阶段：运行不可信代码前锁定环境

await sandbox.updateNetworkPolicy('deny-all');
```

### Key highlights

### 主要特性

- Header overwrite: Injection applies to HTTP headers on outbound requests.

- 头部覆盖：注入操作作用于出站请求的 HTTP 头部。

- Full replacement: Injected headers overwrite any existing headers with the same name set by sandbox code, preventing the sandbox from substituting its own credentials.

- 完全替换：注入的头部将完全覆盖沙箱代码中已设置的、同名的现有头部，从而阻止沙箱替换其自身的凭据。

- Domain matching: Supports exact domains and wildcards (e.g., \*.github.com). Injection only triggers when the outbound request matches.

- 域名匹配：支持精确域名及通配符（例如 `*.github.com`）；仅当出站请求匹配指定域名时，注入才会触发。

- Works with all policies: Combine injection rules with `allow-all`, or domain-specific allow lists.

- 兼容所有网络策略：可将注入规则与 `allow-all` 策略或基于域名的允许列表结合使用。

Available to all Pro and Enterprise customers. Learn more in the [documentation](https://vercel.com/docs/vercel-sandbox/concepts/firewall#credentials-brokering).

面向所有 Pro 和 Enterprise 用户开放。详情请参阅[文档](https://vercel.com/docs/vercel-sandbox/concepts/firewall#credentials-brokering)。