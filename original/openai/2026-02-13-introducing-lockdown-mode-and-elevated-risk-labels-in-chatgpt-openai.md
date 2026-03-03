---
title: "Introducing Lockdown Mode and Elevated Risk labels in ChatGPT | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:18.894463382+00:00"
language: "en-US"
translated: false
description: "Introducing Lockdown Mode and Elevated Risk labels in ChatGPT to help organizations defend against prompt injection and AI-driven data exfiltration."
tags: ["Safety"]
---

February 13, 2026

[Safety](https://openai.com/news/safety-alignment/) [Product](https://openai.com/news/product-releases/)

# Introducing Lockdown Mode and Elevated Risk labels in ChatGPT



As AI systems take on more complex tasks—especially those that involve the web and connected apps—the security stakes change.

One emerging risk has become especially important: [prompt injection⁠](https://openai.com/index/prompt-injections/). In these attacks, a third party attempts to mislead a conversational AI system into following malicious instructions or revealing sensitive information.

Today, we’re introducing two new protections designed to help users and organizations mitigate prompt injection attacks, with clearer visibility into risk and stronger controls:

- **Lockdown Mode** in ChatGPT, an advanced, optional security setting for higher-risk users
- **“Elevated Risk” labels** for certain capabilities in ChatGPT, ChatGPT Atlas, and Codex that may introduce additional risk

These additions build on our existing protections across the model, product, and system levels. This includes sandboxing, [protections against URL-based data exfiltration⁠](https://openai.com/index/ai-agent-link-safety/), monitoring and enforcement, and [enterprise controls⁠](https://openai.com/business-data/) like role-based access and audit logs.

## Helping organizations protect employees most at-risk of cyberattacks

Lockdown Mode is an optional, advanced security setting designed for a small set of highly security-conscious users—such as executives or security teams at prominent organizations—who require increased protection against advanced threats. It is not necessary for most users. Lockdown Mode tightly constrains how ChatGPT can interact with external systems to reduce the risk of prompt injection–based data exfiltration.

Lockdown Mode deterministically disables certain tools and capabilities in ChatGPT that an adversary could attempt to exploit to exfiltrate sensitive data from users’ conversations or connected apps via attacks such as prompt injections.

For example, web browsing in Lockdown Mode is limited to cached content, so no live network requests leave OpenAI’s controlled network. This restriction is designed to prevent sensitive data from being exfiltrated to an attacker through browsing. Some features are disabled entirely when we can’t provide strong deterministic guarantees of data safety.

![Diagram titled “Lockdown mode” showing ChatGPT inside a secured boundary with connections to a Private Web Cache, Download Files, Access Web via Canvas, and Browse Public Web. An external “Attacker” and the Public Web are depicted outside the boundary, with blocked entry points indicating restricted access in lockdown mode.](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_001.png)

Lockdown Mode is a new deterministic setting that helps guard data from being inadvertently shared with third parties by tightly constraining how ChatGPT can interact with certain external systems.

ChatGPT business plans already provide [enterprise-grade data security⁠](https://openai.com/business-data/). Lockdown Mode builds on those protections and is available for ChatGPT Enterprise, ChatGPT Edu, ChatGPT for Healthcare, and ChatGPT for Teachers. Admins can enable it in [Workspace Settings⁠(opens in a new window)](https://chatgpt.com/admin/permissions?tab=roles&openaicom-did=f34f675c-2683-463b-88e0-1f3e9c48c8e8&openaicom_referred=true) by creating a new [role⁠(opens in a new window)](https://help.openai.com/en/articles/11750701-rbac). When enabled, Lockdown Mode layers additional restrictions on top of existing admin settings.

Learn more about Lockdown Mode in our [Help Center⁠(opens in a new window)](https://help.openai.com/articles/20001061).

Because some critical workflows rely on apps, Workspace Admins retain more granular controls. They can choose exactly which apps—and which specific actions within those apps—are available to users in Lockdown Mode. Additionally, and separate from Lockdown Mode, the [Compliance API Logs Platform⁠(opens in a new window)](https://help.openai.com/en/articles/9261474-compliance-api-for-enterprise-customers) provides detailed visibility into app usage, shared data, and connected sources, helping admins maintain oversight.

We plan to make Lockdown Mode available to consumers in the coming months.

## Helping users make informed choices about risk

AI products can be more helpful when connected to your apps and the web, and we’ve invested heavily in [keeping connected data secure⁠](https://openai.com/safety/prompt-injections/). At the same time, some network-related capabilities introduce new risks that aren’t yet fully addressed by the industry’s safety and security mitigations. Some users may be comfortable taking on these risks, and we believe it’s important for users to have the ability to decide whether and how to use them, especially while working with their private data.

Our approach has been to provide in-product guidance for features that may introduce additional risk. To make this clearer and more consistent, we’re standardizing how we label a short list of existing capabilities. These features will now use a consistent “Elevated Risk” label across ChatGPT, ChatGPT Atlas, and Codex, so users receive the same guidance wherever they encounter them.

For example, in Codex, our coding assistant, developers can grant Codex network access so it can take actions on the web like looking up documentation. The relevant settings screen includes the “Elevated Risk” label, along with a clear explanation of what changes, what risks may be introduced, and when that access is appropriate.

![Settings panel for “Agent internet access” with the toggle set to On, showing options for a domain allowlist, additional allowed domains (including openai.com), allowed HTTP methods, and a highlighted warning noting elevated security risks when enabling internet access.](images/introducing-lockdown-mode-and-elevated-risk-labels-in-chatgpt-openai/img_002.png)

A screenshot of the Codex settings screen where users can configure what network access Codex has.

## What’s next

We continue to invest in strengthening our safety and security safeguards, especially for novel, emerging, or growing risks. As we strengthen the safeguards for these features, we will remove the “Elevated Risk” label once we determine that security advances have sufficiently mitigated those risks for general use. We will also continue to update which features carry this label over time to best communicate risk to users.

- [2026](https://openai.com/news/?tags=2026)