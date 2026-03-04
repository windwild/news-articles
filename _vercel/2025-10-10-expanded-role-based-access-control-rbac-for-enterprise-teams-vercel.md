---
title: "Expanded Role-Based Access Control (RBAC) for Enterprise teams - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/expanded-role-based-access-control-rbac-for-enterprise-teams"
date: "2025-10-10"
scraped_at: "2026-03-02T09:27:09.769353071+00:00"
language: "en-zh"
translated: true
description: "Vercel’s Role-Based Access Control (RBAC) system now supports multiple roles per user and introduces extended permissions for finer-grained access control across Enterprise teams."
---
&#123;% raw %}

Oct 10, 2025

2025年10月10日

![](images/expanded-role-based-access-control-rbac-for-enterprise-teams-vercel/img_001.jpg)![](images/expanded-role-based-access-control-rbac-for-enterprise-teams-vercel/img_002.jpg)

Vercel 的基于角色的访问控制（RBAC）系统现已支持为单个用户分配多个角色，并为大型企业团队引入了扩展权限，以实现更精细的跨团队访问控制。

新增功能：

- **多角色支持：** 可在企业团队内为单个用户分配多个角色。

- **安全角色：** 全新推出的团队角色，专用于管理安全与合规性设置。

- **扩展权限：** 新增细粒度能力，可叠加于团队角色和项目角色之上，实现更精准的权限控制。

- **访问组集成：** 访问组（Access Groups）现已支持在目录同步（Directory Sync）映射中配置团队角色及扩展权限。

新增的扩展权限包括：

- **创建项目（Create Project）：** 创建新项目。

- **Full Production Deployment:** Deploy, rollback, and promote to production.

- **完整生产部署：** 部署、回滚及上线至生产环境。

- **Usage Viewer:** View usage, prices, and invoices (read-only).

- **用量查看器：** 查看用量、价格和账单（仅限只读）。

- **Integration Manager:** Install and manage integrations and storage.

- **集成管理器：** 安装并管理集成与存储服务。

- **Environment Manager:** Create and manage project environments.

- **环境管理器：** 创建并管理项目环境。

- **Environment Variable Manager:** Create and manage environment variables.

- **环境变量管理器：** 创建并管理环境变量。

Extended permissions apply when paired with a compatible team role.

扩展权限需与兼容的团队角色配合使用。

Learn more in the [Role-Based Access Control documentation.](https://vercel.com/docs/rbac/access-roles/extended-permissions)

更多详情，请参阅 [基于角色的访问控制（RBAC）文档](https://vercel.com/docs/rbac/access-roles/extended-permissions)。
&#123;% endraw %}
