---
render_with_liquid: false
title: "New compliance and administrative tools for ChatGPT Enterprise | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/new-tools-for-chatgpt-enterprise"
date: "2024-07-18"
scraped_at: "2026-03-02T10:18:21.799633672+00:00"
language: "en-US"
translated: false
description: "Compliance API integrations, SCIM, and GPT controls to support compliance programs, data security, and user access at scale"
tags: ["Product"]
---

July 18, 2024


# New compliance and administrative tools for ChatGPT Enterprise

![The image shows a soft-focus, abstract close-up of a curved pink petal or shape, blending gently into a light purple and pink background, creating a smooth, flowing effect with delicate color transitions.](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_001.png)



_**Update on December 11, 2025:**_

_The ChatGPT Compliance API is now part of the OpenAI Compliance Logs Platform, the home for the current state-based endpoints, as well as new event and transactional data. The platform is a new unified paradigm for enterprises to export observability and compliance data via immutable, time-windowed JSONL log files. It delivers improved reliability, minutes-level latency, and a single ingestion pattern across multiple log categories._

_As part of this launch, we’re including brand-new Admin Audit, User Authentication, and Codex Usage logs._

_Our goal with these updates is to continue supporting enterprise customers with managing their compliance programs, enhancing data security, and securely scaling user access. We’ll continue to add more log types to match the ChatGPT ecosystem. You can learn more_ [_here_ ⁠(opens in a new window)](https://help.openai.com/en/articles/9261474-compliance-api-for-enterprise-customers) _._

Since we launched ChatGPT Enterprise last year, global organizations including the Boston Consulting Group, PwC, Los Alamos National Laboratory, Moderna, Lowe’s, BBVA, Western & Southern Financial Group, and many more have worked with OpenAI to securely enable their workforce with AI.

Today, we’re launching more tools to support enterprise customers with managing their compliance programs, enhancing data security, and securely scaling user access.

## Programmatic control over workspace data to support compliance and data security

The new Enterprise Compliance API and eight integrations developed by leading eDiscovery and Data Loss Prevention (DLP) companies help ChatGPT Enterprise customers in regulated industries such as finance, healthcare, legal services, and government comply with logging and audit requirements.

With the API, [workspace owners⁠(opens in a new window)](https://help.openai.com/en/articles/8266431-what-is-the-difference-between-different-roles-on-my-chatgpt-enterprise-workspace) can efficiently audit and take action on their ChatGPT Enterprise workspace data. The API provides a record of time-stamped interactions, including conversations, uploaded files, workspace GPT configuration and metadata, memories, and workspace users. You can see the full list of permissions in our [help center⁠(opens in a new window)](https://help.openai.com/en/articles/9261474-compliance-apis-for-enterprise-customers).

Enterprise workspace owners can access the Enterprise Compliance API directly or can choose to use a third-party compliance integration to simplify the process of syncing ChatGPT Enterprise data. These new integrations offered by the following providers support a range of compliance-related activities, such as archiving, audit trails, data redaction and retention, and policy enforcement:

- [Forcepoint⁠(opens in a new window)](https://www.forcepoint.com/newsroom/2024/forcepoint-launches-comprehensive-genai-security)
- [Global Relay⁠(opens in a new window)](https://www.globalrelay.com/resources/our-news/global-relay-announces-integration-with-openais-chatgpt-enterprise-compliance-api/?utm_source=OpenAI&utm_medium=announcement-1&utm_campaign=gr-ba-global-q324-connector-chatgpt&utm_content)
- [Microsoft Purview⁠(opens in a new window)](https://techcommunity.microsoft.com/t5/security-compliance-and-identity/microsoft-purview-integrates-with-chatgpt-enterprise-compliance/ba-p/4192868)
- [Netskope⁠(opens in a new window)](https://www.netskope.com/press-releases/netskope-announces-integration-with-openais-chatgpt-enterprise-to-strengthen-data-governance-and-compliance)
- [Palo Alto Networks⁠(opens in a new window)](https://www.paloaltonetworks.com/blog/2024/07/announcing-openai-chatgpt-enterprise-compliance-integration/)
- [Relativity⁠(opens in a new window)](https://www.prnewswire.com/news-releases/relativity-announces-openai-chatgpt-enterprise-compliance-api-integration-302200238.html?tc=eml_cleartime)
- [Smarsh⁠(opens in a new window)](https://www.smarsh.com/blog/thought-leadership/smarsh-launches-integration-with-openai-chatgpt-enterprise-compliance-api)
- [Zscaler⁠(opens in a new window)](https://www.zscaler.com/blogs/product-insights/zscaler-delivers-new-chatgpt-enterprise-compliance-api-integration-drive)

Integrations help ChatGPT Enterprise customers with:

- Compliance programs: Support meeting requirements for regulations like FINRA, HIPAA, and GDPR
- eDiscovery and legal holds: Preparing and maintaining data in the case of legal proceedings
- Data Loss Prevention (DLP): Monitoring and deleting sensitive data such as Personally Identifiable Information (PII), Protected Health Information (PHI), or financial data

We’ll continue to collaborate with compliance providers to add more capabilities and integrations throughout the year.

## Automated user management

Next week, we’ll roll out SCIM (System for Cross-domain Identity Management), enabling admins to sync their internal employee directories with their ChatGPT Enterprise workspace for programmatic provisioning and deprovisioning of user accounts. This ensures user access and information is consistently accurate and up-to-date across systems.

We’ll support custom SCIM and most company directories including Okta Workforce, Microsoft Entra ID, Google Workspace, and Ping.

SCIM is currently in beta, with broader availability coming next week. ChatGPT Enterprise customers can reach out to their OpenAI account team to learn more.

![The image shows a directory sync setup screen with options to select a provider: Okta, Entra ID (Azure AD), Google Workspace, CyberArk, JumpCloud, OneLogin, or Custom SCIM. It includes a search bar for finding providers.](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_002.png)

## Expanded GPT controls

Enterprise workspace admins now have more precise control over GPTs—custom versions of ChatGPT configured with natural language instructions, knowledge via file uploads, and actions.

Previously, admins could only fully allow or block usage of GPT actions created in their workspace. We’ve added a new setting that lets workspace admins [create an approved list of specific domains⁠(opens in a new window)](https://help.openai.com/en/articles/9442513-gpt-actions-domain-settings-chatgpt-enterprise) for more granular controls over actions. This ensures GPTs can interact with approved services while restricting other domains.

![A demonstration of the process of approving domains for GPT actions, enabling and sharing the GPT.](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_003.gif)

In addition to this new setting, Enterprise admins also have access to:

- [Group permissions⁠(opens in a new window)](https://help.openai.com/en/articles/9083985-group-permissions-in-gpts): Create and edit user groups to control GPT access and permissions more granularly within your workspace.
- [Comprehensive GPT settings⁠(opens in a new window)](https://help.openai.com/en/articles/8840492-what-gpt-settings-can-i-control-for-my-workspace): Manage GPT sharing permissions, view the configuration of any GPT in your workspace, remove GPTs, transfer ownership, and set global GPT capabilities.
- [Third-party GPT controls⁠(opens in a new window)](https://help.openai.com/en/articles/8840492-what-gpt-settings-can-i-control-for-my-workspace#h_0c5b86d61b): Approve specific third-party GPTs in your workspace, or set global controls to allow or restrict all external GPTs.

GPTs provide more personalized outputs based on the knowledge and information users share and extend the power of ChatGPT by interacting with other systems. With these controls, Enterprise admins can ensure their workspace has safe access to the power of GPTs.

## Supporting secure AI deployments at scale

We continue to invest deeply in enterprise security. In addition to these new tools, ChatGPT Enterprise offers robust [data privacy, security, and admin controls⁠](https://openai.com/enterprise-privacy/), including:

- No customer data or metadata is used for training models
- Data encryption at rest and in transit
- Custom data retention window
- Single Sign-On (SSO) and domain verification
- CCPA, CSA STAR, and SOC 2 Type 2 compliance

If you’re interested in [ChatGPT Enterprise](https://openai.com/chatgpt/enterprise/), please [reach out to our team](https://openai.com/contact-sales/) to learn how we partner with organizations on AI strategy, use case development, and workforce enablement. We’ve worked with hundreds of global enterprises to support effective AI deployments securely and at scale.

These tools are also available in [ChatGPT Edu](https://openai.com/chatgpt/education/), an accessible option for universities to bring AI to campus at scale.

## Related articles

![Los Alamos](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_004.jpg)

[OpenAI and Los Alamos National Laboratory announce research partnership\\
\\
MilestoneJul 10, 2024](https://openai.com/index/openai-and-los-alamos-national-laboratory-work-together/)

![apple-abstract](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_005.jpg)

[OpenAI and Apple announce partnership\\
\\
CompanyJun 10, 2024](https://openai.com/index/openai-and-apple-announce-partnership/)

![ChatGPT Charts Blog Hero](images/new-compliance-and-administrative-tools-for-chatgpt-enterprise-openai/img_006.png)

[Improvements to data analysis in ChatGPT\\
\\
ProductMay 16, 2024](https://openai.com/index/improvements-to-data-analysis-in-chatgpt/)

New compliance and administrative tools for ChatGPT Enterprise \| OpenAI