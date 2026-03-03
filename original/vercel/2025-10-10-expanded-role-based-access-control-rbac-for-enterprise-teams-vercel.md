---
title: "Expanded Role-Based Access Control (RBAC) for Enterprise teams - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/expanded-role-based-access-control-rbac-for-enterprise-teams"
date: "2025-10-10"
scraped_at: "2026-03-02T09:27:09.769353071+00:00"
language: "en"
translated: false
description: "Vercel’s Role-Based Access Control (RBAC) system now supports multiple roles per user and introduces extended permissions for finer-grained access control across Enterprise teams."
---




Oct 10, 2025

![](images/expanded-role-based-access-control-rbac-for-enterprise-teams-vercel/img_001.jpg)![](images/expanded-role-based-access-control-rbac-for-enterprise-teams-vercel/img_002.jpg)

Vercel’s Role-Based Access Control (RBAC) system now supports multiple roles per user and introduces extended permissions for finer-grained access control across Enterprise teams.

What’s new:

- **Multi-role support:** Assign multiple roles to a single user within Enterprise teams.

- **Security role:** A new team role dedicated to managing security and compliance settings.

- **Extended permissions:** Add granular capabilities that layer on top of team and project roles for precise control.

- **Access groups integration:** Access Groups now support team roles and extended permissions in Directory Sync mappings.


The new extended permissions include:

- **Create Project:** Create new projects.

- **Full Production Deployment:** Deploy, rollback, and promote to production.

- **Usage Viewer:** View usage, prices, and invoices (read-only).

- **Integration Manager:** Install and manage integrations and storage.

- **Environment Manager:** Create and manage project environments.

- **Environment Variable Manager:** Create and manage environment variables.


Extended permissions apply when paired with a compatible team role.

Learn more in the [Role-Based Access Control documentation.](https://vercel.com/docs/rbac/access-roles/extended-permissions)