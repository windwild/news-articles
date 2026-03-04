---
title: "Two-factor authentication (2FA) team enforcement - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/2fa-team-enforcement"
date: "2025-06-19"
scraped_at: "2026-03-02T09:32:27.918777798+00:00"
language: "en-zh"
translated: true
description: "Team owners can now enforce two-factor authentication (2FA) for every member of their team via a toggle in Security & Privacy under team settings."
---
&#123;% raw %}

Jun 19, 2025

2025年6月19日

![2FA Team Enforcement - Dark](images/two-factor-authentication-2fa-team-enforcement-vercel/img_001.jpg)![2FA Team Enforcement - Dark](images/two-factor-authentication-2fa-team-enforcement-vercel/img_002.jpg)

Teams can now require all members to enable two-factor authentication (2FA) for added security.

团队现在可强制要求所有成员启用双重身份验证（2FA），以增强安全性。

Team owners can enable enforcement in the [**Security & Privacy**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy) section of team settings.

团队所有者可在团队设置的 [**安全与隐私**](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy) 页面中启用强制策略。

**Owner controls**

**所有者控制项**

- View and filter each member’s 2FA status in the [team members settings](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fmembers&title=Go+to+Members)

- 在 [团队成员设置](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fmembers&title=Go+to+Members) 中查看并筛选每位成员的 2FA 状态

**Member restrictions**

**成员限制**

Once enforcement is enabled, members without 2FA will be restricted from:

启用强制策略后，未启用 2FA 的成员将被限制执行以下操作：

- Triggering builds from pull requests

- 通过拉取请求（pull request）触发构建

- Accessing new preview deployments

- 访问新的预览部署（preview deployments）

- Viewing the team dashboard  
- 查看团队仪表板

- Making API requests  
- 发起 API 请求

- Using access tokens  
- 使用访问令牌

**Enforcement lock-in & visibility**  
**强制执行的锁定机制与可见性**

- Members of a team with 2FA enforcement cannot disable 2FA unless they leave the team  
- 启用了双重身份验证（2FA）强制策略的团队成员，除非退出该团队，否则无法关闭 2FA。

- In each user’s account settings, teams that require 2FA are now listed for clarity  
- 现在，每位用户的账户设置中会明确列出要求启用 2FA 的团队，以提升透明度。

[Enable 2FA enforcement](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy) today, and [learn more in our docs](https://vercel.com/docs/two-factor-enforcement).  
[立即启用 2FA 强制策略](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fsecurity&title=Go+to+Security+%26+Privacy)，并[在我们的文档中了解更多信息](https://vercel.com/docs/two-factor-enforcement)。
&#123;% endraw %}
