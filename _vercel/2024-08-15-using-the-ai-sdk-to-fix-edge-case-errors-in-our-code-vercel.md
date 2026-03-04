---
title: "Using the AI SDK to fix edge-case errors in our code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code"
date: "2024-08-15"
scraped_at: "2026-03-02T09:41:52.458603734+00:00"
language: "en-zh"
translated: true
description: "Leveraging the AI SDK to build with and solve problems with AI"
---
&#123;% raw %}

Aug 15, 2024

2024年8月15日

我们 Vercel 团队如何利用基于 AI 的逻辑，优化国际域名（IDN）的域名注册体验。

最近，我们的客户在购买包含非英文字符的域名时遇到了问题。当此类域名购买持续失败时，这一问题变得尤为明显，严重阻碍了希望借助国际化域名（IDN）拓展其线上影响力的用户。

### Bug 背景

问题根源在于编码过程。含非英文字符的域名需以 Punycode 格式进行编码。该编码方式使大量国际字符得以通过 ASCII 标准有限的字符集进行表示。然而，当我们把这些已编码的域名发送至域名注册商 OpenSRS 时，却收到了含义模糊的错误信息，几乎无法揭示问题本质。

![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_001.jpg)![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_002.jpg)

通过深入研读 OpenSRS 官方文档，我们发现：注册 Punycode 域名时，必须同时提供一个关联的语言代码（language code）。尽管我们的系统中已预留了该语言代码字段，但它被设为可选，因而实际并未启用——这一疏漏正是问题的关键所在。

接下来的挑战是：如何为每个域名准确确定对应的语言代码。最初，我们尝试使用 Common Language Detector 2（CLD2）——一款专用于文本语言识别的开源库。遗憾的是，域名长度过短，导致 CLD2 无法准确判定其语言。

### AI：我们最宝贵的“球员”

为解决这一难题，我们转向了 [Vercel AI SDK](https://sdk.vercel.ai/docs/introduction)。该 AI SDK 是我们推出的开源工具包，旨在简化 AI 模型在应用中的集成与部署流程。其统一接口支持对接多种 AI 模型与服务商，让您仅需极少的代码改动，即可在不同模型间无缝切换。

First, we chose a method. We went with `generateText` because we needed a singular text output in the form of a 3 character language code. Since this process isn't interactive, meaning there's no back and forth with the user, there's no need to use streamText. We didn’t need generateObject either, which uses schemas to give you structured data, because our use case isn't complex enough to require object generation.

首先，我们选择了一种方法。我们采用了 `generateText`，因为我们只需要一个单一的文本输出——即一个三位字符的语言代码。由于该流程是非交互式的（即无需与用户进行多轮对话），因此无需使用 `streamText`；我们也不需要 `generateObject`（它通过 schema 输出结构化数据），因为当前用例的复杂度尚不足以要求生成对象。

With the AI SDK, we can easily test out different [models](https://sdk.vercel.ai/docs/foundations/providers-and-models) and look for the best accuracy with a large enough context window for us to pass in the list of language codes we wanted the model to choose from. This led us to GPT-4o from [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai).

借助 AI SDK，我们可以轻松测试多种 [模型](https://sdk.vercel.ai/docs/foundations/providers-and-models)，在具备足够大上下文窗口的前提下，评估各模型的准确率——该上下文窗口需能容纳我们提供给模型供其选择的语言代码列表。最终，我们选定 [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai) 的 GPT-4o 模型。

GPT-4o was able to determine the appropriate language code for each domain. The results were remarkable. The AI successfully identified the correct language codes, even for the shortest and most complex domain names.

GPT-4o 成功为每个域名确定了对应的语言代码。结果令人瞩目：即便面对最短或最复杂的域名，AI 仍能精准识别出正确的语言代码。

![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_003.jpg)![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_004.jpg)

![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_003.jpg)![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_004.jpg)

**We rigorously tested the solution provided by GPT-4o on previously failed domain purchases of the last two months and achieved a 100% success rate.** Encouraged by these results, we deployed the solution to production. Since then, we've had numerous successful Punycode domain purchases, marking a significant improvement in our system's user experience.

**我们对 GPT-4o 提供的解决方案进行了严格测试，覆盖过去两个月内所有曾失败的域名购买案例，最终实现了 100% 的成功率。** 受此结果鼓舞，我们将该方案正式部署至生产环境。自此，我们已成功完成大量 Punycode 域名购买，显著提升了系统用户体验。

### Leveraging AI in every development process

### 在每个开发环节中善用 AI

Turning to AI to solve complex problems is becoming second nature. Thanks to the AI SDK, our system correctly handles Punycode domains with the appropriate language codes, we've removed a significant barrier for our international users and enhanced the overall functionality of our platform.

借助 AI 解决复杂问题正日益成为开发者的本能反应。得益于 AI SDK，我们的系统如今能够基于恰当的语言代码正确处理 Punycode 域名，从而消除了国际用户的一大使用障碍，并全面增强了平台的功能性。

[**Unlock rapid AI development**\\
\\
Build AI-powered applications with the AI SDK. \\
\\
Get started with the AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)

[**释放 AI 快速开发潜能**\\
\\
使用 AI SDK 构建 AI 驱动的应用程序。\\
\\
立即开始使用 AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)
&#123;% endraw %}
