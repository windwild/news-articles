---
render_with_liquid: false
title: "Improving Memory Retrieval: How New Computer achieved 50% higher recall with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-new-computer/"
date: "2024-07-17"
scraped_at: "2026-03-03T07:58:59.953067963+00:00"
language: "en-zh"
translated: true
description: "New Computer used LangSmith to improve their memory retrieval system, achieving 50% higher recall by tracking regressions in comparison view and adjusting conversation prompts accordingly."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

## **About New Computer**

## **关于 New Computer 公司**

[New Computer](http://new.computer/?ref=blog.langchain.com) is the team behind [Dot](https://apps.apple.com/us/app/dot-living-history/id6450016041?ref=blog.langchain.com), the first personal AI designed to truly understand its users. Dot’s long-term memory system learns users preferences over time by observing verbal and behavioral cues. Dot’s memory system goes beyond just recall— it constantly evolves its picture of who the user is in order to provide timely and personalized assistance, creating a perception of true understanding.

[New Computer](http://new.computer/?ref=blog.langchain.com) 是 [Dot](https://apps.apple.com/us/app/dot-living-history/id6450016041?ref=blog.langchain.com) 的研发团队——Dot 是全球首款真正致力于理解用户的个人 AI。Dot 的长期记忆系统通过持续观察用户的语言表达与行为线索，随时间推移逐步学习并适应用户偏好。Dot 的记忆系统不仅支持简单的内容回溯，更会动态更新对用户身份的认知画像，从而提供及时、个性化的协助，营造出“真正理解用户”的体验。

With LangSmith, New Computer has been able to test and improve their memory retrieval systems, leading to **50% higher recall** and **40% higher precision** compared to a previous baseline implementation of dynamic memory retrieval.

借助 LangSmith，New Computer 成功测试并优化了其记忆检索系统，相较此前基于动态记忆检索的基线实现，**召回率提升 50%，准确率提升 40%**。

## **A brief overview of Dot’s agentic memory**

## **Dot 的“智能体式记忆”简要概述**

The New Computer team has built an innovative, first-of-its-kind agentic memory system. Unlike standard RAG methods that rely on a static set of documents, agentic memory involves dynamically creating or pre-calculating documents that will only be retrieved later. This means that information must be structured during memory creation in order to make retrieval possible and, as memories accumulate over time, accurate & efficient.

New Computer 团队构建了一套开创性的、业界首创的“智能体式记忆”（agentic memory）系统。与依赖静态文档集的标准 RAG 方法不同，“智能体式记忆”强调在记忆生成阶段即动态创建或预计算文档，这些文档仅在后续检索时才被调用。这意味着：信息必须在记忆创建之初就被结构化，以确保未来可检索；而随着记忆持续积累，该结构还需保障检索的准确性与高效性。

In addition to the raw content, Dot’s memories have a set of optional “meta-fields” that are useful for retrieval. These include status (e.g. COMPLETED or IN PROGRESS) and datetime fields like start or due date. These can be used as additional filter methods for high-frequency queries during retrieval, such as “Which tasks did I want to get done this week?”, or “What do I have left to complete for today?”

除原始内容外，Dot 的每条记忆还包含一组可选的“元字段”（meta-fields），用于增强检索能力。例如状态字段（如 COMPLETED 或 IN PROGRESS）、时间字段（如开始时间或截止日期）。这些元字段可作为高频查询场景下的附加过滤条件，例如：“我这周打算完成哪些任务？”或“今天我还剩哪些事项待办？”

## **Improving memory retrieval with LangSmith**

## **借助 LangSmith 提升记忆检索效果**

With their diverse range of retrieval methods— one or multiple of semantic, keyword, BM25, meta-field filter techniques — New Computer needed a new way to iterate quickly on a dataset of labeled examples. To test performance while preserving user privacy, they generated synthetic data by creating a cohort of synthetic users with LLM-generated backstories. After an initial conversation to seed the memory database for each synthetic user, the team began storing queries (messages by synthetic users) along with the full set of available memories in a LangSmith dataset.

New Computer 拥有多样化的检索方法组合——包括语义检索、关键词检索、BM25 检索、元字段过滤等，其中一项或多项可协同使用。为快速在标注数据集上迭代优化，他们亟需一种新范式。为兼顾性能评估与用户隐私保护，团队利用大语言模型（LLM）生成背景故事，构建了一批模拟用户（synthetic users）；随后，通过初始对话为每位模拟用户“播种”记忆数据库；在此基础上，团队将模拟用户的全部查询（即对话消息）及其对应时刻的完整可用记忆集合，统一存入 LangSmith 数据集。

Using an in-house tool connected to LangSmith, the New Computer team labeled relevant memories for each query and defined evaluation metrics like precision, recall and F1, allowing them to quickly iterate on improving retrieval for the agentic memory system.

团队开发了一款内部工具，并将其与 LangSmith 对接：针对每个查询，人工标注出相关记忆，并定义精度（precision）、召回率（recall）和 F1 值等评估指标，从而快速迭代优化“智能体式记忆”系统的检索能力。

For this set of experiments, they started out with a simple baseline system using semantic search that retrieves a fixed number of the most relevant memories per query. They then tested other techniques to assess performance across different query types. In some cases, similarity search or keyword methods like BM25 worked better; in others, these methods required some pre-filtering by meta-fields in order to perform effectively.

在本次系列实验中，团队首先采用一个简单的基线系统：基于语义搜索，每次查询固定返回最相关的若干条记忆。随后，他们尝试多种其他技术，以全面评估不同查询类型下的系统表现。结果发现：在某些场景下，相似度搜索或 BM25 等关键词方法效果更优；而在另一些场景中，这些方法则需先借助元字段进行预过滤，方能发挥最佳效能。

As you might imagine, running these multiple methods in parallel can lead to a combinatorial explosion of experiments— thus, validating different methods quickly on a diverse dataset is crucial for making progress. LangSmith’s easy-to-use SDK and Experiments UI enabled New Computer to run, evaluate, and inspect the results of these experiments quickly and efficiently.

正如你所想象的，同时运行多种方法可能导致实验数量呈组合式爆炸增长——因此，在多样化数据集上快速验证不同方法，对推进研发进展至关重要。LangSmith 易用的 SDK 和实验（Experiments）UI 使 New Computer 能够快速、高效地运行、评估并检查这些实验的结果。

![](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_001.jpg)An overview of F1 performance across different experiments that New Computer ran in LangSmith

![](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_001.jpg)New Computer 在 LangSmith 中开展的各类实验的 F1 性能概览

These experiments enabled New Computer to significantly improve their memory systems, leading to **50% higher recall** and **40% higher precision** compared to a previous baseline implementation of dynamic memory retrieval.

这些实验助力 New Computer 显著优化了其记忆系统，相较于此前动态记忆检索的基线实现，**召回率提升了 50%**，**准确率提升了 40%**。

## **Adjusting the conversation prompt with LangSmith**

## **借助 LangSmith 调整对话提示词（conversation prompt）**

Dot’s responses are generated by a dynamic conversational prompt— which means that in addition to including relevant memories, the system might also rely upon tool usage (e.g. search results) and highly-contextual behavioral instructions in order to respond in an accurate and natural way.

Dot 的响应由一个动态对话提示词生成——这意味着，除纳入相关记忆外，系统还可能依赖工具调用（例如搜索结果）以及高度上下文化的行为空指令，从而实现准确、自然的响应。

Developing a highly variable system like this can be challenging, as a change that improves one query can have detrimental effects on others.

开发此类高度可变的系统颇具挑战性：某项改进某个查询效果的变更，可能对其他查询产生负面影响。

To optimize the prompt, the New Computer team again used a cohort of synthetic users to generate user queries for a wide range of intents. They were then able to easily inspect the global effects of prompt changes in LangSmith’s experiment [comparison view](https://docs.smith.langchain.com/how_to_guides/evaluation/compare_experiment_results?ref=blog.langchain.com). This let them identify regressed runs derived from prompt changes in a highly-visual manner.

为优化提示词，New Computer 团队再次采用一批合成用户，针对广泛多样的用户意图生成查询。随后，他们即可在 LangSmith 实验的[对比视图（comparison view）](https://docs.smith.langchain.com/how_to_guides/evaluation/compare_experiment_results?ref=blog.langchain.com)中直观、便捷地审视提示词变更带来的全局影响。这使得团队能够以高度可视化的方式识别出因提示词调整而性能退化的运行实例。

In addition, in failure cases where the output was inaccurate, the team could directly adjust prompts without leaving the LangSmith UI using the built-in prompt playground. This greatly improved the team’s iteration speed while evaluating and adjusting their conversation prompts.

此外，在输出不准确的失败案例中，团队可直接在 LangSmith UI 内，利用内置的提示词 Playground（提示词沙盒）即时调整提示词，无需切换界面。此举极大提升了团队在评估与调优对话提示词过程中的迭代速度。

![](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_002.jpg)

![](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_002.jpg)

## **What’s next for New Computer**

## **New Computer 的下一步计划**

As New Computer pushes to deepen human-AI relationships, the team is constantly seeking ways to make users feel truly perceived and understood.  
随着 New Computer 致力于深化人与 AI 之间的关系，其团队持续探索各种方式，让用户真切感受到被看见、被理解。

This includes enabling Dot to adapt to conversational or tonal preferences of the user, or becoming fully bespoke on a per-user basis by proactively reaching out to users with tailored messages.  
这包括让 Dot 能够适应用户的对话风格或语气偏好；更进一步，还可为每位用户量身定制体验——主动向用户推送高度个性化的内容与消息。

Their recent launch has brought in a new wave of users— more than 45% of which converted to the app’s paid tier after hitting the free message limit— who expect Dot to grow and evolve alongside them over time.  
其最近一次产品发布吸引了一批新用户——其中超过 45% 的用户在用完免费消息额度后，升级为付费订阅用户。这些用户期待 Dot 能随自身成长而持续演进、共同成长。

New Computer’s partnership with the LangChain team and use of LangSmith will remain pivotal to how the team uses novel AI materials to simulate the complexities of a deepening relationship with human users.  
New Computer 与 LangChain 团队的合作，以及对 LangSmith 的应用，将持续成为该团队利用前沿 AI 技术模拟人机关系日益深化之复杂性的关键支撑。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)  
[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read  
[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)  
[**Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith 构建 AI 智能体，重塑客户体验](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith 构建 AI 智能体，重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/improving-memory-retrieval-how-new-computer-achieved-50-higher-recall-with-langs/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟