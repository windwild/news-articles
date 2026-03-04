---
title: "Developers can now submit apps to ChatGPT | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/developers-can-now-submit-apps-to-chatgpt"
date: "2025-12-17"
scraped_at: "2026-03-02T10:08:39.228670891+00:00"
language: "en-US"
translated: true
description: "Developers can now submit apps for review and publication in ChatGPT, with approved apps appearing in a new in-product directory for easy discovery. Updated tools, guidelines, and the Apps SDK help de..."
tags: ["Product"]
---
&#123;% raw %}

December 17, 2025

December 17, 2025

[Product](https://openai.com/news/product-releases/) [Company](https://openai.com/news/company-announcements/)

[产品动态](https://openai.com/news/product-releases/) [公司公告](https://openai.com/news/company-announcements/)

# Developers can now submit apps to ChatGPT

# 开发者现在可以向 ChatGPT 提交应用

We’re opening app submissions for review and publication in ChatGPT, and users can discover apps in the app directory.

我们现已开放 ChatGPT 应用提交通道，供审核与发布；用户可通过应用目录发现并使用各类应用。

Earlier this year at DevDay, we introduced apps in ChatGPT. Starting today, developers can submit apps for review and publication in ChatGPT by following our [app submission guidelines⁠(opens in a new window)](https://developers.openai.com/apps-sdk/app-developer-guidelines). Apps extend ChatGPT conversations by bringing in new context and letting users take actions like order groceries, turn an outline into a slide deck, or search for an apartment. We’ve published resources to help developers build high-quality apps that users will love—based on what we’ve learned since DevDay—like best practices on [what makes a great ChatGPT app⁠(opens in a new window)](https://developers.openai.com/blog/what-makes-a-great-chatgpt-app), [open-source example apps⁠(opens in a new window)](https://github.com/openai/openai-apps-sdk-examples), an [open-sourced UI library⁠(opens in a new window)](https://github.com/openai/apps-sdk-ui) for chat-native interfaces, and a step-by-step [quickstart guide⁠(opens in a new window)](https://developers.openai.com/apps-sdk/quickstart/).

今年早些时候的 DevDay 大会上，我们首次推出了 ChatGPT 应用功能。即日起，开发者可依据我们的 [应用提交指南⁠(在新窗口中打开)](https://developers.openai.com/apps-sdk/app-developer-guidelines)，向 ChatGPT 提交应用以供审核与发布。应用通过引入新上下文、支持用户执行具体操作（例如订购杂货、将提纲自动生成幻灯片、搜索公寓等），显著拓展了 ChatGPT 的对话能力。基于 DevDay 以来的实践经验，我们已发布一系列资源，助力开发者打造用户喜爱的高质量应用，包括：[打造优秀 ChatGPT 应用的最佳实践⁠(在新窗口中打开)](https://developers.openai.com/blog/what-makes-a-great-chatgpt-app)、[开源示例应用⁠(在新窗口中打开)](https://github.com/openai/openai-apps-sdk-examples)、面向聊天原生界面的 [开源 UI 组件库⁠(在新窗口中打开)](https://github.com/openai/apps-sdk-ui)，以及分步式的 [快速入门指南⁠(在新窗口中打开)](https://developers.openai.com/apps-sdk/quickstart/)。

We’re also introducing an app directory right inside ChatGPT, where users can browse featured apps or search for any published app. The app directory is discoverable from the tools menu or directly from chatgpt.com/apps. Developers can also use deep links on other platforms to send users right to their app page in the directory.

此外，我们还在 ChatGPT 内部正式上线了应用目录，用户可在其中浏览精选应用，或搜索任意已发布的应用。该目录可通过工具菜单访问，也可直接通过网址 chatgpt.com/apps 进入。开发者还可利用其他平台上的深度链接，将用户一键跳转至其应用在目录中的专属页面。

Once users connect to apps, apps can get triggered during conversations when @ mentioned by name, or when selected from the tools menu. We’re also experimenting with ways to surface relevant, helpful apps directly within conversations—using signals like conversational context, app usage patterns, and user preferences—and giving users clear ways to provide feedback.

用户完成应用连接后，应用即可在对话中被触发：既可通过在消息中输入 `@应用名称` 直接调用，也可从工具菜单中手动选择。我们还在探索如何在对话中智能推荐相关且实用的应用——例如结合对话上下文、应用使用习惯及用户偏好等信号，并为用户提供清晰、便捷的反馈渠道。

## Building, submitting and monetizing apps

## 应用开发、提交与商业化

Building a great ChatGPT app starts with designing for real user intent. Developers can use the Apps SDK—now in beta—to build chat-native experiences that bring context and action directly into ChatGPT. The strongest apps are tightly scoped, intuitive in chat, and deliver clear value by either completing real-world workflows that start in conversation or enabling new, fully AI-native experiences inside ChatGPT. We recommend reviewing the [app submission guidelines⁠(opens in a new window)](https://developers.openai.com/apps-sdk/app-developer-guidelines) early to help you build a high-quality app. Additional documentation and examples are available in the [developer resource hub⁠(opens in a new window)](https://developers.openai.com/apps-sdk).

打造一款出色的 ChatGPT 应用，始于对真实用户意图的精准把握。开发者现可使用处于 Beta 阶段的 Apps SDK，构建原生于聊天场景的体验，将上下文与操作能力直接融入 ChatGPT。最成功的应用通常具备三大特征：范围聚焦、对话交互直观自然、价值清晰明确——或能完成始于对话的真实世界工作流（如订餐、生成文档），或能在 ChatGPT 内开创全新、完全 AI 原生的体验。我们建议您尽早查阅 [应用提交指南⁠(在新窗口中打开)](https://developers.openai.com/apps-sdk/app-developer-guidelines)，以助您打造高质量应用。更多技术文档与示例代码，请参阅 [开发者资源中心⁠(在新窗口中打开)](https://developers.openai.com/apps-sdk)。

Once ready, developers can submit apps for review and track approval status in the [OpenAI Developer Platform⁠(opens in a new window)](https://platform.openai.com/apps-manage). Submissions include MCP connectivity details, testing guidelines, directory metadata, and country availability settings. The first set of approved apps will begin rolling out gradually in the new year. Apps that meet our quality and safety standards are eligible to be published in the app directory, and apps that resonate with users may be featured more prominently in the directory or recommended by ChatGPT in the future.

准备就绪后，开发者即可通过 [OpenAI 开发者平台⁠(在新窗口中打开)](https://platform.openai.com/apps-manage) 提交应用以供审核，并实时追踪审批进度。提交内容包括 MCP 连接配置、测试指引、应用目录元数据及国家/地区可用性设置等。首批通过审核的应用将于新年伊始逐步上线。凡符合我们质量与安全标准的应用，均有资格发布至应用目录；而深受用户欢迎的应用，则有望在目录中获得更显著的展示位置，或未来由 ChatGPT 主动向用户推荐。

In this early phase, developers can link out from their ChatGPT apps to their own websites or native apps to complete transactions for physical goods. We’re exploring additional monetization options over time, including digital goods, and will share more as we learn from how developers and users build and engage.

在这一早期阶段，开发者可从其 ChatGPT 应用跳转至自有网站或原生应用，以完成实体商品的交易。我们正持续探索更多变现方式（例如数字商品），并将根据开发者与用户在构建和使用应用过程中的反馈，逐步公布更多信息。

## Safety and privacy

## 安全与隐私

All developers are required to follow the [app submission guidelines⁠(opens in a new window)](https://developers.openai.com/apps-sdk/app-developer-guidelines) around safety, privacy, and transparency. Apps must comply with OpenAI’s usage policies, be appropriate for all audiences, and adhere to third-party terms of service when accessing their content. Developers must include clear privacy policies with every app submission and we require developers to only request the information needed to make their apps work.

所有开发者均须遵守关于安全、隐私与透明度的[应用提交指南⁠(在新窗口中打开)](https://developers.openai.com/apps-sdk/app-developer-guidelines)。应用必须符合 OpenAI 的使用政策，面向所有受众适宜，并在访问第三方内容时遵守其服务条款。开发者每次提交应用时，均须附上清晰明确的隐私政策；同时，我们要求开发者仅请求应用正常运行所必需的信息。

When a user connects to a new app, we will disclose what types of data may be shared with the third party and provide the app’s privacy policy for review. And users are always in control: disconnect an app at any time, and it immediately loses access.

当用户首次连接某个新应用时，我们将明确告知其可能共享给第三方的数据类型，并提供该应用的隐私政策供用户审阅。用户始终掌握控制权：可随时断开任一应用的连接，断开后该应用将立即失去全部访问权限。

## Looking ahead

## 展望未来

This is just the beginning. Over time, we want apps in ChatGPT to feel like a natural extension of the conversation, helping people move from ideas to action, while building a thriving ecosystem for developers. As we learn from developers and users, we’ll continue refining the experience for everyone. We also plan to grow the ecosystem of apps in ChatGPT, make apps easier to discover, and expand the ways developers can reach users and monetize their work.

这仅仅是个开始。未来，我们希望 ChatGPT 中的应用能成为对话的自然延伸，帮助用户将想法迅速转化为行动，同时为开发者构建一个蓬勃发展的生态系统。我们将持续从开发者与用户的实践中汲取经验，不断优化所有人的使用体验。此外，我们还计划拓展 ChatGPT 应用生态的规模，提升应用的可发现性，并丰富开发者触达用户及实现商业价值的途径。

- [2025](https://openai.com/news/?tags=2025)
&#123;% endraw %}
