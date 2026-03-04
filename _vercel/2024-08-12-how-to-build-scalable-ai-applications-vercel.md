---
title: "How to build scalable AI applications - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-build-scalable-ai-applications"
date: "2024-08-12"
scraped_at: "2026-03-02T09:42:04.165807411+00:00"
language: "en-zh"
translated: true
description: "Explore AI integration strategies with Vercel's AI SDK. Learn to choose providers, optimize performance, and future-proof your apps. Discover tools for seamless AI deployment and scalability."
---
{% raw %}

Aug 12, 2024

2024 年 8 月 12 日

基础设施、数据与开发的最佳实践。

In today's AI-driven landscape, your business's competitive edge lies in how effectively you integrate AI into your product and workflows.

在当今以 AI 为驱动力的商业环境中，企业竞争优势取决于您将 AI 高效融入产品与工作流的能力。

This guide focuses on three critical aspects of building scalable AI applications:

本指南聚焦于构建可扩展 AI 应用的三大关键环节：

1. Choosing and implementing AI models as they release  
   1. 在模型发布时及时选型并落地实施 AI 模型  

2. Managing and preparing your unique data for AI  
   2. 管理并为 AI 准备您独有的数据  

3. Developing and optimizing future-proof infrastructure  
   3. 构建并优化面向未来的稳健基础设施  

## Choosing the right provider

## 选择合适的 AI 服务提供商

Choosing AI providers, such as OpenAI, Anthropic, and Google—or even fine-tuning or rolling your own model—can be daunting.

选择 AI 服务提供商（例如 OpenAI、Anthropic 或 Google），甚至自行微调模型或从头训练专属模型，都可能令人望而生畏。

While each has pros and cons, the [Vercel AI SDK](https://sdk.vercel.ai/docs/introduction) offers the flexibility to work with multiple providers, allowing you to take advantage of each of their best features without being locked into a single ecosystem.

尽管各家服务商各具优劣，但 [Vercel AI SDK](https://sdk.vercel.ai/docs/introduction) 提供了跨多平台的灵活支持，使您得以融合各家优势功能，同时避免被锁定于单一技术生态。

Full model portability like this enables you to:

像这样实现完整的模型可移植性，使您能够：

- Easily switch providers to optimize for different strengths (speed vs. world knowledge vs. coding expertise, etc.)

  轻松切换服务商，以针对不同优势进行优化（例如速度、世界知识、编程专长等）。

- Experiment quickly and concretely with different models using environment variables or feature flags

  借助环境变量或功能开关，快速且切实地试验不同模型。

- Match model capability and price to task

  将模型能力与价格精准匹配至具体任务需求。

- Future-proof your application, so it can always be powered by the top-performing models and evolutions in the AI landscape

  为您的应用提供面向未来的保障，使其始终由性能最优的模型及 AI 领域的最新演进成果驱动。

### Building for the future of AI

### 面向 AI 的未来而构建

Architecting for multi-modality and the next evolution in AI—generative UI—is crucial for future-proofing your applications.

面向多模态能力以及 AI 下一阶段演进——生成式 UI（Generative UI）进行架构设计，对保障应用的长期适应性至关重要。

With [recent updates to the AI SDK](https://vercel.com/blog/ai-sdk-3-generative-ui), developers can now stream UI components directly from AI models, enabling dynamic, AI-generated user interfaces. This allows for real-time, context-aware UI generation.

借助 [AI SDK 的最新更新](https://vercel.com/blog/ai-sdk-3-generative-ui)，开发者现在可直接从 AI 模型流式传输 UI 组件，从而实现动态、由 AI 生成的用户界面。这使得实时、上下文感知的 UI 生成成为可能。

[The SDK also supports multi-modal AI](https://vercel.com/blog/vercel-ai-sdk-3-3), which allows for sophisticated AI applications that can process and generate diverse content types. This enables you to create features like image analysis, audio transcription, text-to-speech capabilities, and much more.

[该 SDK 同样支持多模态 AI](https://vercel.com/blog/vercel-ai-sdk-3-3)，可助力构建功能强大的 AI 应用，处理并生成多种类型的内容。由此，您可开发出图像分析、语音转文字、文本转语音等丰富功能，以及其他更多可能性。

With Vercel and the AI SDK, you can worry less about making the right choice and instead [spin up entire AI proofs-of-concept](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk) in just a few hours. At Vercel, for instance, we use feature flags and the AI SDK to quickly evaluate various providers for [generating UI in v0](https://v0.dev/).

借助 Vercel 与 AI SDK，您无需过度纠结于“选对”某个方案，而可仅用数小时便 [快速搭建起完整的 AI 概念验证（PoC）](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk)。例如，在 Vercel，我们即通过功能开关与 AI SDK，快速评估多个服务商在 [v0 中生成 UI](https://v0.dev/) 的效果。

Integrating any model into your app with the AI SDK is just a few lines of code:

使用 AI SDK 将任意模型集成到您的应用中，仅需几行代码：

```tsx
import { generateText } from "ai";

import { anthropic } from "@ai-sdk/anthropic";



const { text } = await generateText({

5  model: anthropic("claude-3-5-sonnet-20240620"),

6  prompt: "What is the best way to architect an AI application?",

7});
```

### Third-party, fine-tuning, or in-house models

### 第三方模型、微调模型或自研模型

Depending on your use case, you may use pre-trained models, fine-tune existing models, or develop custom models in-house.

具体采用哪种方式，取决于您的实际应用场景：您可以直接使用预训练模型，也可以对现有模型进行微调，或者在内部自主研发定制化模型。

- **Pre-trained models:** Today's LLMs are extremely capable out of the box, with offerings that keep your data completely secure. Thoroughly test existing options before opting for additional complexity.

- **预训练模型：** 当今的大语言模型（LLM）开箱即用便已极为强大，且主流方案可确保您的数据完全安全。在引入额外复杂性之前，请务必对现有选项进行充分测试。

- **Fine-tuning:** Most major providers offer straightforward paths to fine-tune models for specialized tasks or training on your business's data.

- **微调（Fine-tuning）：** 大多数主流服务商均提供便捷的路径，支持针对特定任务或基于您企业自有数据对模型进行微调。

- **Custom model:** Introduces extreme complexity but is sometimes required for very unique workloads (competitive advantage) or instances where data privacy is paramount (banking, healthcare, etc.).

- **自定义模型：** 引入极高复杂度，但有时确属必要——例如面向高度独特的工作负载（以构建竞争优势），或在数据隐私要求至高无上的场景中（如金融、医疗等领域）。

Whichever route you go, you can still use [all the conveniences of the AI SDK](https://sdk.vercel.ai/providers/community-providers/custom-providers).

无论您选择哪条路径，仍可继续使用 [AI SDK 提供的所有便利功能](https://sdk.vercel.ai/providers/community-providers/custom-providers)。

## Data cleansing and management

## 数据清洗与管理

Well-prepared data is fundamental to the success of any AI initiative. Whether you're fine-tuning models or leveraging out-of-the-box LLMs with Retrieval-Augmented Generation (RAG), ensuring high-quality, domain-specific data is crucial.

高质量、准备充分的数据，是任何人工智能项目成功的基础。无论您是在对模型进行微调，还是直接使用开箱即用的大语言模型并结合检索增强生成（RAG）技术，确保数据的高质量与领域相关性都至关重要。

When implementing AI, consider these key aspects of data management:

在实施人工智能时，请重点关注以下数据管理核心环节：

1. **Data cleaning and normalization:** Remove inconsistencies, errors, and outliers from your dataset while standardizing formats to ensure uniformity across all data points.

1. **数据清洗与标准化：** 从数据集中剔除不一致项、错误数据及异常值，并统一数据格式，以确保所有数据点的一致性与规范性。

2. **Handling missing or inconsistent data:** Develop strategies to address gaps in your data, such as filling in missing values with educated estimates or creating clear rules for dealing with incomplete records, to maintain the integrity and usefulness of your dataset.

2. **处理缺失或不一致的数据：** 制定应对数据缺口的策略，例如采用合理估算填充缺失值，或为不完整记录设定明确的处理规则，从而保障数据集的完整性与实用性。

3. **Ensuring data diversity and representativeness:** To prevent biases and improve model generalization, strive for a dataset that accurately reflects the variety and distribution of real-world scenarios your AI will encounter. Monitor performance carefully to avoid overfitting.

3. **确保数据的多样性与代表性：** 为避免模型偏差、提升泛化能力，应力求构建能真实反映人工智能系统在实际应用中所面临各类场景及其分布特征的数据集。同时需密切监控模型性能，防止过拟合。

4. **Managing large datasets efficiently:** Implement scalable data storage and processing solutions, such as distributed computing or cloud-based services, to handle large data without compromising performance or accessibility.

4. **高效管理大规模数据集：** 实施可扩展的数据存储与处理方案（例如分布式计算或基于云的服务），以应对海量数据，同时不牺牲性能或可访问性。

![Preparing data for AI isn’t a straight shot—it’s a cycle of refinement.](images/how-to-build-scalable-ai-applications-vercel/img_001.jpg)![Preparing data for AI isn’t a straight shot—it’s a cycle of refinement.](images/how-to-build-scalable-ai-applications-vercel/img_002.jpg)![Preparing data for AI isn’t a straight shot—it’s a cycle of refinement.](images/how-to-build-scalable-ai-applications-vercel/img_003.jpg)![Preparing data for AI isn’t a straight shot—it’s a cycle of refinement.](images/how-to-build-scalable-ai-applications-vercel/img_004.jpg)Preparing data for AI isn’t a straight shot—it’s a cycle of refinement.

![为 AI 准备数据并非一蹴而就——而是一个持续精炼的循环过程。](images/how-to-build-scalable-ai-applications-vercel/img_001.jpg)![为 AI 准备数据并非一蹴而就——而是一个持续精炼的循环过程。](images/how-to-build-scalable-ai-applications-vercel/img_002.jpg)![为 AI 准备数据并非一蹴而就——而是一个持续精炼的循环过程。](images/how-to-build-scalable-ai-applications-vercel/img_003.jpg)![为 AI 准备数据并非一蹴而就——而是一个持续精炼的循环过程。](images/how-to-build-scalable-ai-applications-vercel/img_004.jpg)为 AI 准备数据并非一蹴而就——而是一个持续精炼的循环过程。

### -techniques) Retrieval-augmented generation (RAG) techniques

### -techniques) 检索增强生成（RAG）技术

For many applications, [RAG offers a powerful alternative to fine-tuning](https://sdk.vercel.ai/docs/guides/rag-chatbot). RAG allows you to enhance out-of-the-box LLM outputs with your specific data, improving accuracy and relevance without the complexity of model training.

对许多应用场景而言，[RAG 提供了一种强大且无需微调的替代方案](https://sdk.vercel.ai/docs/guides/rag-chatbot)。RAG 能够利用您专属的数据增强开箱即用的大语言模型（LLM）输出，在不涉及复杂模型训练的前提下，显著提升响应的准确性与相关性。

While basic RAG implementations are powerful, there are several advanced techniques to consider:

尽管基础版 RAG 已具备强大能力，但仍有一些进阶技术值得深入探索：

1. **Multi-modal RAG:** Expand your knowledge base beyond text to include images, audio, and video. For example, you could use image embeddings to retrieve relevant visuals alongside text, enhancing the context provided to the LLM.

1. **多模态 RAG：** 将知识库从纯文本拓展至图像、音频和视频等多模态数据。例如，可借助图像嵌入（image embeddings）同步检索相关视觉内容与文本，从而为大语言模型提供更丰富的上下文信息。

2. **Dynamic RAG:** Update your knowledge base in real time, ensuring the model can always access the most current information. This can be achieved by implementing a system that continuously ingests new data and updates the vector store, as demonstrated in the [Vercel AI SDK guide](https://sdk.vercel.ai/docs/guides/rag-chatbot#step-3-implement-rag).

2. **动态 RAG：** 实现实时更新知识库，确保模型始终能获取最新信息。这可通过构建一套持续摄入新数据并同步更新向量数据库（vector store）的系统来实现，具体实现方式可参考 [Vercel AI SDK 指南](https://sdk.vercel.ai/docs/guides/rag-chatbot#step-3-implement-rag)。

3. **Personalized RAG:** Tailor the retrieval process to individual users based on their preferences or context. This could involve maintaining user-specific vector stores or applying user-based filters to the retrieval results.

3. **个性化 RAG：** 根据用户的偏好或上下文，定制化检索流程。例如，可为每位用户维护独立的向量数据库，或在检索结果中应用基于用户身份的过滤机制。

4. **Explainable RAG:** Enhance the system's ability to provide clear explanations and cite specific sources, improving transparency and trust. This can be implemented by including metadata with each chunk and instructing the LLM to reference these sources in its responses.

4. **可解释 RAG：** 强化系统提供清晰解释并准确引用具体来源的能力，从而提升透明度与用户信任度。该目标可通过为每个文本块（chunk）附加元数据，并指导大语言模型在生成回复时明确引用这些来源来实现。

These advanced techniques can significantly improve the capabilities of your AI application, allowing for more versatile, up-to-date, and user-centric responses.

上述进阶技术可显著增强您 AI 应用的能力，使其响应更加多样化、时效性强且以用户为中心。

### Simplified implementation with Vercel

### 使用 Vercel 简化实现

Vercel's platform simplifies the implementation of RAG and other data-intensive AI workflows, enabling developers to create intuitive interfaces that set applications apart. This frontend-focused approach ensures that AI is seamlessly integrated into a superior user experience.

Vercel 平台简化了 RAG 及其他数据密集型 AI 工作流的实现，使开发者能够构建直观的界面，从而让应用脱颖而出。这种以前端为中心的方法确保 AI 无缝融入卓越的用户体验。

The AI SDK, with Next.js' powerful data fetching patterns and Vercel's [Secure Compute](https://vercel.com/docs/security/secure-compute), streamlines connecting various data sources and APIs to inform LLM answers. This approach allows you to leverage existing models while incorporating your proprietary data, offering a more straightforward path to enterprise-grade AI applications.

AI SDK 结合 Next.js 强大的数据获取模式以及 Vercel 的 [Secure Compute（安全计算）](https://vercel.com/docs/security/secure-compute)，可大幅简化各类数据源与 API 的接入流程，从而为大语言模型（LLM）的回答提供信息支撑。该方法使您既能复用现有模型，又能融合自有专有数据，为构建企业级 AI 应用提供一条更直接、更高效的路径。

Keep in mind that AI— [especially agentic workflows](https://sdk.vercel.ai/docs/ai-sdk-core/agents)—can help you automate this whole process. Implementing data preparation workflows on Vercel can be a great way to get your feet wet deploying low-risk AI workloads.

请记住，AI——[尤其是基于智能体（agent）的工作流](https://sdk.vercel.ai/docs/ai-sdk-core/agents)——可帮助您自动化整个流程。在 Vercel 上实现数据准备工作流，是初次尝试部署低风险 AI 工作负载的理想切入点。

[**The quickest way to build and secure AI features.**\\
\\
There’s no need to wait for your current platform to catch up. Build intelligent, user-centric applications that deliver exceptional experiences.\\
\\
Get Started](https://vercel.com/resources/the-quickest-way-to-build-and-secure-ai-features)

[**构建并保障 AI 功能的最快方式。**\\
\\
无需等待当前平台逐步跟进。立即打造智能化、以用户为中心的应用，交付卓越体验。\\
\\
立即开始](https://vercel.com/resources/the-quickest-way-to-build-and-secure-ai-features)

## Choosing the right infrastructure

## 选择合适的基础设施

Selecting the best infrastructure for your AI application means ensuring performance, scalability, cost-effectiveness, and reliability.

为您的 AI 应用选择最合适的基础设施，意味着必须兼顾性能、可扩展性、成本效益与可靠性。

When choosing your infrastructure, consider these factors:

在选择基础设施时，请考虑以下因素：

- **Latency:** Users expect quick responses, even from AI-powered features.

- **延迟：** 用户期望快速响应，即使是 AI 驱动的功能也不例外。

- **Caching:** Efficient caching reduces latency and minimizes redundant AI computations.

- **缓存：** 高效的缓存机制可降低延迟，并减少重复的 AI 计算。

- **Streaming capability:** Stream AI responses for real-time interaction.

- **流式响应能力：** 流式传输 AI 响应，以支持实时交互。

- **Long-running processes:** Some AI tasks may exceed typical serverless time limits.

- **长时间运行的任务：** 某些 AI 任务可能超出典型的无服务器（serverless）执行时间限制。

- **Scalability:** Your infrastructure should handle variable workloads and traffic spikes.

- **可扩展性：** 您的基础设施需能应对多变的工作负载与突发流量。

- **Memory and compute:** AI models can be resource-intensive and require robust hardware.

- **内存与算力：** AI 模型通常资源消耗较高，需要强劲的硬件支撑。

- **Developer experience:** Choose a platform that prioritizes developer productivity.

- **开发者体验：** 选择以提升开发者生产力为优先考量的平台。

- **Frontend framework support:** Compatibility with modern frontend frameworks for building responsive, future-proof user interfaces powered by AI.

- **前端框架支持：** 兼容现代前端框架，便于构建响应迅速、面向未来、由 AI 驱动的用户界面。

- **Data storage and retrieval:** Efficient handling of large datasets is crucial for AI performance.

- **数据存储与检索：** 高效处理大规模数据集对 AI 性能至关重要。

- **Integration:** Ensure compatibility with your existing tech stack and AI providers.

- **集成能力：** 确保与您现有的技术栈及 AI 服务提供商兼容。

- **Cost:** Balance per-token pricing, infrastructure costs, and development resources against potential ROI. If you create your own model or extensively fine-tune, factor in costs for GPUs and cross-functional labor.

- **成本：** 在单次 token 计费、基础设施开销与开发资源投入之间取得平衡，并对照潜在的投资回报率（ROI）进行评估。若您自行训练模型或进行大量微调，还需计入 GPU 硬件成本及跨职能团队的人力投入。

You can solve these challenges with cloud providers like AWS, Google Cloud, and Azure, but you'll [spend quite a bit of time](https://vercel.com/resources/hidden-costs-of-self-hosted-frontends) setting up and maintaining complex configurations.

上述挑战可通过 AWS、Google Cloud 和 Azure 等云服务商解决，但您将[花费大量时间](https://vercel.com/resources/hidden-costs-of-self-hosted-frontends)来配置和维护复杂的系统环境。

Vercel provides an AI-native experience out of the box, reducing ongoing operational costs and ensuring that any single frontend developer can innovate at the moment of inspiration.

Vercel 开箱即用地提供面向 AI 的原生体验，显著降低持续运营成本，并确保任意一名前端开发者都能在灵感迸发的瞬间快速创新。

1. **Edge Network:** Vercel's Edge Network serves billions of requests globally, using next-gen technology to [deliver dynamic AI workloads at the speed of the static web](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud).

1. **边缘网络（Edge Network）：** Vercel 边缘网络在全球范围内处理数十亿次请求，采用新一代技术，[以静态网页的速度交付动态 AI 工作负载](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)。

2. **Streaming serverless functions:** Vercel Functions support [streaming responses and long-running tasks](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions), ideal for real-time interaction and incremental LLM responses.

2. **支持流式响应的无服务器函数（Streaming serverless functions）：** Vercel Functions 支持[流式响应与长时间运行任务](https://vercel.com/blog/streaming-for-serverless-node-js-and-edge-runtimes-with-vercel-functions)，非常适合实时交互及大语言模型（LLM）的渐进式响应。

3. **Scalable compute:** Vercel's serverless infrastructure means that even the spikiest workloads are perfectly balanced—with zero configuration needed. [99.99% uptime guaranteed](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud).

3. **弹性可扩展的计算能力（Scalable compute）：** Vercel 的无服务器基础设施可自动均衡处理峰值负载——无需任何配置。[承诺 99.99% 的正常运行时间](https://vercel.com/blog/the-resiliency-of-the-frontend-cloud)。

4. **Powerful, automated frontends:** Vercel and the AI SDK support [35+ frontend frameworks](https://vercel.com/docs/frameworks/more-frameworks), using [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure) to ensure developers don't need to write a single line of configuration code.

4. **强大且自动化的前端（Powerful, automated frontends）：** Vercel 与 AI SDK 支持[35+ 种前端框架](https://vercel.com/docs/frameworks/more-frameworks)，并借助[框架定义的基础设施（Framework-defined infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)，确保开发者无需编写任何配置代码。

5. **Data integration:** Vercel's [serverless-enabled storage options](https://vercel.com/docs/storage) and [seamless integrations with third-party providers](https://vercel.com/integrations) mean that you always have access to the best data shape for the job at hand.

5. **数据集成（Data integration）：** Vercel 提供[支持无服务器架构的存储选项](https://vercel.com/docs/storage)以及[与第三方服务商的无缝集成](https://vercel.com/integrations)，确保您始终能为当前任务选用最合适的数据形态。

For any piece of the puzzle not solvable on Vercel—namely, training and hosting a custom model—keep in mind that you can seamlessly and securely connect Vercel's Frontend Cloud to your custom backend infrastructure with [Secure Compute](https://vercel.com/resources/simplify-your-kubernetes-frontend-deployment-with-vercel).

对于 Vercel 无法直接解决的部分——尤其是自定义模型的训练与托管——请牢记：您可通过 [Secure Compute](https://vercel.com/resources/simplify-your-kubernetes-frontend-deployment-with-vercel)，安全、无缝地将 Vercel 前端云连接至您自建的后端基础设施。

![Vercel serves as the intersection between AI, your backend data, and your user-facing frontend.](images/how-to-build-scalable-ai-applications-vercel/img_005.jpg)![Vercel serves as the intersection between AI, your backend data, and your user-facing frontend.](images/how-to-build-scalable-ai-applications-vercel/img_006.jpg)![Vercel serves as the intersection between AI, your backend data, and your user-facing frontend.](images/how-to-build-scalable-ai-applications-vercel/img_007.jpg)![Vercel serves as the intersection between AI, your backend data, and your user-facing frontend.](images/how-to-build-scalable-ai-applications-vercel/img_008.jpg)Vercel serves as the intersection between AI, your backend data, and your user-facing frontend.

![Vercel 是 AI、您的后端数据与面向用户的前端三者交汇的核心平台。](images/how-to-build-scalable-ai-applications-vercel/img_005.jpg)![Vercel 是 AI、您的后端数据与面向用户的前端三者交汇的核心平台。](images/how-to-build-scalable-ai-applications-vercel/img_006.jpg)![Vercel 是 AI、您的后端数据与面向用户的前端三者交汇的核心平台。](images/how-to-build-scalable-ai-applications-vercel/img_007.jpg)![Vercel 是 AI、您的后端数据与面向用户的前端三者交汇的核心平台。](images/how-to-build-scalable-ai-applications-vercel/img_008.jpg)Vercel 是 AI、您的后端数据与面向用户的前端三者交汇的核心平台。

## Optimizing AI application performance

## 优化 AI 应用性能

While choosing the right infrastructure is crucial, optimizing your AI application's performance is equally important for delivering a smooth user experience and managing costs effectively. Here are some key strategies to consider.

尽管选择合适的基础设施至关重要，但优化 AI 应用的性能同样关键——它直接关系到用户体验的流畅性与成本的有效管控。以下是一些值得重点关注的优化策略。

### Streaming

### 流式传输

Streaming has become a cornerstone of AI apps, allowing for real-time data processing and immediate display of results, which drastically improves the responsiveness of your application.

流式传输已成为 AI 应用的核心能力，支持实时数据处理与结果的即时呈现，从而显著提升应用的响应速度。

The Vercel AI SDK provides a powerful streaming toolkit for all supported frameworks and models. Here's a simple example of how to implement streaming:

Vercel AI SDK 为所有受支持的框架和模型提供了功能强大的流式传输工具包。以下是一个实现流式传输的简单示例：

app/ai/route.ts

```tsx
import { openai } from "@ai-sdk/openai";

import { convertToCoreMessages, streamText } from "ai";



4// Allow streaming responses up to 30 seconds

export const maxDuration = 30;
```

```typescript
export async function POST(req: Request) {

export async function POST(req: Request) {

8  // Extract the `messages` from the body of the request

8  // 从请求体中提取 `messages`

9  const { messages } = await req.json();

9  const { messages } = await req.json();
```

17  // Respond with the stream

17  // 以流形式返回响应

18  return result.toDataStreamResponse();

18  返回 result.toDataStreamResponse();

19}
```

This setup lets you stream AI-generated responses directly to your frontend, providing a more engaging and responsive user experience.

此配置使您能够将 AI 生成的响应直接以流式方式传输至前端，从而提供更具互动性与响应性的用户体验。

To further optimize streaming performance, consider the following techniques:

为进一步优化流式传输性能，请考虑以下技术：

1. **Chunking:** Break down large datasets into smaller, manageable pieces. This allows for faster processing and reduces memory usage.

1. **分块（Chunking）：** 将大型数据集拆分为更小、更易管理的片段。这有助于加快处理速度，并降低内存占用。

2. **Backpressure handling:** Implement mechanisms to manage the [flow of data between the AI model and the client](https://sdk.vercel.ai/docs/advanced/backpressure). This ensures your application remains responsive and doesn't consume unnecessary resources.

2. **背压处理（Backpressure handling）：** 实现机制以管控 [AI 模型与客户端之间的数据流](https://sdk.vercel.ai/docs/advanced/backpressure)。这可确保您的应用保持响应能力，且不会消耗不必要的资源。

3. **Multiple streamables:** For complex UI components, consider [breaking up streams](https://sdk.vercel.ai/docs/advanced/multiple-streamables) into multiple, independently updatable parts. This allows for more granular updates and can further improve the responsiveness of your application.

3. **多个可流式传输对象（Multiple streamables）：** 对于复杂的 UI 组件，可考虑 [将流拆分为多个可独立更新的部分](https://sdk.vercel.ai/docs/advanced/multiple-streamables)。这支持更精细的增量更新，从而进一步提升应用的响应能力。

By implementing these streaming optimizations, you can significantly enhance the performance and efficiency of your AI applications on Vercel's platform. Remember to profile and test your optimizations to ensure they provide tangible benefits for your specific use case.

通过实施上述流式传输优化措施，您可显著提升 AI 应用在 Vercel 平台上的性能与运行效率。请务必对优化效果进行性能分析与测试，以确保其能切实改善您特定应用场景下的体验。

### Caching

### 缓存

Implement caching to store and reuse common AI responses. Vercel offers multiple caching options that can be leveraged to optimize your AI application's performance:

实现缓存以存储并复用常见的 AI 响应。Vercel 提供多种缓存选项，可用于优化您的 AI 应用性能：

1. **Incremental Static Regeneration (ISR):** For AI-generated content that doesn't need real-time updates, ISR can be an excellent choice. It works with the Data Cache, a specialized cache on Vercel's global edge network for storing responses from data fetches that supports time-based, on-demand, and tag-based revalidation.

1. **增量静态再生（ISR）：** 对于无需实时更新的 AI 生成内容，ISR 是一个极佳的选择。它与“数据缓存（Data Cache）”协同工作——这是部署在 Vercel 全球边缘网络上的一种专用缓存，用于存储数据请求的响应，并支持基于时间、按需及基于标签的重新验证机制。

[Strategic use of ISR](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app-2KbhO1vDa3M5k4aX02Y0v9) reduces the load on your AI and backend services.

[ISR 的策略性使用](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app-2KbhO1vDa3M5k4aX02Y0v9) 可减轻您的 AI 模型及后端服务的负载。

2. **Redis / Vercel KV:** Use [Vercel KV](https://vercel.com/docs/storage/vercel-kv), a fully managed Redis database, for storing and retrieving JSON data. It's ideal for caching AI responses, managing application state, and storing frequently accessed data. You can also integrate a self-managed Redis instance for more customized caching needs.

2. **Redis / Vercel KV：** 使用 [Vercel KV](https://vercel.com/docs/storage/vercel-kv) —— 一种完全托管的 Redis 数据库 —— 来存储和检索 JSON 数据。它非常适合缓存 AI 响应、管理应用状态以及保存高频访问的数据。您也可集成自托管的 Redis 实例，以满足更定制化的缓存需求。

3. **Blob Storage / Amazon S3:** While not strictly a caching solution, blob storage is useful for AI applications that store and serve large files generated or processed by AI models.

3. **对象存储（Blob Storage）/ Amazon S3：** 尽管严格意义上并非缓存方案，但对象存储对需要存储和分发由 AI 模型生成或处理的大文件的 AI 应用非常有用。

[Vercel Blob (Beta)](https://vercel.com/docs/storage/vercel-blob) is a managed blob storage configurable directly from the Vercel dashboard.

[Vercel Blob（测试版）](https://vercel.com/docs/storage/vercel-blob) 是一种托管式对象存储服务，可直接通过 Vercel 控制台进行配置。

Here's an example of implementing caching for an AI response using Vercel KV and Next.js:

以下是一个使用 Vercel KV 和 Next.js 为 AI 响应实现缓存的示例：

app/cached-ai/route.ts

```tsx
import { openai } from "@ai-sdk/openai";

import { convertToCoreMessages, formatStreamPart, streamText } from "ai";
```

```typescript
import kv from "@vercel/kv";

import kv from "@vercel/kv";

// Allow streaming responses up to 30 seconds

// 允许流式响应最长持续 30 秒

export const maxDuration = 30;

export const maxDuration = 30;

// simple cache implementation, use Vercel KV or a similar service for production

// 简单的缓存实现；生产环境请使用 Vercel KV 或类似服务

const cache = new Map<string, string>();

const cache = new Map<string, string>();

export async function POST(req: Request) {

export async function POST(req: Request) {

  const { messages } = await req.json();

  const { messages } = await req.json();
```

14  // come up with a key based on the request:

14  // 根据请求生成一个键：

15  const key = JSON.stringify(messages);

15  const key = JSON.stringify(messages);

17  // Check if we have a cached response

17  // 检查是否存在缓存的响应

18  const cached = await kv.get(key);

18  const cached = await kv.get(key);

19  if (cached != null) {

19  if (cached != null) {

20    return new Response(formatStreamPart("text", cached), {

20    return new Response(formatStreamPart("text", cached), {

21      status: 200,

21      status: 200,

22      headers: { "Content-Type": "text/plain" },

22      headers: { "Content-Type": "text/plain" },

23    });

23    });

24  }

24  }

26  // Call the language model:

26  // 调用语言模型：

27  const result = await streamText({

27  const result = await streamText({

28    model: openai("gpt-4o"),

28    model: openai("gpt-4o"),

29    messages: convertToCoreMessages(messages),

29    messages: convertToCoreMessages(messages),

30    async onFinish({ text }) {

30    async onFinish({ text }) {

31      // Cache the response text:

31      // 缓存响应文本：

32      await kv.set(key, text);

32      await kv.set(key, text);

33      await kv.expire(key, 60 * 60);

33      await kv.expire(key, 60 * 60);

34    },

34    },

35  });

35  });



37  // Respond with the stream

37  // 以流形式响应

38  return result.toDataStreamResponse();

38  return result.toDataStreamResponse();

39}

39}


## What will your AI journey look like?

## 你的 AI 之旅将如何展开？

As AI reshapes technology, architects must look to robust infrastructure to harness its power without giving up security, compliance, and user trust.

随着 AI 重塑技术格局，架构师必须依托稳健的基础设施，在充分释放 AI 强大能力的同时，不牺牲安全性、合规性与用户信任。

Vercel's platform offers AI-native tooling that simplifies deployment and addresses critical concerns. With its global edge network, serverless infrastructure, and built-in security features, Vercel provides a foundation for innovative, scalable, and trustworthy AI applications.

Vercel 平台提供面向 AI 原生的工具链，简化部署流程，并应对关键挑战。凭借其全球边缘网络、无服务器基础设施以及内置安全特性，Vercel 为构建创新、可扩展且值得信赖的 AI 应用提供了坚实基础。

You can create AI solutions that drive business value while maintaining trust, and position your organization at the forefront of the AI revolution.

您可构建既能驱动商业价值、又能维系信任的 AI 解决方案，从而让您所在组织立于 AI 革命的最前沿。

[**欢迎随时提出您的问题。**  
\\  
我们的 AI 工程师可为您解答有关迁移或复杂基础设施的问题，并针对大规模 AI 应用推荐最佳实践。  
\\  
联系我们](https://vercel.com/contact/sales)
{% endraw %}
