---
title: "Vercel CLI v28 is now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-v28"
date: "2022-08-12"
scraped_at: "2026-03-02T10:01:02.946915519+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Aug 12, 2022

2022 年 8 月 12 日

![](images/vercel-cli-v28-is-now-available-vercel/img_001.jpg)

Vercel CLI 28.0.0 版本现已发布。以下是过去几个月中完成的一些关键改进：

- 如果您已配置了 Git 代码托管平台（如 GitHub、GitLab 等）的仓库，Vercel CLI 在执行 `vercel link` 设置流程时，将提示您是否要将该仓库关联至当前 Project。［[28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)］（**注意**：此功能已在 ［[28.1.4](https://github.com/vercel/vercel/releases/tag/vercel%4028.1.4)］ 版本中回退）

- 新增命令 `vercel git`，支持通过 Vercel CLI 直接基于 Git 设置自动部署。请在已初始化 Git 仓库的目录中运行 `vercel git connect` 开始使用。［[27.1.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.1.0)］

- 此前，即使本地已配置 Git 仓库，Vercel CLI 发起的部署也不会包含 Git 元数据；现在，所有通过 Vercel CLI 创建的部署均会自动附带 Git 元数据。［[25.2.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.2.0)］

- 现在运行 `vercel env pull` 时，若现有 `.env*` 文件发生了变更，Vercel CLI 将明确列出被新增、修改及删除的环境变量。［[27.3.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.3.0)］

- `vercel ls` 和 `vercel project ls` 命令的输出界面已全面优化；同时，`vc ls` 命令现仅作用于当前已关联（linked）的 Project。［[28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)］

### 值得关注的变更

- 已停止对 Node.js 12 的支持。［[25.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.0.0)］

- Removed `vercel billing` command \[ [28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)\]

- 移除了 `vercel billing` 命令 \[ [28.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)\]

- Removed auto clipboard copying in `vercel deploy` \[ [27.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.0.0)\]

- 移除了 `vercel deploy` 中的自动剪贴板复制功能 \[ [27.0.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.0.0)\]

- Deprecated `--confirm` in favor of `--yes` to skip prompts throughout Vercel CLI \[ [27.4.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.4.0)\]

- 已弃用 `--confirm`，改用 `--yes` 以在 Vercel CLI 全局跳过交互提示 \[ [27.4.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.4.0)\]

- Added support for Edge Functions in `vercel dev` \[ [25.2.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.2.0)\]

- 在 `vercel dev` 中新增对 Edge Functions 的支持 \[ [25.2.0](https://github.com/vercel/vercel/releases/tag/vercel%4025.2.0)\]

- Added support for importing `.wasm` in `vercel dev` \[ [27.3.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.3.0)\]

- 在 `vercel dev` 中新增对导入 `.wasm` 文件的支持 \[ [27.3.0](https://github.com/vercel/vercel/releases/tag/vercel%4027.3.0)\]


Note this batch of updates includes breaking changes. Check out the [full release notes](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0) to learn more.

请注意，本次更新包含破坏性变更。详情请参阅 [完整发布说明](https://github.com/vercel/vercel/releases/tag/vercel%4028.0.0)。
&#123;% endraw %}
