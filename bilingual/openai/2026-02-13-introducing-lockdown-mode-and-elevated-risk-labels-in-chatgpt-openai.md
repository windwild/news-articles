---
title: "Introducing Lockdown Mode and Elevated Risk labels in ChatGPT | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:18.894463382+00:00"
language: "en-US"
translated: true
description: "Introducing Lockdown Mode and Elevated Risk labels in ChatGPT to help organizations defend against prompt injection and AI-driven data exfiltration."
tags: ["Safety"]
---

February 13, 2026

2026年2月13日

[Safety](https://openai.com/news/safety-alignment/) [Product](https://openai.com/news/product-releases/)

[Safety（安全）](https://openai.com/news/safety-alignment/) [Product（产品发布）](https://openai.com/news/product-releases/)

# Introducing Lockdown Mode and Elevated Risk labels in ChatGPT

# 在 ChatGPT 中推出“锁定模式”（Lockdown Mode）与“高风险”标签（Elevated Risk labels）

As AI systems take on more complex tasks—especially those that involve the web and connected apps—the security stakes change.

随着人工智能系统承担起日益复杂的任务——尤其是涉及网络及互联应用程序的任务——其安全风险格局也随之改变。

One emerging risk has become especially important: [prompt injection⁠](https://openai.com/index/prompt-injections/). In these attacks, a third party attempts to mislead a conversational AI system into following malicious instructions or revealing sensitive information.

一种新兴风险正变得尤为突出：[提示注入（prompt injection）](https://openai.com/index/prompt-injections/)。在此类攻击中，第三方试图误导对话式 AI 系统，使其执行恶意指令或泄露敏感信息。

Today, we’re introducing two new protections designed to help users and organizations mitigate prompt injection attacks, with clearer visibility into risk and stronger controls:

今天，我们推出两项新防护措施，旨在帮助用户和组织缓解提示注入攻击风险，同时提升风险可见性并强化管控能力：

- **Lockdown Mode** in ChatGPT, an advanced, optional security setting for higher-risk users  
- **“Elevated Risk” labels** for certain capabilities in ChatGPT, ChatGPT Atlas, and Codex that may introduce additional risk

- **ChatGPT 中的“锁定模式”（Lockdown Mode）**：一项面向高风险用户的高级、可选安全设置  
- **“高风险”标签（“Elevated Risk” labels）**：应用于 ChatGPT、ChatGPT Atlas 和 Codex 中某些可能带来额外风险的功能模块

These additions build on our existing protections across the model, product, and system levels. This includes sandboxing, [protections against URL-based data exfiltration⁠](https://openai.com/index/ai-agent-link-safety/), monitoring and enforcement, and [enterprise controls⁠](https://openai.com/business-data/) like role-based access and audit logs.

上述新增功能建立在我们已有的模型层、产品层与系统层多重防护基础之上，包括沙箱机制、[防范基于 URL 的数据外泄](https://openai.com/index/ai-agent-link-safety/)、实时监控与策略执行，以及[企业级管控能力](https://openai.com/business-data/)（例如基于角色的访问控制与审计日志）等。

## Helping organizations protect employees most at-risk of cyberattacks

## 协助组织保护最易遭受网络攻击的员工

# Lockdown Mode is an optional, advanced security setting designed for a small set of highly security-conscious users—such as executives or security teams at prominent organizations—who require increased protection against advanced threats. It is not necessary for most users. Lockdown Mode tightly constrains how ChatGPT can interact with external systems to reduce the risk of prompt injection–based data exfiltration.

# “锁定模式”（Lockdown Mode）是一项可选的高级安全设置，专为极少数安全意识极强的用户（例如知名机构的高管或安全团队）设计，旨在为其提供更强的高级威胁防护能力。大多数用户无需启用该模式。“锁定模式”通过严格限制 ChatGPT 与外部系统的交互方式，显著降低因提示词注入（prompt injection）导致敏感数据泄露的风险。

Lockdown Mode deterministically disables certain tools and capabilities in ChatGPT that an adversary could attempt to exploit to exfiltrate sensitive data from users’ conversations or connected apps via attacks such as prompt injections.

“锁定模式”以确定性方式禁用 ChatGPT 中某些可能被攻击者利用的工具与功能——例如通过提示词注入等攻击手段，从用户对话内容或已连接应用中窃取敏感数据。

For example, web browsing in Lockdown Mode is limited to cached content, so no live network requests leave OpenAI’s controlled network. This restriction is designed to prevent sensitive data from being exfiltrated to an attacker through browsing. Some features are disabled entirely when we can’t provide strong deterministic guarantees of data safety.

例如，在“锁定模式”下，网页浏览仅限于缓存内容，因此不会有任何实时网络请求离开 OpenAI 受控网络。该限制旨在防止攻击者通过浏览行为窃取敏感数据。当无法对数据安全提供强有力的确定性保障时，部分功能将被完全禁用。

![Diagram titled “Lockdown mode” showing ChatGPT inside a secured boundary with connections to a Private Web Cache, Download Files, Access Web via Canvas, and Browse Public Web. An external “Attacker” and the Public Web are depicted outside the boundary, with blocked entry points indicating restricted access in lockdown mode.](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_001.png)

![标题为“锁定模式”（Lockdown mode）的示意图：ChatGPT 位于一个受保护边界内，与“私有网页缓存”（Private Web Cache）、“下载文件”（Download Files）、“通过 Canvas 访问网页”（Access Web via Canvas）及“浏览公共网页”（Browse Public Web）相连接；边界外则标有外部“攻击者”（Attacker）和“公共网页”（Public Web），并以阻断符号表示在锁定模式下受限的访问入口。](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_001.png)

Lockdown Mode is a new deterministic setting that helps guard data from being inadvertently shared with third parties by tightly constraining how ChatGPT can interact with certain external systems.

“锁定模式”是一项全新的确定性设置，通过严格约束 ChatGPT 与特定外部系统的交互方式，帮助防止数据被无意间共享给第三方。

ChatGPT business plans already provide [enterprise-grade data security⁠](https://openai.com/business-data/). Lockdown Mode builds on those protections and is available for ChatGPT Enterprise, ChatGPT Edu, ChatGPT for Healthcare, and ChatGPT for Teachers. Admins can enable it in [Workspace Settings⁠(opens in a new window)](https://chatgpt.com/admin/permissions?tab=roles&openaicom-did=f34f675c-2683-463b-88e0-1f3e9c48c8e8&openaicom_referred=true) by creating a new [role⁠(opens in a new window)](https://help.openai.com/en/articles/11750701-rbac). When enabled, Lockdown Mode layers additional restrictions on top of existing admin settings.

ChatGPT 商业版订阅已提供[企业级数据安全保护⁠](https://openai.com/business-data/)。“锁定模式”在此基础上进一步强化防护能力，目前面向 ChatGPT Enterprise、ChatGPT Edu、ChatGPT for Healthcare 及 ChatGPT for Teachers 用户开放。管理员可通过创建新的[角色⁠(在新窗口中打开)](https://help.openai.com/en/articles/11750701-rbac)，在[工作区设置⁠(在新窗口中打开)](https://chatgpt.com/admin/permissions?tab=roles&openaicom-did=f34f675c-2683-463b-88e0-1f3e9c48c8e8&openaicom_referred=true)中启用该模式。启用后，“锁定模式”将在现有管理员设置之上叠加额外限制。

Learn more about Lockdown Mode in our [Help Center⁠(opens in a new window)](https://help.openai.com/articles/20001061).

欲了解“锁定模式”的更多详情，请参阅我们的[帮助中心⁠(在新窗口中打开)](https://help.openai.com/articles/20001061)。

Because some critical workflows rely on apps, Workspace Admins retain more granular controls. They can choose exactly which apps—and which specific actions within those apps—are available to users in Lockdown Mode. Additionally, and separate from Lockdown Mode, the [Compliance API Logs Platform⁠(opens in a new window)](https://help.openai.com/en/articles/9261474-compliance-api-for-enterprise-customers) provides detailed visibility into app usage, shared data, and connected sources, helping admins maintain oversight.

由于部分关键业务流程依赖应用程序，工作区管理员仍保有更精细的管控权限：他们可精确指定在“锁定模式”下允许用户使用的具体应用，以及这些应用中允许执行的具体操作。此外，除“锁定模式”外，[合规性 API 日志平台⁠(在新窗口中打开)](https://help.openai.com/en/articles/9261474-compliance-api-for-enterprise-customers) 还可提供关于应用使用情况、共享数据及已连接数据源的详细日志，助力管理员持续掌握全局态势。

We plan to make Lockdown Mode available to consumers in the coming months.

我们计划在未来数月内向普通消费者用户开放“锁定模式”。

## Helping users make informed choices about risk

## 帮助用户就风险做出知情决策

AI products can be more helpful when connected to your apps and the web, and we’ve invested heavily in [keeping connected data secure⁠](https://openai.com/safety/prompt-injections/).  
当 AI 产品与您的应用程序及互联网相连接时，其功能可变得更加强大和实用；为此，我们已大力投入资源，以[确保互联数据的安全性](https://openai.com/safety/prompt-injections/)。

At the same time, some network-related capabilities introduce new risks that aren’t yet fully addressed by the industry’s safety and security mitigations.  
与此同时，部分与网络相关的功能会带来新型风险，而当前行业通行的安全与防护措施尚无法全面应对这些风险。

Some users may be comfortable taking on these risks, and we believe it’s important for users to have the ability to decide whether and how to use them, especially while working with their private data.  
部分用户可能愿意承担此类风险；我们认为，赋予用户自主决定是否启用、以及如何使用这些功能的权利至关重要——尤其是在处理其个人数据时。

Our approach has been to provide in-product guidance for features that may introduce additional risk.  
我们的做法是：针对可能引入额外风险的功能，在产品内提供明确的使用指引。

To make this clearer and more consistent, we’re standardizing how we label a short list of existing capabilities.  
为使该指引更清晰、更统一，我们正对一系列现有功能的标注方式进行标准化。

These features will now use a consistent “Elevated Risk” label across ChatGPT, ChatGPT Atlas, and Codex, so users receive the same guidance wherever they encounter them.  
今后，这些功能将在 ChatGPT、ChatGPT Atlas 和 Codex 中统一采用“高风险（Elevated Risk）”标签，确保用户在任何场景下遇到相关功能时，均能获得一致的提示与指引。

For example, in Codex, our coding assistant, developers can grant Codex network access so it can take actions on the web like looking up documentation.  
例如，在我们的编程助手 Codex 中，开发者可授予其网络访问权限，使其能够执行诸如在线查阅文档等网页操作。

The relevant settings screen includes the “Elevated Risk” label, along with a clear explanation of what changes, what risks may be introduced, and when that access is appropriate.  
相应的设置界面中将显示“高风险（Elevated Risk）”标签，并附有清晰说明：权限开启后将发生哪些变化、可能引入哪些风险，以及何种情况下启用该权限是恰当的。

![Settings panel for “Agent internet access” with the toggle set to On, showing options for a domain allowlist, additional allowed domains (including openai.com), allowed HTTP methods, and a highlighted warning noting elevated security risks when enabling internet access.](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_002.png)  
![“智能体互联网访问（Agent internet access）”设置面板，开关已设为“开启（On）”，界面上显示了域名白名单选项、额外允许的域名（含 openai.com）、允许的 HTTP 方法，以及一处高亮警示，指出启用互联网访问将带来更高的安全风险。](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_002.png)

A screenshot of the Codex settings screen where users can configure what network access Codex has.  
这是 Codex 设置界面的截图，用户可在其中配置 Codex 所拥有的网络访问权限。

## What’s next  
## 后续计划

We continue to invest in strengthening our safety and security safeguards, especially for novel, emerging, or growing risks.  
我们将持续加大投入，强化安全与防护机制，尤其聚焦于新型、新兴或不断演化的风险。

As we strengthen the safeguards for these features, we will remove the “Elevated Risk” label once we determine that security advances have sufficiently mitigated those risks for general use.  
随着相关防护能力的提升，一旦我们确认安全技术进步已足以将风险控制在普通用户可接受的范围内，便会移除对应功能的“高风险（Elevated Risk）”标签。

We will also continue to update which features carry this label over time to best communicate risk to users.  
我们还将持续动态调整被标记为“高风险”的功能列表，以便更准确、有效地向用户传达实际风险。

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)