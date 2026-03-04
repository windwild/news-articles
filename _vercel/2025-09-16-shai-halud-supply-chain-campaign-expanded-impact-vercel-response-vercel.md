---
title: "Shai-Halud Supply Chain Campaign — Expanded Impact & Vercel Response - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/shai-halud-supply-chain-campaign-expanded-impact-and-vercel-response"
date: "2025-09-16"
scraped_at: "2026-03-02T09:28:24.600354068+00:00"
language: "en-zh"
translated: true
description: "Ongoing Shai-Halud npm supply chain attacks affected popular packages. Vercel responded swiftly, secured builds, and notified impacted users."
---
{% raw %}

Sep 16, 2025

2025 年 9 月 16 日

## Summary

## 概述

**Shai-Halud** 供应链攻击活动已升级。此次事件最初源于 Qix 攻击，影响了约 18 个核心 npm 包（如 `chalk`、`debug`、`ansi-styles` 等），此后进一步扩散：

- 又有超过 40 个额外包通过 Tinycolor “蠕虫”向量遭到攻击。

- CrowdStrike / `crowdstrike-publisher` 命名空间亦遭入侵，并发布了多个被植入木马的版本。

- DuckDB 维护者账号（`duckdb_admin`）发布了恶意版本，所用钱包盗取恶意软件与 Qix 事件中使用的完全一致。该 DuckDB 子事件未影响任何 Vercel 客户。


## Impact to Vercel Customers

## 对 Vercel 客户的影响

- 我们识别出 **共计 10 个** Vercel 客户项目，其构建过程（直接或间接）依赖于受感染的包版本。

- 已通知受影响的客户，并为其提供了面向具体项目的应对指导。

- 在 DuckDB 事件中，没有任何 Vercel 客户的构建受到影响。

## What We Did

## 我们已采取的措施

|     |     |
| --- | --- |
| **Action** | **Status** |
| **操作** | **状态** |
| Blocklisted known compromised versions from the Tinycolor, CrowdStrike, Qix, and DuckDB-affected packages | ✅ Completed |
| 将已知受侵害版本从 Tinycolor、CrowdStrike、Qix 和受 DuckDB 影响的软件包中加入黑名单 | ✅ 已完成 |
| Purged build caches for Vercel projects using those versions | ✅ Completed for impacted projects |
| 清除了使用上述版本的 Vercel 项目的构建缓存 | ✅ 已对受影响项目完成 |
| Coordinated safe rebuilds with clean dependencies / pinned safe versions | ✅ In progress / completed for impacted ones |
| 协调执行安全重建，使用干净的依赖项或固定的安全版本 | ✅ 正在进行中 / 已对受影响项目完成 |
| Raised platform alerting & detection thresholds for new package publishes matching the Shai-Halud indicators | ✅ Elevated monitoring active |
| 提高平台告警与检测阈值，以识别新发布的、符合 Shai-Halud 特征的软件包 | ✅ 增强监控已启用 |

## What We’re Watching & Doing

## 我们正在关注与开展的工作

- Working closely with npm, open-source maintainers, and ecosystem security partners to track any further spread of Shai-Halud.

- 正与 npm、开源维护者及生态安全合作伙伴紧密协作，追踪 Shai-Halud 的任何进一步扩散。

- Enhancing our supply chain defenses so that

**deployments on Vercel remain secure by default**

: stricter policies on lifecycle/postinstall scripts, lockfile hygiene, and registry validation.

- 加强供应链防御能力，确保：

**Vercel 上的部署默认即安全**

：对生命周期脚本（lifecycle scripts）/ 安装后脚本（postinstall scripts）、锁文件（lockfile）规范性以及注册表（registry）校验实施更严格策略。

- Tightening internal CI/CD controls and developer tooling to catch suspicious package behavior early.

- 加强内部 CI/CD 控制与开发者工具链，以便尽早发现可疑的软件包行为。

## Recommendations for Vercel Users

## 给 Vercel 用户的建议

- For teams using pnpm, consider enabling the new [`minimumReleaseAge`](https://pnpm.io/blog/releases/10.16#new-setting-for-delayed-dependency-updates) setting introduced in pnpm 10.16 to delay dependency updates (e.g., 24 hours). This helps reduce risk from compromised versions that are discovered and removed shortly after publishing.

- 对于使用 pnpm 的团队，建议启用 pnpm 10.16 中引入的新配置项 [`minimumReleaseAge`](https://pnpm.io/blog/releases/10.16#new-setting-for-delayed-dependency-updates)，以延迟依赖项更新（例如延迟 24 小时）。此举有助于降低风险——某些被攻陷的版本可能在发布后不久即被发现并下架。

- Audit your dependencies (direct & transitive) to check for packages from these affected namespaces.  
- 审查您的依赖项（包括直接依赖和传递依赖），检查是否存在来自上述受影响命名空间的软件包。

- Rebuild with pinned safe versions and clean lockfiles (`pnpm ci`).  
- 使用固定的安全版本重新构建，并清理锁文件（`pnpm ci`）。

- Rotate any npm / GitHub / CI/CD tokens that may have been used in environments where compromised dependencies were present.  
- 轮换所有可能已在存在被入侵依赖项的环境中使用过的 npm / GitHub / CI/CD 凭据（token）。

- Inspect GitHub repos for unauthorized workflows or unexpected `.github/workflows` additions.  
- 检查 GitHub 仓库中是否存在未授权的工作流，或意外新增的 `.github/workflows` 文件。

- Enforce least privilege (especially in automated workflows), and limit lifecycle script permissions.  
- 强制实施最小权限原则（尤其在自动化工作流中），并限制生命周期脚本（lifecycle script）的权限。

## Timeline  
## 时间线

- **September 8, 2025**  
- **2025 年 9 月 8 日**

— Qix / Tinycolor / core package compromise discovered.  
— 发现 Qix / Tinycolor / core 等软件包遭入侵。

- **September 9, 2025**  
- **2025 年 9 月 9 日**

— DuckDB issue identified.  
— 确认 DuckDB 相关问题。

- **September 15–16, 2025**

- **2025 年 9 月 15–16 日**

— CrowdStrike / Tinycolor “worm” style propagation detected; Vercel detection expanded.

— 检测到 CrowdStrike / Tinycolor 类“蠕虫式”传播；Vercel 检测能力已扩展。

- **September 16, 2025**

- **2025 年 9 月 16 日**

— Customer notifications, cache purges, safe rebuilds underway.

— 客户通知、缓存清理及安全重建工作正在进行中。

## References

## 参考资料

- [Socket: Tinycolor supply chain attack affects 40+ packages](https://socket.dev/blog/tinycolor-supply-chain-attack-affects-40-packages)

- [Socket：Tinycolor 供应链攻击影响 40 多个软件包](https://socket.dev/blog/tinycolor-supply-chain-attack-affects-40-packages)

- [Socket: Ongoing supply chain attack targets CrowdStrike npm packages](https://socket.dev/blog/ongoing-supply-chain-attack-targets-crowdstrike-npm-packages)

- [Socket：持续进行的供应链攻击针对 CrowdStrike 的 npm 软件包](https://socket.dev/blog/ongoing-supply-chain-attack-targets-crowdstrike-npm-packages)

- [Aikido Security: Qix / core package analysis](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised)

- [Aikido Security：Qix / core 软件包分析](https://www.aikido.dev/blog/npm-debug-and-chalk-packages-compromised)

- [Nx Advisory: s1ngularity attack](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)

- [Nx 安全通告：s1ngularity 攻击](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)
{% endraw %}
