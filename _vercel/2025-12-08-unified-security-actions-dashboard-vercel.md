---
title: "Unified security actions dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/unified-security-actions-dashboard"
date: "2025-12-08"
scraped_at: "2026-03-02T09:24:16.438013880+00:00"
language: "en-zh"
translated: true
description: "A new unified dashboard for Vercel’s platform, infrastructure, and agent systems, which continuously monitor for vulnerabilities and configuration issues that require attention."
---
{% raw %}

Dec 8, 2025

2025 年 12 月 8 日

Vercel 现已提供 [统一的安全操作仪表板](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard)，集中呈现贵团队需立即处理的所有安全问题。当检测到高危漏洞或与安全相关的待办任务时，该仪表板将自动归类受影响的项目，并引导您完成加固所需的具体步骤。

![](images/unified-security-actions-dashboard-vercel/img_001.jpg)![](images/unified-security-actions-dashboard-vercel/img_002.jpg)

只要存在待处理事项，此视图即以横幅形式自动显示；您亦可随时通过仪表板内的搜索功能访问该页面。

绝大多数 CVE 漏洞已通过 WAF 规则及其他防护机制自动处理；但当需要用户主动干预时，相关事项将在此处集中呈现。

- **需人工介入的安全漏洞自动识别 —** 当平台发现某项漏洞或配置无法完全通过 Vercel 的自主防护机制缓解时，便会在此处清晰列出，并附上明确的操作指引。

- **按所需操作类型对项目进行分组 —** 当前分类包括：未修复的依赖项、需手动修复、未受保护的预览部署（Preview Deployments）。随着新防护能力与检查项陆续上线，未来还将新增更多分组类别。

- **支持自动化修复 —** 在可行情况下，[Vercel Agent 可提供一键式自动升级及拉取请求（PR）](https://vercel.com/changelog/automated-react2shell-vulnerability-patching-is-now-available)。

- **支持手动修复 —** 对于必须手动更新、或暂无 GitHub 访问权限的场景，我们提供直接可用的指令，例如：`npx fix-react2shell-next`

### 以更少投入，实现更高安全水位

### 以更少投入，实现更高安全水位

The unified dashboard helps teams act quickly during critical moments, consolidate required fixes in one place, and maintain a stronger security posture across all projects.

统一仪表板帮助团队在关键时刻快速响应，将所需的修复措施集中于一处，并在所有项目中维持更强大的安全态势。

Explore the dashboard to [view any required updates](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard).

探索该仪表板以[查看任何必需的更新](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Ffixes&title=View+Security+Actions+Dashboard)。
{% endraw %}
