---
render_with_liquid: false
title: "Role Based Access Control (RBAC) for LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/access-control-updates-for-langsmith/"
date: "2025-10-09"
scraped_at: "2026-03-03T07:27:07.199966138+00:00"
language: "en-zh"
translated: true
description: "LangSmith's Role Based Access Control (RBAC) helps enterprises manage resource access with custom roles and API keys."
tags: ["agent builder"]
---
render_with_liquid: false
render_with_liquid: false

Access management can be a pain for large engineering teams as they build LLM applications. To avoid playing a game of whodunit or over/under-provisioning permissions, you need to systematically determine who can access your resources and to what capacity.

在构建大语言模型（LLM）应用的过程中，权限管理往往给大型工程团队带来诸多困扰。为避免陷入“谁动了权限？”的排查困境，或出现权限过度授予/授予不足的问题，您需要系统性地明确：哪些人员可以访问您的资源，以及可访问到何种程度。

LangSmith now has new Access Control features to help enterprises manage access to their resources. This includes **Role Based Access Control (RBAC)**, which lets you specify custom roles and can better support users with limited permissions via API Keys.

LangSmith 现已推出全新的访问控制（Access Control）功能，助力企业更高效地管理其资源访问权限。该功能包含 **基于角色的访问控制（Role-Based Access Control, RBAC）**，支持您定义自定义角色，并可通过 API Key 为权限受限的用户提供更灵活的支持。

## Role Based Access Control (RBAC)

## 基于角色的访问控制（RBAC）

💡

RBAC is currently only accessible for teams on the Enterprise plan. For more plan details, check out our [pricing page](https://www.langchain.com/pricing?ref=blog.langchain.com).

💡  
RBAC 当前仅面向 LangChain Enterprise 订阅计划的团队开放。如需了解各订阅方案详情，请访问我们的 [定价页面](https://www.langchain.com/pricing?ref=blog.langchain.com)。

With Role Based Access Control (RBAC), administrators can now assign roles to users within their workspace or organization. Each role represents a group of permissions. By default, there are three built-in system roles:

借助基于角色的访问控制（RBAC），管理员现在可在其工作区（workspace）或组织（organization）内为用户分配角色。每个角色对应一组预定义的权限。默认提供以下三种内置系统角色：

- `Admin` \- has full access to all resources within the workspace or organization  
- `Admin`（管理员）：对工作区或组织内的所有资源拥有完全访问权限  

- `Viewer` \- has read-only access to all resources within the workspace or organization  
- `Viewer`（查看者）：对工作区或组织内的所有资源仅拥有只读访问权限  

- `Editor` \- has full permissions except for workspace management (adding/removing users, changing roles, configuring service keys)  
- `Editor`（编辑者）：拥有除工作区管理外的全部权限（即不可添加/移除用户、不可变更用户角色、不可配置服务密钥）

A [workspace](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspaces) logically groups together users and resources in an organization and will be [coming soon](https://docs.smith.langchain.com/how_to_guides/setup/set_up_workspace?ref=blog.langchain.com) to LangSmith. This will add another layer of separation between the project and organization, helping isolate relevant resources to the right folks. For now, you can consider a workspace and organization to be equivalent concepts.

[工作区（workspace）](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspaces) 是一种逻辑分组机制，用于将组织内的用户与资源聚合管理；该功能即将在 LangSmith 中上线（[敬请期待](https://docs.smith.langchain.com/how_to_guides/setup/set_up_workspace?ref=blog.langchain.com)）。工作区的引入将在项目（project）与组织（organization）之间新增一层隔离，从而更精准地将相关资源限定给对应人员。目前阶段，您可以将“工作区”与“组织”视作等价概念。

![](images/role-based-access-control-rbac-for-langsmith/img_001.png)

![](images/role-based-access-control-rbac-for-langsmith/img_001.png)

Administrators can also create/edit custom roles with granular permissions on each set of LangSmith entities within a workspace or organization. This lessens the risk to vulnerabilities by reducing the surface area of what users can touch, such that users have just the permissions necessary to perform their job functions and critical tasks.

管理员还可针对工作区或组织内的每一类 LangSmith 实体（如 traces、datasets、projects 等），创建或编辑具备细粒度权限的自定义角色。此举通过缩小用户可操作的权限范围，显著降低安全漏洞风险，确保每位用户仅拥有履行其岗位职责和执行关键任务所必需的最小权限集。

![](images/role-based-access-control-rbac-for-langsmith/img_002.png)

![](images/role-based-access-control-rbac-for-langsmith/img_002.png)

Get started with Role Based Access Control by [following these docs.](https://docs.langchain.com/langsmith/user-management?ref=blog.langchain.com)

请通过[查阅这些文档](https://docs.langchain.com/langsmith/user-management?ref=blog.langchain.com)开始使用基于角色的访问控制（RBAC）。

## API Key Updates

## API 密钥更新

To better support access control, there are now two types of API Keys: **Personal Access Tokens** and **Service Keys**.

为更好地支持访问控制，现提供两种类型的 API 密钥：**个人访问令牌（Personal Access Tokens，PATs）** 和 **服务密钥（Service Keys）**。

![](images/role-based-access-control-rbac-for-langsmith/img_003.png)

![](images/role-based-access-control-rbac-for-langsmith/img_003.png)

All users can create personal access tokens. Personal Access Tokens are attached to the user who creates them. These keys will have the same permissions as the user. Note that if a user is deleted from an organization, their personal access tokens will also be deleted. These keys are meant to be used by users when talking to the LangSmith API. These PATs are especially useful for users who cannot configure service keys, ensuring that non-admins can still access LangSmith via the API.

所有用户均可创建个人访问令牌。个人访问令牌与其创建者用户绑定，权限与该用户完全一致。请注意：若某用户从组织中被删除，其所有个人访问令牌也将一并被删除。此类密钥专供用户调用 LangSmith API 时使用。对于无法配置服务密钥的用户而言，PATs 尤为实用，可确保非管理员用户仍能通过 API 访问 LangSmith。

Service Keys are keys that act as service principals. These keys are granted administrator privileges and are meant to be used by services that want to talk to the LangSmith API. (Additional permission configuration will be coming soon). Since these keys are associated with a service, they will not be impacted by organizational changes like users leaving. Only workspace admins will be able to create service keys.

服务密钥代表服务主体（service principals），默认拥有管理员权限，专为需要调用 LangSmith API 的后端服务而设计。（更细粒度的权限配置功能即将上线）。由于服务密钥与具体服务而非个人用户绑定，因此不会受组织架构变动（如人员离职）的影响。仅工作区管理员有权创建服务密钥。

[Read the docs](https://docs.smith.langchain.com/how_to_guides/setup/create_account_api_key?ref=blog.langchain.com) to get started with our new API keys.

[阅读文档](https://docs.smith.langchain.com/how_to_guides/setup/create_account_api_key?ref=blog.langchain.com)，了解如何开始使用我们的新 API 密钥。

💡

💡

Old `ls__` API keys have been migrated to service keys. Note that we will be removing support for these `ls__` API keys on July 1st, 2024

旧版 `ls__` 开头的 API 密钥已自动迁移为服务密钥。请注意：我们将于 2024 年 7 月 1 日起正式停止对这类 `ls__` API 密钥的支持。

**You can** [**try out these features on LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **today. And feel free to reach out to us at** [**support@langchain.dev**](mailto:support@langchain.dev) **for any questions or feedback!**

您今天即可在 [LangSmith 上试用这些功能](https://smith.langchain.com/?ref=blog.langchain.com)。如有任何问题或反馈，欢迎随时通过 [support@langchain.dev](mailto:support@langchain.dev) 与我们联系！

### Tags

### 标签

[![Agent Builder now available in Public Beta](images/role-based-access-control-rbac-for-langsmith/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试](images/role-based-access-control-rbac-for-langsmith/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/role-based-access-control-rbac-for-langsmith/img_005.png)](https://blog.langchain.com/introducing-align-evals/)

[![推出 Align Evals：简化大语言模型应用评估流程](images/role-based-access-control-rbac-for-langsmith/img_005.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)

[**推出 Align Evals：简化大语言模型应用评估流程**](https://blog.langchain.com/introducing-align-evals/)

[![Catch production failures early with LangSmith Alerts](images/role-based-access-control-rbac-for-langsmith/img_006.png)](https://blog.langchain.com/langsmith-alerts/)

[![借助 LangSmith Alerts 提前发现生产环境故障](images/role-based-access-control-rbac-for-langsmith/img_006.png)](https://blog.langchain.com/langsmith-alerts/)

[**Catch production failures early with LangSmith Alerts**](https://blog.langchain.com/langsmith-alerts/)

[**借助 LangSmith Alerts 提前发现生产环境故障**](https://blog.langchain.com/langsmith-alerts/)

[![Pairwise Evaluations with LangSmith](images/role-based-access-control-rbac-for-langsmith/img_007.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![使用 LangSmith 进行成对评估](images/role-based-access-control-rbac-for-langsmith/img_007.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**使用 LangSmith 进行成对评估**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)


[![LangSmith's Latest Feature: Grouped Monitoring Charts](images/role-based-access-control-rbac-for-langsmith/img_008.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[![LangSmith 最新功能：分组监控图表](images/role-based-access-control-rbac-for-langsmith/img_008.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith's Latest Feature: Grouped Monitoring Charts**](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith 最新功能：分组监控图表**](https://blog.langchain.com/grouped-monitoring-charts/)