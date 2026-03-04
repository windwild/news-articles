---
render_with_liquid: false
title: "Critical npm supply chain attack response - September 8, 2025 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/critical-npm-supply-chain-attack-response-september-8-2025"
date: "2025-09-08"
scraped_at: "2026-03-02T09:28:52.828055802+00:00"
language: "en-zh"
translated: true
description: "How Vercel responded to the September 2025 npm supply chain attack on chalk, debug and 16 other packages. Incident timeline, impact analysis, and customer remediation."
---
render_with_liquid: false
render_with_liquid: false

Sep 8, 2025

2025 年 9 月 8 日

On September 9, 2025, the campaign extended to DuckDB-related packages after the `duckdb_admin` account was breached. These releases contained the same wallet-drainer malware, confirming this was part of a coordinated effort targeting prominent npm maintainers.

2025 年 9 月 9 日，攻击活动在 `duckdb_admin` 账户遭入侵后蔓延至与 DuckDB 相关的软件包。这些被发布的版本均包含相同的“钱包窃取器”（wallet-drainer）恶意软件，证实此次事件是针对知名 npm 维护者的协同式攻击行动的一部分。

While Vercel customers were not impacted by the DuckDB incident, we continue to track activity across the npm ecosystem with our partners to ensure deployments on Vercel remain secure by default.

尽管 Vercel 客户未受此次 DuckDB 事件影响，我们仍正与合作伙伴协同持续监控整个 npm 生态系统中的异常活动，以确保部署在 Vercel 上的应用默认保持安全。

## Overview

## 概述

On September 8, 2025, a [supply chain attack compromised 18 popular npm packages](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised) including `chalk`, `debug`, and `ansi-styles`. The injected code was designed to intercept cryptocurrency transactions in browsers.

2025 年 9 月 8 日，一场[供应链攻击导致 18 个热门 npm 软件包](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised)被入侵，其中包括 `chalk`、`debug` 和 `ansi-styles`。注入的恶意代码旨在拦截浏览器中的加密货币交易。

Our security and engineering teams identified all affected Vercel projects in the initial compromise and purged build caches. Impacted customers were notified with [specific guidance](https://vercel.com/blog/critical-npm-supply-chain-attack-response-september-8-2025#recommendations). No Vercel customers were affected in the DuckDB incident.

我们的安全与工程团队在初始入侵发生后迅速识别出所有受影响的 Vercel 项目，并清除了构建缓存。受影响客户已收到附带[具体应对建议](https://vercel.com/blog/critical-npm-supply-chain-attack-response-september-8-2025#recommendations)的通知。在 DuckDB 事件中，无任何 Vercel 客户受到影响。

## Impact

## 影响范围

The malicious code injected into these packages:

注入至上述软件包中的恶意代码：

- Executed in client-side browsers when bundled into web applications

- 在被打包进 Web 应用后，于客户端浏览器中执行；

- Intercepted cryptocurrency and web3 wallet interactions

- 拦截加密货币交易及 Web3 钱包交互。

- 重定向支付目的地至攻击者控制的地址


分析发现，共有 70 个 Vercel 团队在 76 个独立项目中构建了包含受感染包版本的应用。

## 解决方案

我们的事件响应团队采取了以下措施：

1. **通过部署依赖追踪系统识别所有受影响项目**

2. **清除了全部 76 个独立受影响项目的构建缓存**，以防止恶意代码被分发

3. **向受影响客户发出通知**，并提供需重新构建的具体项目清单


该恶意包版本已从 npm 中移除。在我们清除缓存后重新构建的项目，将使用干净的包版本。

## 时间线

- 首次报告 npm 包中存在恶意活动

- **17:39 UTC** — Vercel incident response activated  
- **17:39 UTC** — Vercel 启动事件响应

- **22:19 UTC** — Build caches purged for affected projects  
- **22:19 UTC** — 已为受影响的项目清除构建缓存


## Technical details  

## 技术细节  

The attack originated from a phishing campaign targeting npm package maintainers. The attacker used the domain `npmjs.help` (now taken down) to harvest credentials through a convincing two-factor authentication update email:  
此次攻击源于一场针对 npm 包维护者的钓鱼活动。攻击者使用域名 `npmjs.help`（现已下线），通过一封极具迷惑性的双因素认证更新邮件窃取用户凭据：

![](images/critical-npm-supply-chain-attack-response-september-8-2025-vercel/img_001.jpg)

The email created false urgency with a 48-hour deadline, claiming accounts would be locked starting September 10, 2025. We strongly encourage npm package authors to look out for this attack pattern and verify any security-related emails by navigating directly to [npmjs.com](https://www.npmjs.com/) rather than clicking email links.  
该邮件制造了虚假的紧急感，声称用户账户将于 2025 年 9 月 10 日起被锁定，限期仅剩 48 小时。我们强烈建议 npm 包作者提高警惕，识别此类攻击模式；如收到任何与安全相关的邮件，请务必通过手动输入网址访问 [npmjs.com](https://www.npmjs.com/) 进行核实，切勿直接点击邮件中的链接。


## Recommendations  

## 建议措施  

**For affected customers:**  
**针对受影响的客户：**  

- Rebuild projects listed in our notification email  
- 重新构建通知邮件中所列的项目  

- Review your dependency update practices  
- 审查您的依赖项更新流程

- Consider implementing package version pinning

- 考虑实施软件包版本固定（package version pinning）

**For all customers:**

**面向所有客户：**

- Use `npm audit` to check for known vulnerabilities

- 使用 `npm audit` 检查已知漏洞

- Implement dependency scanning in CI/CD pipelines

- 在 CI/CD 流水线中实施依赖项扫描

- Consider using `npm ci` with lockfiles in production builds

- 在生产环境构建中考虑结合 lockfile 使用 `npm ci`

- Enable npm package provenance where available

- 在支持的情况下启用 npm 软件包来源验证（package provenance）

## Prevention measures

## 预防措施

We continue to strengthen our supply chain security posture:

我们持续强化供应链安全防护能力：

- Enhanced monitoring for suspicious package updates

- 加强对可疑软件包更新的监控

- Improved tooling for rapid cache invalidation during incidents

- 优化工具链，以在安全事件发生时快速使缓存失效

This incident reinforces the importance of defense-in-depth strategies for supply chain security. While we cannot prevent all upstream compromises, we can minimize impact through rapid detection and response.

此次事件再次凸显了在供应链安全中实施纵深防御策略的重要性。尽管我们无法完全杜绝上游环节的入侵，但可通过快速检测与响应将影响降至最低。

## Credit

## 致谢

Thanks to Aikido Security for early detection and the npm community's rapid response in addressing the compromised packages.

感谢 Aikido Security 的早期发现，以及 npm 社区在应对被入侵软件包时所展现出的快速响应能力。

## References

## 参考资料

- [GitHub Advisory Database](https://github.com/advisories/GHSA-8mgj-vmr8-frr6)

- [GitHub 安全通告数据库](https://github.com/advisories/GHSA-8mgj-vmr8-frr6)

- [qik Socket Security Analysis](https://socket.dev/blog/npm-author-qix-compromised-in-major-supply-chain-attack)

- [qik 的 Socket 安全分析报告](https://socket.dev/blog/npm-author-qix-compromised-in-major-supply-chain-attack)

- [DuckDB Socket Security Analysis](https://socket.dev/blog/duckdb-npm-account-compromised-in-continuing-supply-chain-attack)

- [DuckDB 的 Socket 安全分析报告](https://socket.dev/blog/duckdb-npm-account-compromised-in-continuing-supply-chain-attack)

- [Aikido blog](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised)

- [Aikido 博客](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised)

_For questions about this incident, please contact_ [_security@vercel.com_](mailto:security@vercel.com)

如需了解本次事件的相关问题，请联系 [_security@vercel.com_](mailto:security@vercel.com)