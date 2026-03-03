---
title: "December 2019 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-december-2019"
date: "2019-12-01"
scraped_at: "2026-03-02T10:07:14.039236935+00:00"
language: "en-zh"
translated: true
description: "Vercel's changelog for December 2019"
---

Dec 1, 2019

2019 年 12 月 1 日

## Deployments

## 部署

- 通过 Git 创建的 Next.js 部署不再渲染调试日志。

- 每个部署页面上现有的“Functions”（函数）标签页，现默认显示所有 Serverless 函数的请求信息。

- Node.js 8 已进入 [生命周期终止阶段（EOL）](https://nodejs.org/en/about/releases/)。今后使用 Node.js 8.10.x 的新部署将在部署日志中打印警告，并将于 **2020 年 1 月 6 日起** 构建失败。

## Domains

## 域名

- 缩短了简短域名（shortened domain）的 TXT 验证记录长度至 10 个字符。

- 域名重定向（Domain Redirects）现已支持 Internet Explorer。

- 若您在 `now.json` 中使用 `alias` 属性配置域名，而非在控制台的“Domains”（域名）标签页中进行配置，系统现在会向您显示相应提示建议。

- 购买域名时，现可在购买流程中直接添加信用卡，无需跳转至单独页面。

- Clicking "Buy" on the dashboard's "Domains" tab now retains the active team.  
- 在控制台的“域名（Domains）”标签页中点击“购买（Buy）”按钮，现在将保持当前激活的团队。

- After purchasing a Domain, you will now be taken to the "Domains" tab on the dashboard, instead of the documentation.  
- 购买域名后，您现在将被重定向至控制台的“域名（Domains）”标签页，而非文档页面。

- Just like on the "Domains" tab on the dashboard, the `alias` property in `now.json` can now contain up to 50 Domains.  
- 与控制台“域名（Domains）”标签页一致，`now.json` 中的 `alias` 属性现在最多可包含 50 个域名。

- Wildcard Domains are now being excluded from the "Redirect to" Domain feature.  
- 通配符域名（Wildcard Domains）现已从“重定向至（Redirect to）”域名功能中排除。

## Dashboard  
## 控制台

- Logs can now render visual ASCII layouts.  
- 日志现在可渲染可视化 ASCII 布局。

- The "Deployment Duration" shown for every deployment now doesn't include the duration for which your deployment was queued anymore.  
- 每次部署所显示的“部署时长（Deployment Duration）”现已不再包含部署排队等待的时间。

- Team slugs are now automatically lowercased, when entered with uppercase characters.  
- 团队 slug（团队标识符）在输入时若包含大写字母，现将自动转为小写。

- Updated fieldset footer to clarify that we support YouTube and Image links for Integration feature media.  
- 已更新字段集（fieldset）页脚，明确说明集成（Integration）功能的媒体支持 YouTube 链接和图片链接。

- Interested partners on [/partners](https://vercel.com/partners) are now able to out via the [partnership@vercel.com](mailto:partnership@vercel.com) email address.  
- 对合作感兴趣的伙伴，可通过 [/partners](https://vercel.com/partners) 页面联系，并发送邮件至 [partnership@vercel.com](mailto:partnership@vercel.com)。