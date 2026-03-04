---
title: "Reminder of legacy environment variable secrets sunset - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/legacy-environment-variable-secrets-sunset-reminder"
date: "2024-04-29"
scraped_at: "2026-03-02T09:45:20.746732631+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Apr 29, 2024

2024 年 4 月 29 日

This is a reminder for legacy secrets deprecation. On **May 1st, 2024** secrets will be automatically converted to sensitive Environment Variables for Preview and Production environments. Secrets attached to Development environments **will not** be migrated.

这是关于停用旧版 Secrets 的提醒。自 **2024 年 5 月 1 日起**，Preview（预览）和 Production（生产）环境中的 Secrets 将被自动转换为敏感环境变量（Sensitive Environment Variables）。而关联至 Development（开发）环境的 Secrets **不会** 迁移。

- **Existing legacy secrets will be automatically converted.** You do not need to manually take action for non-development values. Read below to view your impacted projects.

- **现有旧版 Secrets 将被自动转换。** 对于非开发环境的值，您无需手动执行任何操作。请参阅下方内容，查看受此变更影响的项目。

- **All Environment Variables remain securely encrypted.** The majority of Vercel workloads have moved from the legacy secrets functionality.

- **所有环境变量均保持安全加密状态。** 目前，Vercel 的绝大多数工作负载已从旧版 Secrets 功能迁移完毕。

**Why are legacy secrets being sunset?**

**为何要停用旧版 Secrets？**

Our legacy secrets were encrypted values global for your entire team and could only be managed through the CLI. Based on your feedback, we have since:

我们的旧版 Secrets 是面向整个团队全局生效的加密值，且仅能通过 CLI 进行管理。根据您的反馈，我们已陆续推出以下改进：

- Made all Environment Variables encrypted by default

- 将所有环境变量默认设为加密状态

- Added [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) to prevent values from being decrypted by users

- 新增了[敏感环境变量（Sensitive Environment Variables）](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables)，以防止用户解密其值

- Added [Shared Environment Variables](https://vercel.com/docs/projects/environment-variables/shared-environment-variables) to reuse truly global values across teams

- 新增了[共享环境变量（Shared Environment Variables）](https://vercel.com/docs/projects/environment-variables/shared-environment-variables)，支持跨团队复用真正全局的值

**When will I no longer be able to use secrets?**

**我何时将无法再使用 Secrets？**

On **May 1st, 2024**, [secrets](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) will be removed from Vercel CLI:

**2024 年 5 月 1 日**起，Vercel CLI 将移除 [secrets（密钥）](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) 功能：

- Existing secrets added to the **Preview** and **Production** environments will be converted to Sensitive Environment Variables

- 已添加至 **Preview（预览）** 和 **Production（生产）** 环境的现有密钥将自动转换为敏感环境变量（Sensitive Environment Variables）。

- Existing secrets added to the **Development** environment will not be migrated for your security. If you have a secret shared between all environments, including Development, it will not be migrated. These values must be manually migrated.

- 出于安全考虑，已添加至 **Development（开发）** 环境的现有密钥将**不会被迁移**。若您存在一个在所有环境（包括 Development）中共享的密钥，该密钥同样**不会被迁移**。这些值需您**手动迁移**。

**How can I migrate to Sensitive Environment Variables?**

**如何迁移到敏感环境变量？**

Secrets for Preview and Production environments will be automatically migrated.

Preview 和 Production 环境中的密钥将**自动迁移**。

For secrets which contain the Development environment, you should create new [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables), as these values will not be automatically migrated for your security. If you need to share Environment Variables across projects, you can [make them shared](https://vercel.com/docs/projects/environment-variables/shared-environment-variables).

对于涉及 Development 环境的密钥，您应新建 [敏感环境变量](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables)，因为出于安全考虑，这些值**不会被自动迁移**。如需在多个项目间共享环境变量，您可以将其设为 [共享环境变量](https://vercel.com/docs/projects/environment-variables/shared-environment-variables)。

**How can I understand if I’m affected?**

**我该如何判断自己是否受影响？**

To list projects using secrets that will be automatically converted, run:

要列出将被自动转换密钥的项目，请运行以下命令：

Terminal

Terminal

```bash
vercel secrets ls
```

```bash
vercel secrets ls
```

View the secrets added to your Vercel teams.

查看已添加到您的 Vercel 团队中的密钥。
{% endraw %}
