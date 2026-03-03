---
title: "s1ngularity: supply chain attack in Nx packages - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/s1ngularity-supply-chain-attack-in-nx-packages"
date: "2025-08-27"
scraped_at: "2026-03-02T09:29:18.799594363+00:00"
language: "en-zh"
translated: true
description: "A critical vulnerability was published in Nx and some of its supporting libraries. Vercel builds are safe from this vulnerability by default."
---

Aug 27, 2025

2025 年 8 月 27 日

威胁行为者向 npm 注册表发布了经篡改的 Nx 包及其部分配套库的版本，旨在窃取开发者和服务凭证。

**Vercel 上的构建默认不受此漏洞影响。** [请访问 GitHub 安全通告页面](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)以确认您的本地环境或其他 CI 环境是否受到影响。

## 概述

Summary

一个恶意版本的 Nx 包及部分 Nx 生态系统库，于美国东部时间 2025 年 8 月 26 日晚上 6:32 起，通过被盗用的 npm Token 发布至 npm 注册表。Nx 团队已于同日美国东部时间晚上 10:44 将受感染的包从 npm 注册表中全部下架。

受影响的包包含一个 `postinstall` 脚本：该脚本在安装受感染包时，利用大语言模型（LLM）扫描用户本地文件系统，以窃取密钥和凭证。被窃取的密钥将以编码字符串形式，提交至由该脚本在受害者 GitHub 账户下自动创建的一个新仓库中。欲了解更多信息，请参阅 [Nx 团队在 GitHub 上发布的安全通告](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)。

## 对 Vercel 客户的影响

Impact for Vercel customers

默认情况下，Vercel 客户不受此事件影响；仅当客户主动采取特定操作、利用构建容器的灵活性时，才可能受到这些被攻陷的 Nx 包的影响。

要使 `postinstall` 脚本成功从 Vercel 构建环境中窃取数据，需同时满足以下四个条件：

- 该脚本使用 GitHub CLI（`gh`）获取 GitHub Token。而 GitHub CLI 默认并未预装在 Vercel 的构建容器中。若要在构建过程中使用 GitHub CLI，则必须将其作为用户自定义构建流程的一部分显式安装。

- The script requires a GitHub authentication token to be present on the machine invoking the GitHub CLI. The Vercel build container does not contain customer GitHub tokens by default. For the GitHub token to be present in your build, it must be added to the build container as part of your user-defined build process.

- 该脚本要求运行 GitHub CLI 的机器上已配置 GitHub 认证令牌（authentication token）。Vercel 构建容器默认不包含客户持有的 GitHub 令牌。若需在构建过程中使用该令牌，您必须将其作为自定义构建流程的一部分，显式添加至构建容器中。

- The script depends on the machine having at least one of the Claude Code (`claude`), Gemini (`gemini`), or Q (`q`) CLIs installed. The Vercel build container does not have any of these installed by default. For any of these CLIs to be present in your build, they must be installed as part of your user-defined build process.

- 该脚本依赖于机器上至少已安装以下任一命令行工具：Claude Code（`claude`）、Gemini（`gemini`）或 Q（`q`）。Vercel 构建容器默认未预装上述任一 CLI。若需在构建中使用其中任一工具，您必须将其作为自定义构建流程的一部分进行安装。

- A build must have installed a compromised version of Nx or Nx ecosystem packages.

- 构建过程必须曾安装过遭篡改的 Nx 或 Nx 生态系统相关软件包。

We did not identify any builds on Vercel meeting this pattern. We encourage you to evaluate other environments, local and cloud, that may have been vulnerable to this attack.

我们未在 Vercel 平台上识别出符合该模式的任何构建任务。我们建议您评估其他可能受此攻击影响的环境，包括本地开发环境及各类云平台环境。

## Resolution

## 应对措施

New builds will not be able to download the affected packages. The Nx team has removed affected packages from npm, and we have purged the [build caches](https://vercel.com/docs/glossary#build-cache) for any projects that contained affected packages in their dependencies during a build.

新构建任务将无法下载受影响的软件包。Nx 团队已从 npm 中下架所有受影响的软件包；同时，我们已清除了所有在构建过程中其依赖项中包含受影响软件包的项目的 [构建缓存](https://vercel.com/docs/glossary#build-cache)。

Additionally, we've notified a small number of users who installed one or more of the malicious packages during a build. Vercel team owners should check for an email titled "s1ngularity: supply chain attack in Nx packages" from security@vercel.com.

此外，我们已向一小部分在构建过程中安装过一个或多个恶意软件包的用户发送了通知。Vercel 团队所有者请查收来自 `security@vercel.com` 的邮件，标题为：“s1ngularity: supply chain attack in Nx packages”（“s1ngularity：Nx 软件包供应链攻击”）。

## References

## 参考资料

- [GitHub advisory from Nx](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)

- [Nx 团队发布的 GitHub 安全通告](https://github.com/nrwl/nx/security/advisories/GHSA-cxm3-wv7p-598c)