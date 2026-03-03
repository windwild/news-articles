---
title: "Workspaces in LangSmith for improved collaboration and organization"
source: "LangChain Blog"
url: "https://blog.langchain.com/workspaces-in-langsmith/"
date: "2024-06-23"
scraped_at: "2026-03-03T08:00:43.292745011+00:00"
language: "en-zh"
translated: true
description: "Workspaces in LangSmith lets enterprises separate resources between different teams, business units, or deployment environments."
tags: ["By LangChain"]
---

For large companies with many teams and business units, resource separation is a must. Workspaces in LangSmith now provide a logical grouping of users and resources within an organization, enhancing productivity and security for enterprises and startups.

对于拥有众多团队和业务部门的大型企业而言，资源隔离是必不可少的。LangSmith 中的工作区（Workspaces）现可为组织内的用户与资源提供逻辑化分组，从而提升企业及初创公司的生产力与安全性。

Now, LangSmith activity and workflows will happen in the context of a **workspace** that separates resources between different teams, business units, or deployment environments. LangSmith now supports organization-scoped roles and actions, and each workspace has settings distinct from that of the overall organization. Read on for more on what’s changed and how workspaces can streamline your workflow, especially for larger companies managing multiple workloads and dividing responsibilities among teams.

如今，LangSmith 的所有活动与工作流均在 **工作区（workspace）** 的上下文中运行，不同团队、业务单元或部署环境之间的资源由此实现彼此隔离。LangSmith 现已支持面向整个组织的角色与操作权限管理，且每个工作区均拥有独立于组织整体设置的专属配置。请继续阅读，了解本次更新的具体变化，以及工作区如何优化您的工作流程——尤其适用于需同时管理多个工作负载、并在各团队间划分职责的大型企业。

## Using Workspaces to effectively manage resources

## 使用工作区高效管理资源

When you login for the first time in LangSmith, the default will be to have a Personal organization created for you. This organization will be limited to a single workspace.

首次登录 LangSmith 时，系统将默认为您创建一个“个人组织”（Personal organization），该组织仅包含一个工作区。

![](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_001.png)

**Users in shared organizations** for LangSmith can create multiple workspaces and assign teams, business units, deployment environments, or another internal grouping to each one for streamlined efficiency. They’ll also be able to invite multiple users to your organization and workspace(s) at the same time, at the organization level. See [our docs](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com) for more details.

**共享型组织（shared organizations）** 中的 LangSmith 用户可创建多个工作区，并为每个工作区分别分配团队、业务单元、部署环境或其他内部组织单元，以提升协作效率。您还可直接在组织层级一次性邀请多位用户加入您的组织及对应工作区（或多个工作区）。更多详情，请参阅[我们的文档](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com)。

Resources such as trace projects, datasets, annotation queues, and prompts will now be associated with a single workspace within an organization, rather than shared across workspaces. Existing workflows remain unchanged, but if you have multiple workspaces, you must select which one to work in.

诸如追踪项目（trace projects）、数据集（datasets）、标注队列（annotation queues）和提示词（prompts）等资源，今后将归属于组织内的某一个特定工作区，而不再跨工作区共享。现有工作流保持不变；但若您拥有多个工作区，则需手动选择当前要操作的工作区。

The introduction of workspaces does not change how seats for billing will be counted. API keys will also function as before and are scoped to the workspace they were created.

引入工作区机制不会改变计费席位（seats）的统计方式。API 密钥的功能亦保持不变，其作用域仍限定于其创建时所属的工作区。

## Resource management that scales with enterprises

## 面向企业级规模扩展的资源管理

For large enterprises, it’s important to have workspaces that scale with your organization. **Users on the Enterprise plan** for LangSmith can create 10 workspaces and may request to have the limit increased. This allows you to have more granular control over employee access, so you can  isolate access to any sensitive data and operations. With the modularity of workspaces, you can also handle more diverse projects and make quick adjustments to the specific needs of each one.

对于大型企业而言，工作区必须具备随组织规模弹性扩展的能力。**订阅 LangSmith 企业版（Enterprise plan）的用户**最多可创建 10 个工作区，并可申请提高该上限。这使您能对员工访问权限实施更精细的管控，从而有效隔离敏感数据与关键操作的访问权限。依托工作区的模块化设计，您还可并行处理类型更为多样的项目，并针对每个项目的具体需求快速灵活地调整配置。

Workspaces also play well with [Role-based access control (RBAC](https://blog.langchain.com/access-control-updates-for-langsmith/)) in LangSmith. [Learn more](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspace-roles) about how workspace roles can be managed using RBAC.

工作区（Workspaces）在 LangSmith 中也与[基于角色的访问控制（RBAC）](https://blog.langchain.com/access-control-updates-for-langsmith/)良好协同。[点击此处了解](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspace-roles)如何通过 RBAC 管理工作区角色。

When adding users, you can save time by inviting each batch of users to a group of workspaces with the same Workspace Role. A user’s Workspace Role determines their granular permissions within the specific workspace where it is assigned. This may be a Custom role or pre-defined System role. See the “User management and permissions” section below for more details.

添加用户时，您可为每批用户批量邀请至一组具有相同“工作区角色（Workspace Role）”的工作区，从而节省时间。用户的“工作区角色”决定了其在被分配的具体工作区内所拥有的细粒度权限——该角色可以是自定义角色（Custom role），也可以是预定义的系统角色（System role）。更多详情，请参见下方“用户管理与权限”一节。

/0:55

1×

## User management and permissions

## 用户管理与权限

For users on paid plans of LangSmith, user management is now scoped at the organization level. This means you can invite users — who are designated as either an _Organization Admin_ or an _Organization User_ — to your organization and workspace(s) at the organization level.

对于使用 LangSmith 付费计划的用户，用户管理现已提升至组织（Organization）层级。这意味着您可在组织层级统一邀请用户——这些用户将被指定为“组织管理员（Organization Admin）”或“组织成员（Organization User）”，并同时加入您的组织及一个或多个工作区。

An _Organization Admin_ has full access to manage all organization configuration, users, billing, and workspaces. Any _Organization Admin_ has _Admin_ access to all workspaces in an organization.

“组织管理员”拥有对组织全部配置、用户、账单及工作区的完全管理权限。任何一位“组织管理员”均自动获得组织内所有工作区的“管理员（Admin）”权限。

Meanwhile, an _Organization User_ may read organization information but cannot execute any write actions at the organization level. If [RBAC is enabled](https://blog.langchain.com/access-control-updates-for-langsmith/), then you should assign the _Organization User_ role for any users that need granular permissions (whether that means access to a subset of workspaces, or selecting workspace roles besides Workspace Admin).

而“组织成员”仅可查看组织信息，无法在组织层级执行任何写入操作。若已启用[RBAC](https://blog.langchain.com/access-control-updates-for-langsmith/)，则对于需要细粒度权限的用户（例如：仅需访问部分工作区，或需分配除“工作区管理员”外的其他工作区角色），您应为其分配“组织成员”角色。

You can check your Organization role under _Organization members and roles_ under Settings > Members and roles. See [the docs](http://o/?ref=blog.langchain.com) for more on all organization permissions.

您可在“设置（Settings）> 成员与角色（Members and roles）”下的“组织成员与角色（Organization members and roles）”中查看自己的组织角色。有关全部组织级权限的详细说明，请参阅[官方文档](http://o/?ref=blog.langchain.com)。

## What's next for Workspaces

## 工作区的后续规划

As we continue, we’ll be enabling workspaces for self-hosted customers. For self-hosted installations, there will be a configuration option to disable Personal organizations.

随着我们持续推进，我们将为自托管客户启用工作区功能。对于自托管部署，将提供一项配置选项，用于禁用“个人组织”（Personal organizations）。

Additionally, future improvements include enabling organization-level management of usage limits. We’ll also enable programmatic access to organization-level APIs, which will allow enterprises to manage users, roles, and other organization settings using API keys with a programming language of their choice.

此外，后续改进将包括支持在组织层级管理用量限额。我们还将开放组织级 API 的程序化访问能力，使企业能够使用其选定编程语言配合 API 密钥，对用户、角色及其他组织设置进行管理。

Furthermore, there will be an option to consolidate workspaces between organizations. For those interested, please contact [support@langchain.dev](mailto:support@langchain.dev).

此外，还将支持跨组织合并工作区。如有兴趣，请联系 [support@langchain.dev](mailto:support@langchain.dev)。

## Conclusion

## 结语

Workspaces enhance productivity and security by organizing users and resources into distinct groupings within an organization. This structure lets you more efficiently manage trace projects, datasets, and other resources – with customizable settings for each workspace.

工作区通过将用户与资源按组织内不同分组进行归类，从而提升工作效率与安全性。该结构使您能更高效地管理追踪项目（trace projects）、数据集（datasets）及其他资源——每个工作区均可配置专属设置。

Plans with multiple workspaces can manage user membership by workspace, and plans with RBAC can additionally assign users granular roles within each workspace.

支持多工作区的订阅方案可按工作区精细化管理用户成员身份；而支持基于角色的访问控制（RBAC）的方案，还可进一步为每位用户在各工作区内分配细粒度角色。

**_For more information, check out our_** [**_conceptual guide_**](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspaces) **_and how-to guides on_** [**_setting up a workspace_**](https://docs.smith.langchain.com/how_to_guides/setup/set_up_workspace?ref=blog.langchain.com) **_and_** [**_managing/navigating a workspace_**](https://docs.smith.langchain.com/how_to_guides/setup/set_up_organization?ref=blog.langchain.com#manage-and-navigate-workspaces) **_. Try out our features in LangSmith today, and reach out to us at_** [**_support@langchain.dev_**](mailto:support@langchain.dev) **_for any questions/feedback._**

**_如需了解更多详情，请参阅我们的_** [**_概念指南_**](https://docs.smith.langchain.com/concepts/admin?ref=blog.langchain.com#workspaces) **_，以及关于_** [**_创建工作区_**](https://docs.smith.langchain.com/how_to_guides/setup/set_up_workspace?ref=blog.langchain.com) **_和_** [**_管理工作区/在工作区中导航_**](https://docs.smith.langchain.com/how_to_guides/setup/set_up_organization?ref=blog.langchain.com#manage-and-navigate-workspaces) **_的操作指南。欢迎即刻在 LangSmith 中体验这些功能；如有任何问题或反馈，请联系我们：_** [**_support@langchain.dev_**](mailto:support@langchain.dev) **_。**

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项](images/workspaces-in-langsmith-for-improved-collaboration-and-organization/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟