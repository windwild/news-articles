---
title: "Improved CLI experience when linking and creating environment variables​​​​‌‍​‍​‍‌‍ ‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍ ‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍ ‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍‌‍‍​‌‌​‌‌​‌​​‌​​‍‍​‍ ​‍ - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-cli-experience-when-linking-and-creating-environment-variables"
date: "2025-10-05"
scraped_at: "2026-03-02T09:27:37.323531961+00:00"
language: "en-zh"
translated: true
description: "The Vercel CLI 49.0.0 introduces standardized ls error handling along with improved project linking, environment variable syncing, and more reliable --repo behavior."
---
{% raw %}

Oct 5, 2025

2025年10月5日

![](images/improved-cli-experience-when-linking-and-creating-environment-variables-vercel/img_001.jpg)

以下是 50.0.0 版本中引入的一些关键改进：

- 项目成功链接后，CLI 现在会提示您拉取该项目的环境变量（Environment Variables），以确保本地开发环境与已部署的配置保持一致。

- 在交互式输入新环境变量时，其值现在默认被掩码（masked）显示。

- 当使用 `link` 命令连接到已有项目时，若您的账户下项目数量少于 100 个，CLI 将显示一个交互式项目选择器。

- 修复了 `vc link --repo` 命令错误地为项目名称添加前缀的问题。

- 所有支持 `ls` 参数的命令现已统一行为标准：传入额外或意外的参数时，将始终输出清晰的错误信息并提前退出，从而确保所有 `ls` 类命令的结果具备可预测性与可靠性。此变更可能需要您更新此前依赖旧有行为的脚本。
{% endraw %}
