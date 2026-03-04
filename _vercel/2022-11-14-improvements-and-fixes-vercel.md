---
title: "Improvements and fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/november-2022"
date: "2022-11-14"
scraped_at: "2026-03-02T09:59:50.840111853+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Nov 14, 2022

2022年11月14日

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

![](images/improvements-and-fixes-vercel/img_001.jpg)![](images/improvements-and-fixes-vercel/img_002.jpg)

With your feedback, we've shipped dozens of bug fixes and small feature requests to improve your product experience.

在您的反馈推动下，我们已发布数十项缺陷修复及小型功能更新，以持续优化您的产品使用体验。

- **Vercel CLI:** [**28.5.0**](https://github.com/vercel/vercel/releases/tag/vercel%4028.5.0) 版本已发布，其中增强了 `vc build` 对单体仓库（monorepo）的支持。

- **通过环境变量禁用构建缓存：** 现在您可通过在项目设置中配置 `VERCEL_FORCE_NO_BUILD_CACHE` [环境变量](https://vercel.com/docs/concepts/deployments/troubleshoot-a-build#managing-build-cache)，强制 Git 触发的构建跳过构建缓存。

- **环境变量数量上限提升：** Vercel 上每个部署现在最多可支持 1000 个环境变量，而非此前的仅 100 个。

- **Vercel 控制台 UI：** 主导航栏与次级导航栏现已扩展为全宽布局，使各页面 UI 可灵活选择保持最大宽度，或充分利用整个视口空间。

- **Vercel 菜单组件：** 控制台中的菜单下拉面板在桌面端已略微精简，并优化了动画效果，提升了对比度与信息密度。

- **Vercel 文档中的代码展示优化：** 代码块现均以文件路径作为标题（header）显示。

- **Vercel 文档中的视觉效果优化：** 我们现已支持动态适配深色/浅色模式的截图。
{% endraw %}
