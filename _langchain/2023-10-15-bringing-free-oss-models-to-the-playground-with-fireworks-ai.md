---
title: "Bringing Free OSS Models to the Playground with Fireworks AI"
source: "LangChain Blog"
url: "https://blog.langchain.com/bringing-free-oss-models-to-the-playground-with-fireworks-ai/"
date: "2023-10-15"
scraped_at: "2026-03-03T08:35:39.102324947+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

A year ago, the only real LLM people were using was OpenAI's GPT-3. Fast forward to now, and there are a multitude of models to choose from - including a wide variety of open source models. These open source models have seen large performance gains over the past six months in particular. As these models get better, we've seen more and more people wanting to try them out. We've teamed up with [Fireworks AI](https://app.fireworks.ai/?ref=blog.langchain.com) to bring these models to the LangSmith playground - completely free of cost (for now, we'll see how expensive this gets).

一年前，人们实际使用的唯一真正大语言模型（LLM）还是 OpenAI 的 GPT-3。转眼至今，可供选择的模型已层出不穷——其中包括大量开源模型（OSS models）。尤其是过去六个月，这些开源模型在性能上取得了显著提升。随着模型能力不断增强，越来越多的人希望亲自尝试它们。我们已与 [Fireworks AI](https://app.fireworks.ai/?ref=blog.langchain.com) 展开合作，将这些模型接入 LangSmith Playground——目前完全免费（后续成本尚待观察）。

What does mean exactly?

这具体意味着什么？

Concretely, we have integrated [Fireworks AI](https://app.fireworks.ai/?ref=blog.langchain.com) into the playground, joining the ranks of OpenAI, Anthropic and Vertex AI as supported model providers. Read more about Fireworks AI below, but at a high level they provide API access to a plethora of OSS models. While other model providers in the playground require an API key to use, we've worked with Fireworks AI to enable anyone to use this integration regardless of whether they have an API key or not (note: you need to be signed into the LangSmith platform in order for this to work).

具体而言，我们已将 [Fireworks AI](https://app.fireworks.ai/?ref=blog.langchain.com) 集成至 Playground，使其与 OpenAI、Anthropic 和 Vertex AI 并列成为 LangSmith Playground 所支持的模型提供商之一。关于 Fireworks AI 的更多详情请参见下文；简言之，它为海量开源模型（OSS models）提供 API 接入能力。目前 Playground 中其他模型提供商均需用户提供 API 密钥方可调用，而我们与 Fireworks AI 协作，实现了无需 API 密钥即可直接使用该集成（注意：您需先登录 LangSmith 平台，此功能方可生效）。

This now means it is easier than ever to try out prompts with an OSS model. Let's walk through an example of this!

这意味着，如今使用开源模型测试提示词（prompt）比以往任何时候都更加便捷！下面让我们通过一个实例来演示操作流程。

First, let's go the [LangSmith Hub](https://smith.langchain.com/hub?ref=blog.langchain.com). We can filter existing prompts in the hub to ones that are meant for Llama-2. Note: this is a manual tagging, so it could be incorrect, but it's a good start.

首先，请访问 [LangSmith Hub](https://smith.langchain.com/hub?ref=blog.langchain.com)。我们可在 Hub 中筛选出专为 Llama-2 设计的现有提示词。注意：此类标签为人工标注，可能存在误差，但作为初步筛选已足够实用。

![](images/bringing-free-oss-models-to-the-playground-with-fireworks-ai/img_001.png)

Let's choose the [`hwchase17/llama-rag` prompt](https://smith.langchain.com/hub/hwchase17/llama-rag?ref=blog.langchain.com). Once on this page, we can click on "Try it" to open it in the playground.

我们选择 [`hwchase17/llama-rag` 提示词](https://smith.langchain.com/hub/hwchase17/llama-rag?ref=blog.langchain.com)。进入该页面后，点击“Try it”（立即试用），即可在 Playground 中打开该提示词。

![](images/bringing-free-oss-models-to-the-playground-with-fireworks-ai/img_002.png)

The playground defaults to OpenAI, but we can click on the model provider to change it up.

Playground 默认使用 OpenAI 模型，但我们可点击当前模型提供商名称，切换为其他选项。

![](images/bringing-free-oss-models-to-the-playground-with-fireworks-ai/img_003.png)

From here, we can select the Fireworks option.

从此处，我们可以选择 Fireworks 选项。

![](images/bringing-free-oss-models-to-the-playground-with-fireworks-ai/img_004.png)

We can now select the model we want to use, and then plug in some inputs and hit run!

现在我们可以选择想要使用的模型，然后输入一些提示内容并点击运行！

![](images/bringing-free-oss-models-to-the-playground-with-fireworks-ai/img_005.png)

## What is Fireworks?

## 什么是 Fireworks？

[Fireworks.ai](https://app.fireworks.ai/?ref=blog.langchain.com) provides a platform to enable developers to run, fine-tune, and share large language models (LLMs) to best solve product problems.

[Fireworks.ai](https://app.fireworks.ai/?ref=blog.langchain.com) 提供一个平台，帮助开发者运行、微调和共享大语言模型（LLM），从而更高效地解决产品实际问题。

The Fireworks.ai Generative AI platform provides developers access to lightning-fast OSS models, LLM inference, and state-of-the-art foundation models for fine-tuning. The platform provides state-of-the-art machine performance for latency-optimized and throughput-optimized settings and cost reduction (up to 20–120x lower) for affordable serving.

Fireworks.ai 生成式 AI 平台为开发者提供超高速开源模型（OSS models）、大语言模型推理能力，以及用于微调的前沿基础模型。该平台在低延迟与高吞吐两种优化场景下均具备业界领先的机器性能，并显著降低成本（降幅高达 20–120 倍），实现经济高效的模型服务。

Integrating Fireworks.ai models in the LangChain Playground means giving the developer community easy access to the best high-performing open-source and fine-tuned models.

将 Fireworks.ai 模型集成至 LangChain Playground，意味着为开发者社区提供便捷途径，以快速访问性能最优的开源模型及微调模型。

The LangChain Prompt Hub already makes it simple to try different prompts, models, and parameters without any coding. The availability of faster inference or faster LLMs helps to further boost productivity in building LLM workflows.

LangChain Prompt Hub 已支持无需编写代码即可轻松尝试不同提示词（prompts）、模型与参数配置。更快的推理速度或更高效的 LLM，将进一步提升构建大语言模型工作流的开发效率。

A big part of the LLM workflow requires testing and optimizing prompts which is a highly iterative and time-consuming process. This integration makes it possible for LangChain Prompt Hub users to more efficiently test and optimize prompts for state-of-the-art open-source and fine-tuned LLMs like Llama 2 70B.

大语言模型工作流中很大一部分工作涉及提示词的测试与优化——这是一项高度迭代且耗时的过程。此次集成使 LangChain Prompt Hub 用户能够更高效地针对 Llama 2 70B 等前沿开源模型及微调模型开展提示词测试与优化。

**Trying Fireworks in the Playground:**

**在 Playground 中试用 Fireworks：**

- Logged-in users can try Fireworks in the playground without an API key, for free!

- 已登录用户可免费在 Playground 中试用 Fireworks，无需提供 API 密钥！

- If you’re not logged in or don’t have an account, but want to try Fireworks, you can get one directly from Fireworks

- 如果您尚未登录，或还没有账号，但希望试用 Fireworks，可直接通过 Fireworks 获取一个账号。

**Below are the instructions to set up an account with Fireworks.ai:**

**以下是注册 Fireworks.ai 账号的操作步骤：**

- Step 1: Visit [app.fireworks.ai](https://app.fireworks.ai/?ref=blog.langchain.com).

- 第一步：访问 [app.fireworks.ai](https://app.fireworks.ai/?ref=blog.langchain.com)。

- Step 2: Click the "Sign In" button in the top navigation bar.

- 第二步：点击顶部导航栏中的 “Sign In”（登录）按钮。

- Step 3: Click "Continue with Google" and authenticate with your Google account. A new Fireworks developer account will be provisioned for you the first time you sign in.

- 第三步：点击 “Continue with Google”（使用 Google 继续），并使用您的 Google 账号完成身份验证。首次登录时，系统将自动为您创建一个新的 Fireworks 开发者账号。

- Step 4: Next, we'll provision a new API key. Click on "API Keys" in the left navigation bar then Click on "New API Key" and give your new API key a name.

- 第四步：接下来，我们将为您生成一个新的 API 密钥。请在左侧导航栏中点击 “API Keys”（API 密钥），然后点击 “New API Key”（新建 API 密钥），并为该密钥指定一个名称。

- Step 5: Now open-source models like Llama 2 13B Chat are ready to be used in the LangChain Playground.

- 第五步：现在，Llama 2 13B Chat 等开源模型已可在 LangChain Playground 中直接使用。

- Step 6: You can enter you API key in the `Secrets & API Keys` section in the playground

- 第六步：您可在 Playground 的 `Secrets & API Keys`（密钥与 API 密钥）区域中输入您的 API 密钥。
&#123;% endraw %}
