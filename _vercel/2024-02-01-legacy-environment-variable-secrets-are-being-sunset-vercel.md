---
title: "Legacy environment variable secrets are being sunset - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/legacy-environment-variable-secrets-are-being-sunset"
date: "2024-02-01"
scraped_at: "2026-03-02T09:48:14.726198419+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Feb 1, 2024

2024 年 2 月 1 日

Legacy [secrets](https://vercel.com/docs/cli/secrets) are being sunset in favor of [Sensitive Environment Variables](https://vercel.com/changelog/sensitive-environment-variables-are-now-available), which are now [shareable across projects](https://vercel.com/docs/projects/environment-variables/shared-environment-variables).

旧版 [密钥（secrets）](https://vercel.com/docs/cli/secrets) 正在逐步停用，取而代之的是 [敏感环境变量（Sensitive Environment Variables）](https://vercel.com/changelog/sensitive-environment-variables-are-now-available)，后者现已支持 [跨项目共享](https://vercel.com/docs/projects/environment-variables/shared-environment-variables)。

- **Existing legacy secrets will be automatically converted.** You do not need to manually take action for non-development values. Read below to view your impacted projects.

- **现有旧版密钥将自动转换。** 对于非开发环境的值，您无需手动操作。请参阅下方内容，查看受此变更影响的项目。

- **All Environment Variables remain securely encrypted.** The majority of Vercel workloads have moved from the legacy secrets functionality.

- **所有环境变量仍保持安全加密。** 目前，Vercel 的大部分工作负载已从旧版密钥功能迁移完毕。

On **May 1st, 2024** secrets will be automatically converted to sensitive Environment Variables for Preview and Production environments. Secrets attached to Development environments **will not** be migrated.

自 **2024 年 5 月 1 日起**，预览（Preview）和生产（Production）环境中的密钥将自动转换为敏感环境变量；而绑定至开发（Development）环境的密钥 **不会** 迁移。

**Why are legacy secrets being sunset?**

**为何停用旧版密钥？**

Our legacy secrets were encrypted values global for your entire team and could only be managed through the CLI. Based on your feedback, we have since:

我们的旧版密钥是面向整个团队全局生效的加密值，且仅能通过命令行界面（CLI）进行管理。根据您的反馈，我们已陆续实现以下改进：

- Made all Environment Variables encrypted by default

- 将所有环境变量默认设为加密状态；

- Added [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables) to prevent values from being decrypted by users

- 新增 [敏感环境变量（Sensitive Environment Variables）](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables)，防止用户解密其值；

- Added [Shared Environment Variables](https://vercel.com/docs/projects/environment-variables/shared-environment-variables) to reuse truly global values across teams

- 新增 [共享环境变量（Shared Environment Variables）](https://vercel.com/docs/projects/environment-variables/shared-environment-variables)，支持跨团队复用真正全局的值。

**When will I no longer be able to use secrets?**

**我何时将无法再使用 secrets？**

On **May 1st, 2024**, [secrets](https://vercel.com/docs/cli/secrets) will be removed from Vercel CLI:

2024 年 5 月 1 日，[secrets](https://vercel.com/docs/cli/secrets) 将从 Vercel CLI 中移除：

- Existing secrets added to the **Preview** and **Production** environments will be converted to Sensitive Environment Variables

- 已添加至 **预览（Preview）** 和 **生产（Production）** 环境的现有 secrets 将被自动转换为敏感环境变量（Sensitive Environment Variables）；

- Existing secrets added to the **Development** environment will not be migrated for your security. If you have a secret shared between all environments, including Development, it will not be migrated. These values must be manually migrated.

- 出于安全考虑，已添加至 **开发（Development）** 环境的现有 secrets 将不会被迁移。若您有一个在所有环境（包括 Development）间共享的 secret，则该 secret 也不会被迁移。这些值需由您手动迁移。

**How can I migrate to Sensitive Environment Variables?**

**如何迁移到敏感环境变量（Sensitive Environment Variables）？**

Secrets for Preview and Production environments will be automatically migrated.

预览（Preview）和生产（Production）环境中的 secrets 将被自动迁移。

For secrets which contain the Development environment, you should create new [Sensitive Environment Variables](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables), as these values will not be automatically migrated for your security. If you need to share Environment Variables across projects, you can [make them shared](https://vercel.com/docs/projects/environment-variables/shared-environment-variables).

对于包含开发（Development）环境的 secrets，您应新建 [敏感环境变量（Sensitive Environment Variables）](https://vercel.com/docs/projects/environment-variables/sensitive-environment-variables)，因为出于安全考虑，这些值不会被自动迁移。如需在多个项目间共享环境变量，您可以将其设为 [共享环境变量（shared environment variables）](https://vercel.com/docs/projects/environment-variables/shared-environment-variables)。

**How can I understand if I’m affected?**

**我该如何判断自己是否受影响？**

To list projects using secrets that will be automatically converted, run:

要列出将被自动转换 secrets 的项目，请运行以下命令：

Terminal

终端

```bash
vercel secrets ls
```

查看已添加到您的 Vercel 团队中的密钥。