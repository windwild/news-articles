---
render_with_liquid: false
title: "Access groups now generally available on Enterprise plans - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-groups-now-generally-available-on-enterprise-plans"
date: "2024-05-07"
scraped_at: "2026-03-02T09:45:05.998707391+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

May 7, 2024

2024年5月7日

![](images/access-groups-now-generally-available-on-enterprise-plans-vercel/img_001.jpg)![](images/access-groups-now-generally-available-on-enterprise-plans-vercel/img_002.jpg)

Enterprise customers can now manage access to critical Vercel projects across many Vercel users easier than ever with Access Groups.

借助“访问组”（Access Groups），企业客户如今能够比以往更轻松地统一管理大量 Vercel 用户对关键 Vercel 项目的访问权限。

Access Groups allow team administrators to create a mapping between team members and groups of Vercel projects. Users added to an Access Group will automatically be assigned access to the Projects connected to that Access Group, and will be given the default role of that group, making onboarding easier and faster than ever for new Vercel Team members.

“访问组”允许团队管理员建立团队成员与一组 Vercel 项目之间的映射关系。被添加至某访问组的用户，将自动获得该访问组所关联的所有项目的访问权限，并被授予该组预设的默认角色，从而极大简化并加速新 Vercel 团队成员的入职流程。

For customers who use a third-party Identity Provider, such as Okta, Access Groups can [automatically sync](https://vercel.com/docs/security/directory-sync) with their provider, making it faster to start importing users to Vercel without creating manual user group mappings (Vercel is [SCIM](https://vercel.com/docs/security/saml) compliant).

对于使用第三方身份提供商（如 Okta）的客户，“访问组”可与其身份提供商[自动同步](https://vercel.com/docs/security/directory-sync)，从而无需手动创建用户组映射，即可快速将用户导入 Vercel（Vercel 已支持 [SCIM](https://vercel.com/docs/security/saml) 标准）。

For example, you can have a Marketing Engineering Access Group, which has a default project role of "Developer". When a new member is added to the Marketing Engineering group, they will automatically be assigned the Developer role, and access to all Projects assigned to that group.

例如，您可以创建一个名为“市场营销工程”的访问组，其默认项目角色为“开发者”（Developer）。当新成员加入“市场营销工程”组时，系统将自动为其分配“开发者”角色，并授予其对该组下所有已分配项目的访问权限。

This builds on our advanced access controls, like [project level access controls](https://vercel.com/docs/accounts/team-members-and-roles/access-roles/project-level-roles) and [deployment protection](https://vercel.com/docs/security/deployment-protection). Learn more about [Access Groups](https://vercel.com/docs/accounts/team-members-and-roles/access-groups) or [contact us for a demo](https://vercel.com/contact/sales) of our access security features.

该功能进一步完善了我们已有的高级访问控制能力，例如[项目级访问控制](https://vercel.com/docs/accounts/team-members-and-roles/access-roles/project-level-roles)和[部署保护](https://vercel.com/docs/security/deployment-protection)。了解更多关于[访问组](https://vercel.com/docs/accounts/team-members-and-roles/access-groups)的信息，或[联系我们预约演示](https://vercel.com/contact/sales)，了解我们的访问安全功能。