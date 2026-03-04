---
title: "Improvements to Vercel Toolbar: Shrinking when inactive, removal of avatars, and more - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-to-vercel-toolbar"
date: "2024-09-19"
scraped_at: "2026-03-02T09:41:10.351265114+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Sep 19, 2024

2024 年 9 月 19 日

我们对 Vercel Toolbar 进行了多项优化，确保它在您需要时随时可用，而在不需要时则保持低调、不干扰：

- **非活跃状态下自动收缩：** 收缩后的工具栏仅显示评论、分享（或标记）及菜单图标；鼠标悬停时将展开为完整工具栏。您可在工具栏菜单的“偏好设置（Preferences）”中关闭此收缩功能。

- **不再显示团队成员头像：** 我们移除了曾访问过该部署的团队成员头像。此举减少了视觉干扰，也降低了工具栏在网络（Network）标签页中的存在感。

- **支持常规文本选择：** 工具栏不再为选中文本添加自定义高亮，也不会在文本被选中时自动打开评论线程编辑器。取而代之的是，它会在选中文本旁显示一个小型评论指示符，点击该指示符即可开始为所选文本撰写评论。

如需快速切换工具栏显示/隐藏状态，您可在 macOS 上使用 `⌘ + .` 快捷键，或在 Windows 上使用 `Ctrl + .` 快捷键。您还可以将工具栏拖拽至页面任意一侧（左/右），它将在下次加载时记住并从该侧展开。

有关 [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) 的更多信息，请参阅官方文档。