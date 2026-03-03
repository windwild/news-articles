---
title: "The Prompt Landscape"
source: "LangChain Blog"
url: "https://blog.langchain.com/the-prompt-landscape/"
date: "2024-03-14"
scraped_at: "2026-03-03T08:07:11.693965905+00:00"
language: "en-zh"
translated: true
tags: ["![Extraction Benchmarking", "**Extraction Benchmarking**", "![Building Chat LangChain", "**Building Chat LangChain**"]
---

### Context

Prompt Engineering can steer LLM behavior without updating the model weights. A variety of prompts for different uses-cases have emerged (e.g., see [@dair_ai](https://twitter.com/dair_ai?ref=blog.langchain.com)’s [prompt engineering guide](https://www.promptingguide.ai/techniques?ref=blog.langchain.com) and [this excellent review](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/?ref=blog.langchain.com) from Lilian Weng). As the [number of LLMs](https://www.promptingguide.ai/models/collection?ref=blog.langchain.com) and different use-cases expand, there is [increasing need](https://twitter.com/omarsar0/status/1702327692363018361?s=20&ref=blog.langchain.com) for prompt management to support discoverability, sharing, workshopping, and debugging prompts. We launched [the LangChain Hub](https://smith.langchain.com/hub?ref=blog.langchain.com) over a month ago to support these needs, serving as a home for both browsing community prompts and managing your own. Below we provide an overview of the major themes in prompting that we’ve seen since launch and highlight interesting examples.

### 上下文（Context）

提示工程（Prompt Engineering）无需更新大语言模型（LLM）的权重，即可引导其行为。针对不同应用场景，已涌现出大量提示模板（例如，参见 [@dair_ai](https://twitter.com/dair_ai?ref=blog.langchain.com) 的 [提示工程指南](https://www.promptingguide.ai/techniques?ref=blog.langchain.com)，以及 Lilian Weng 撰写的 [这篇优秀综述](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering/?ref=blog.langchain.com)）。随着 [大语言模型数量](https://www.promptingguide.ai/models/collection?ref=blog.langchain.com) 和应用场景持续扩展，对提示管理（prompt management）的需求也日益增长——以支持提示的可发现性、共享、协作优化（workshopping）与调试。一个月前，我们正式推出了 [LangChain Hub](https://smith.langchain.com/hub?ref=blog.langchain.com)，旨在满足上述需求，为用户浏览社区共享提示及管理自有提示提供统一平台。下文将概述自发布以来我们在提示设计中观察到的主要范式，并重点介绍若干典型示例。

![](images/the-prompt-landscape/img_001.png)Some popular prompt categories in LangChain hub

![](images/the-prompt-landscape/img_001.png)LangChain Hub 中一些热门的提示类别

### Reasoning

[Chain-of-thought](https://arxiv.org/abs/2201.11903?ref=blog.langchain.com) reasoning encourages the LLM to spread its “thinking” out across many tokens: it conditions the LLM to show its work using a simple statement e.g., `Let's think step by step`. This has found broad appeal because it [improves](https://twitter.com/_jasonwei/status/1712551642275655770?s=20&ref=blog.langchain.com) many reasoning tasks by a large margin and is easy to implement. More sophisticated approaches (e.g., [Tree-of-thought](https://arxiv.org/abs/2305.10601?ref=blog.langchain.com)) are also worth consideration, but the [benefit relative to the overhead](https://twitter.com/_jasonwei/status/1712551642275655770?s=20&ref=blog.langchain.com) (tokens) should be evaluated.

Deepmind recently used LLMs to optimize prompts, and converged to `Take a deep breath and work on this problem step-by-step` as the [best](https://twitter.com/ItakGol/status/1702306238141223100?s=20&ref=blog.langchain.com) performing optimization. Going forward, this points to some interesting potential for [translation modules](https://x.com/abacaj/status/1708847673732710718?s=20&ref=blog.langchain.com) between human instruction and LLM-optimized prompts.

![](images/the-prompt-landscape/img_002.png)Test accuracies from various prompt instructions (from [here](https://arxiv.org/pdf/2309.03409.pdf?ref=blog.langchain.com))

[Reasoning prompts](https://x.com/cwolferesearch/status/1657122778984660993?s=20&ref=blog.langchain.com) as shown above can be appended as simple instructions to many tasks and have become particularly important for agents. For example, [ReAct agents](https://www.promptingguide.ai/techniques/react?ref=blog.langchain.com) combine tool use with reasoning in an interleaved manner. Agent prompts can encode multi-step reasoning in different ways, but often with the goal of updating action plans given observations. See Lilian Weng's [excellent post](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com) on agents for a full review of the various approaches on agent design and prompting.

### 推理（Reasoning）

[思维链（Chain-of-Thought）](https://arxiv.org/abs/2201.11903?ref=blog.langchain.com) 推理鼓励大语言模型将其“思考过程”展开为多个 token，即通过一句简单指令（如 `Let's think step by step`）引导模型显式展示推理步骤。该方法广受欢迎，因其能显著提升多种推理任务的表现，且实现极为简便；相关实证表明其效果提升幅度可观。更复杂的进阶方法（例如 [思维树（Tree-of-Thought）](https://arxiv.org/abs/2305.10601?ref=blog.langchain.com)）亦值得关注，但需审慎评估其带来的性能增益是否足以抵消额外开销（尤其是 token 消耗量）。

DeepMind 近期利用大语言模型自动优化提示，最终收敛至 `Take a deep breath and work on this problem step-by-step` 作为[效果最优](https://twitter.com/ItakGol/status/1702306238141223100?s=20&ref=blog.langchain.com)的提示模板。这一进展预示着未来在[人类指令与大语言模型优化提示之间构建翻译模块](https://x.com/abacaj/status/1708847673732710718?s=20&ref=blog.langchain.com)具有广阔潜力。

![](images/the-prompt-landscape/img_002.png)各类提示指令下的测试准确率（数据来源：[此处](https://arxiv.org/pdf/2309.03409.pdf?ref=blog.langchain.com)）

如上所示，[推理类提示（Reasoning prompts）](https://x.com/cwolferesearch/status/1657122778984660993?s=20&ref=blog.langchain.com) 可作为简洁指令直接附加于多种任务之上，在智能体（agent）场景中尤为关键。例如，[ReAct 智能体](https://www.promptingguide.ai/techniques/react?ref=blog.langchain.com) 将工具调用与推理步骤以交错方式协同执行。智能体提示可通过多种方式编码多步推理逻辑，其常见目标是依据实时观测结果动态更新行动方案。关于智能体设计与提示工程的各类方法，可参阅 Lilian Weng 的[这篇深度综述文章](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com)。

**Examples**

**示例**

- [https://smith.langchain.com/hub/hwchase17/react](https://smith.langchain.com/hub/hwchase17/react?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/shoggoth13/react-chat-agent](https://smith.langchain.com/hub/shoggoth13/react-chat-agent?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/jacob/langchain-tsdoc-research-agent](https://smith.langchain.com/hub/jacob/langchain-tsdoc-research-agent?ref=blog.langchain.com)

### Writing

### 写作

Prompts to improve writing have widespread appeal given the [impressive](https://blog.langchain.com/the-prompt-landscape/reddit.com/r/singularity/comments/151hicw/writers_are_screwed_100k_context_claude_is_a/) displays of creativity from LLMs. [@mattshumer\_](https://twitter.com/mattshumer_?ref=blog.langchain.com)’s popular GPT4 prompts provide ways to improve writing clarity or customize the style of LLM-generated text. Leveraging LLM's capacity for language translation is another good application for writing.

鉴于大语言模型（LLM）展现出的[惊人](https://blog.langchain.com/the-prompt-landscape/reddit.com/r/singularity/comments/151hicw/writers_are_screwed_100k_context_claude_is_a/)创造力，用于提升写作质量的提示词（prompts）广受欢迎。[@mattshumer\_](https://twitter.com/mattshumer_?ref=blog.langchain.com) 所提出的热门 GPT-4 提示词，可帮助提升文本表达的清晰度，或定制 LLM 生成内容的写作风格。此外，利用 LLM 的语言翻译能力，也是写作领域中一项极具价值的应用。

**Examples**

**示例**

- [https://smith.langchain.com/hub/rlm/matt-shumer-writing](https://smith.langchain.com/hub/rlm/matt-shumer-writing?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/rlm/matt-shumer-writing-style](https://smith.langchain.com/hub/rlm/matt-shumer-writing-style?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/agola11/translator](https://smith.langchain.com/hub/agola11/translator?ref=blog.langchain.com)

There's also been a proliferation of prompts for producing diverse content (e.g., onboarding emails, blog posts, Tweet threads, learning materials for [education](https://twitter.com/LangChainAI/status/1699166512781905985?s=20&ref=blog.langchain.com)).

此外，面向多样化内容生成的提示词也大量涌现（例如：入职欢迎邮件、博客文章、推文长串、面向[教育领域](https://twitter.com/LangChainAI/status/1699166512781905985?s=20&ref=blog.langchain.com)的学习资料等）。

**Examples**

**示例**

- [https://smith.langchain.com/hub/gitmaxd/onboard-email](https://smith.langchain.com/hub/gitmaxd/onboard-email?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/hardkothari/blog-generator](https://smith.langchain.com/hub/hardkothari/blog-generator?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/gregkamradt/test-question-making](https://smith.langchain.com/hub/gregkamradt/test-question-making?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/bradshimmin/favorite\_prompts](https://smith.langchain.com/hub/bradshimmin/favorite_prompts?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/hardkothari/tweet-from-text](https://smith.langchain.com/hub/hardkothari/tweet-from-text?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/julia/podcaster-tweet-thread](https://smith.langchain.com/hub/julia/podcaster-tweet-thread?ref=blog.langchain.com)

### SQL

### SQL

Because enterprise data is often captures in SQL databases, there is great interest in using LLMs as a natural language interface for SQL (see our [blog post](https://blog.langchain.com/llms-and-sql/)). [A number of papers](https://arxiv.org/pdf/2204.00498.pdf?ref=blog.langchain.com) have reported that LLMs can generate SQL given some specific information about the table, including a `CREATE TABLE` description for each table followed by three example rows in a `SELECT` statement. LangChain has numerous tools for querying SQL databases (see our [use case guide](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com) and [cookbook](https://python.langchain.com/docs/expression_language/cookbook/sql_db?ref=blog.langchain.com)).

由于企业数据通常存储于 SQL 数据库中，将大语言模型（LLM）用作 SQL 的自然语言接口正引发广泛关注（参见我们的[博客文章](https://blog.langchain.com/llms-and-sql/)）。[多篇研究论文](https://arxiv.org/pdf/2204.00498.pdf?ref=blog.langchain.com)指出，只要提供关于数据表的特定信息（例如每张表的 `CREATE TABLE` 定义，以及一条含三行示例数据的 `SELECT` 语句），LLM 即可生成相应 SQL 查询。LangChain 提供了多种用于查询 SQL 数据库的工具（详见我们的[用例指南](https://python.langchain.com/docs/use_cases/qa_structured/sql?ref=blog.langchain.com)和[实用手册](https://python.langchain.com/docs/expression_language/cookbook/sql_db?ref=blog.langchain.com)）。

**Examples**

**示例**

- [https://smith.langchain.com/hub/rlm/text-to-sql](https://smith.langchain.com/hub/rlm/text-to-sql?ref=blog.langchain.com)

- [https://smith.langchain.com/hub/rlm/text-to-sql](https://smith.langchain.com/hub/rlm/text-to-sql?ref=blog.langchain.com)

### Brainstorming

### 头脑风暴

Many people have had instructive and / or entertaining conversations with LLMs. LLMs have proven broadly useful for brainstorming: one trick is to create multiple user personas that work through an idea collectively, as shown by [@mattshumer\_](https://twitter.com/mattshumer_/status/1700590646149390418?s=20&ref=blog.langchain.com) business plan ideation prompt. The principle can be adapted broadly. As an example, [BIDARA](https://www1.grc.nasa.gov/research-and-engineering/vine/petal/?ref=blog.langchain.com) (Bio-inspired Design and Research Assistant) is a GPT-4 chatbot instructed to help scientists and engineers understand, learn from, and emulate the strategies used by living things for new designs and technologies.

许多人已与大语言模型（LLM）展开过富有启发性或趣味性的对话。LLMs 在头脑风暴方面已被证明具有广泛实用性：一种技巧是创建多个用户角色，让它们协同探讨某个创意——这一方法已在 [@mattshumer\_](https://twitter.com/mattshumer_/status/1700590646149390418?s=20&ref=blog.langchain.com) 提出的商业计划构想提示词中得到展示。该原则可被广泛适配。例如，[BIDARA](https://www1.grc.nasa.gov/research-and-engineering/vine/petal/?ref=blog.langchain.com)（仿生设计与研究助手）即是一个受指令引导的 GPT-4 聊天机器人，旨在帮助科学家和工程师理解、学习并借鉴生物体所采用的策略，从而催生新型设计与技术。

**Examples**

**示例**

- [https://smith.langchain.com/hub/hwchase17/matt-shumer-validate-business-idea](https://smith.langchain.com/hub/hwchase17/matt-shumer-validate-business-idea?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/bruffridge/bidara](https://smith.langchain.com/hub/bruffridge/bidara?ref=blog.langchain.com)

- [https://smith.langchain.com/hub/hwchase17/matt-shumer-validate-business-idea](https://smith.langchain.com/hub/hwchase17/matt-shumer-validate-business-idea?ref=blog.langchain.com)  
- [https://smith.langchain.com/hub/bruffridge/bidara](https://smith.langchain.com/hub/bruffridge/bidara?ref=blog.langchain.com)

### Extraction

### 信息抽取

LLMs can be powerful tools for extracting text in particular formats, often aided by [function calling](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com). This is a rich area with frameworks developed to support it, such as [@jxnlco](https://twitter.com/jxnlco?ref=blog.langchain.com)’s Instructor (see their [guide](https://jxnl.github.io/instructor/tips/?ref=blog.langchain.com) on prompt engineering). We've also seen prompts designed for specific extraction tasks, such as knowledge graph triple extraction (as shown by tools like [Instagraph](https://instagraph.ai/?ref=blog.langchain.com) or the [text-to-graph](https://twitter.com/RLanceMartin/status/1691880034058064365?ref=blog.langchain.com) playground).

LLMs 可作为强大的工具，用于以特定格式抽取文本内容，此过程常借助 [函数调用（function calling）](https://openai.com/blog/function-calling-and-other-api-updates?ref=blog.langchain.com) 实现。该领域成果丰硕，已涌现出诸多支持此类任务的框架，例如 [@jxnlco](https://twitter.com/jxnlco?ref=blog.langchain.com) 开发的 Instructor 框架（参见其关于提示工程的 [指南](https://jxnl.github.io/instructor/tips/?ref=blog.langchain.com)）。我们也观察到大量专为特定抽取任务设计的提示词，例如知识图谱三元组（knowledge graph triple）抽取——相关实践可见于 [Instagraph](https://instagraph.ai/?ref=blog.langchain.com) 等工具，或 [text-to-graph](https://twitter.com/RLanceMartin/status/1691880034058064365?ref=blog.langchain.com) 在线演示平台。

![](images/the-prompt-landscape/img_003.png)Knowledge graph triple visualizations from @ [yoheinakajima](https://x.com/yoheinakajima/status/1701351068817301922?s=20&ref=blog.langchain.com)

![](images/the-prompt-landscape/img_003.png)来自 @ [yoheinakajima](https://x.com/yoheinakajima/status/1701351068817301922?s=20&ref=blog.langchain.com) 的知识图谱三元组可视化示例

**Examples**

**示例**

- [https://smith.langchain.com/hub/langchain/knowledge-triple-extractor](https://smith.langchain.com/hub/langchain/knowledge-triple-extractor?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/homanp/superagent](https://smith.langchain.com/hub/homanp/superagent?ref=blog.langchain.com)

- [https://smith.langchain.com/hub/langchain/knowledge-triple-extractor](https://smith.langchain.com/hub/langchain/knowledge-triple-extractor?ref=blog.langchain.com)  
- [https://smith.langchain.com/hub/homanp/superagent](https://smith.langchain.com/hub/homanp/superagent?ref=blog.langchain.com)

### RAG

### 检索增强生成（RAG）

Retrieval augmented generation (RAG) is a popular LLM application: it passes relevant context to the LLM via prompt. RAG has particular promise [for](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev) [factual](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com) [recall](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.dev) because it marries the reasoning capability of LLMs with the content of external data sources, which is [particularly powerful](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.com) for enterprise data.

检索增强生成（RAG）是一种广受欢迎的大语言模型（LLM）应用：它通过提示词（prompt）将相关上下文传递给 LLM。RAG 在[事实性召回](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com)方面展现出独特潜力，[例如](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev)，因为它将 LLM 的推理能力与外部数据源的内容相结合——这一特性在企业级数据场景中尤为强大，[如 Glean 所述](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.com)。

![upload in progress, 0](images/the-prompt-landscape/img_004.png)RAG overview

![upload in progress, 0](images/the-prompt-landscape/img_004.png)RAG 概览

**Examples**

**示例**

- [https://smith.langchain.com/hub/rlm/rag-prompt](https://smith.langchain.com/hub/rlm/rag-prompt?ref=blog.langchain.com)

- [https://smith.langchain.com/hub/rlm/rag-prompt](https://smith.langchain.com/hub/rlm/rag-prompt?ref=blog.langchain.com)

### Instruction-tuned LLMs

### 指令微调的大语言模型（Instruction-tuned LLMs）

The landscape of open [source instruction-tuned LLMs](https://python.langchain.com/docs/guides/local_llms?ref=blog.langchain.com) has exploded over the past year. With this has come a variety of popular LLMs that each have specific prompt instructions (e.g., see instruction for [LLaMA2](https://huggingface.co/blog/llama2?ref=blog.langchain.com#how-to-prompt-llama-2) and [Mistral](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.1?ref=blog.langchain.com#instruction-format)). Popular tasks such as retrieval augmented generation ( [RAG](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)) can benefit from LLM-specific-prompts.

过去一年间，开源的[指令微调大语言模型（instruction-tuned LLMs）](https://python.langchain.com/docs/guides/local_llms?ref=blog.langchain.com)生态呈现爆发式增长。随之而来的是大量广受欢迎的 LLM，每种模型均有其特定的提示词格式要求（例如，参见 [LLaMA2](https://huggingface.co/blog/llama2?ref=blog.langchain.com#how-to-prompt-llama-2) 和 [Mistral](https://huggingface.co/mistralai/Mistral-7B-Instruct-v0.1?ref=blog.langchain.com#instruction-format) 的指令格式说明）。诸如检索增强生成（[RAG](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)）等热门任务，亦可从针对特定 LLM 优化的提示词中获益。

![](images/the-prompt-landscape/img_005.png)Landscape of open source LLMs organized by base model size and number of instructions

![](images/the-prompt-landscape/img_005.png)按基础模型规模与指令数量分类的开源 LLM 生态图谱

**Examples**

**示例**

- [https://smith.langchain.com/hub/rlm/rag-prompt-llama](https://smith.langchain.com/hub/rlm/rag-prompt-llama?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/rlm/rag-prompt-mistral](https://smith.langchain.com/hub/rlm/rag-prompt-mistral?ref=blog.langchain.com)

- [https://smith.langchain.com/hub/rlm/rag-prompt-llama](https://smith.langchain.com/hub/rlm/rag-prompt-llama?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/rlm/rag-prompt-mistral](https://smith.langchain.com/hub/rlm/rag-prompt-mistral?ref=blog.langchain.com)

### LLM Graders

### LLM 评分器

Using LLMs as graders is a powerful idea that has been broadly showcased in [OpenAI cookbooks](https://github.com/openai/openai-cookbook/blob/main/examples/evaluation/How_to_eval_abstractive_summarization.ipynb?ref=blog.langchain.com) and [open](https://twitter.com/RLanceMartin/status/1658499575626465283?ref=blog.langchain.com) [source](https://x.com/hwchase17/status/1692220493657485674?s=20&ref=blog.langchain.com) [projects](https://x.com/jerryjliu0/status/1703074710077260092?s=20&ref=blog.langchain.com): the central idea is to utilize the discrimination of an LLM to rank or grade a response relative to a ground truth answer (or for consistently relative to reference materials such as retrieved context). Much of the work on LangSmith has [focused](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com) [on](https://docs.smith.langchain.com/evaluation/quickstart?ref=blog.langchain.com) [evaluation](https://www.youtube.com/watch?app=desktop&v=ll-Xit_Khq0&ref=blog.langchain.com) support.

将 LLM 用作评分器是一个极具潜力的构想，已在 [OpenAI 食谱（cookbooks）](https://github.com/openai/openai-cookbook/blob/main/examples/evaluation/How_to_eval_abstractive_summarization.ipynb?ref=blog.langchain.com) 及多个[开源项目](https://twitter.com/RLanceMartin/status/1658499575626465283?ref=blog.langchain.com)中得到广泛展示：其核心思想是利用大语言模型的判别能力，将模型输出与标准答案（或与检索到的上下文等参考材料）进行对比，从而完成排序或评分任务。LangSmith 的大量工作已集中于[评估功能支持](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com)、[快速入门指南](https://docs.smith.langchain.com/evaluation/quickstart?ref=blog.langchain.com)以及[相关视频教程](https://www.youtube.com/watch?app=desktop&v=ll-Xit_Khq0&ref=blog.langchain.com)。

**Examples**

**示例**

- [https://smith.langchain.com/hub/simonp/model-evaluator](https://smith.langchain.com/hub/simonp/model-evaluator?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/wfh/automated-feedback-example](https://smith.langchain.com/hub/wfh/automated-feedback-example?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/smithing-gold/assumption-checker](https://smith.langchain.com/hub/smithing-gold/assumption-checker?ref=blog.langchain.com)

### Synthetic Data generation

### 合成数据生成

[Fine-tuning](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/) LLMs is one of the primary ways (along with RAG) to steer LLM behavior. Yet, gathering training data for fine-tuning is a challenge. [Considerable](https://x.com/johnjnay/status/1649792913109397508?s=20&ref=blog.langchain.com) [work](https://www.evals.anthropic.com/model-written/?ref=blog.langchain.com) [has focused](https://x.com/cwolferesearch/status/1616896609517817857?s=20&ref=blog.langchain.com) on using LLMs to generate synthetic datasets.

对大语言模型进行[微调（fine-tuning）](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/)，是引导模型行为的主要方法之一（另一主要方法为 RAG）。然而，为微调收集高质量训练数据仍是一大挑战。已有大量研究工作——包括[多项开源探索](https://x.com/johnjnay/status/1649792913109397508?s=20&ref=blog.langchain.com)、[Anthropic 的评估框架](https://www.evals.anthropic.com/model-written/?ref=blog.langchain.com)及[其他前沿实践](https://x.com/cwolferesearch/status/1616896609517817857?s=20&ref=blog.langchain.com)——聚焦于利用大语言模型自动生成合成数据集。

**Examples**

**示例**

- [https://smith.langchain.com/hub/homanp/question-answer-pair](https://smith.langchain.com/hub/homanp/question-answer-pair?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/gitmaxd/synthetic-training-data](https://smith.langchain.com/hub/gitmaxd/synthetic-training-data?ref=blog.langchain.com)

### Prompt Optimization

### 提示词优化

The [Deepmind](https://arxiv.org/pdf/2309.03409.pdf?ref=blog.langchain.com) work showing that LLMs can optimize prompts offers the broad potential for [translation modules](https://x.com/abacaj/status/1708847673732710718?s=20&ref=blog.langchain.com) between human instruction and LLM-optimized prompts. We’ve seen a number of interesting prompts along these lines; one good example is for [Midjourney](https://www.midjourney.com/home/?callbackUrl=%2Fapp%2F&ref=blog.langchain.com), which has incredible creative potential to unlock through prompting and parameter flags. For a general input idea (`Freddie Mercury performing at the 2023 San Francisco Pride Parade hyper realistic`), it can produce a series of N prompts that embellish the idea, as shown below:

DeepMind 发表的[相关研究](https://arxiv.org/pdf/2309.03409.pdf?ref=blog.langchain.com)表明，大语言模型本身可被用于提示词优化，这为构建“人类指令 ↔ LLM 优化提示词”的[翻译模块](https://x.com/abacaj/status/1708847673732710718?s=20&ref=blog.langchain.com)提供了广阔前景。我们已观察到不少此类有趣实践；其中一例即面向 [Midjourney](https://www.midjourney.com/home/?callbackUrl=%2Fapp%2F&ref=blog.langchain.com) 的提示工程——通过精心设计的提示词与参数标志（parameter flags），可充分释放其惊人的创意生成潜力。例如，针对一个通用输入概念（`Freddie Mercury performing at the 2023 San Francisco Pride Parade hyper realistic`），系统可生成一系列 N 个对该概念进行丰富与拓展的提示词，如下所示：

> Freddie Mercury electrifying the San Francisco Pride Parade stage, shining in a gleaming golden outfit, iconic microphone stand in hand, evoking the hyper-realistic style of Caravaggio, vivid and dynamic --ar 16:9 --q 2)

> 弗雷迪·默丘里（Freddie Mercury）在旧金山骄傲游行舞台上激情献演，身着熠熠生辉的金色服装，手握标志性麦克风支架，整体风格致敬卡拉瓦乔（Caravaggio）式的超写实主义，画面鲜明而富有动感 ——ar 16:9 ——q 2）

![](images/the-prompt-landscape/img_006.png)Midjourney generation from the above prompt

![](images/the-prompt-landscape/img_006.png)以上提示词在 Midjourney 中生成的效果图

**Examples**

**示例**

- [https://smith.langchain.com/hub/hardkothari/prompt-maker](https://smith.langchain.com/hub/hardkothari/prompt-maker?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/aemonk/midjourney\_prompt\_generator](https://smith.langchain.com/hub/aemonk/midjourney_prompt_generator?ref=blog.langchain.com)

### Code Understanding and Generation

### 代码理解与生成

Code analysis is one of the most popular LLM use-cases, as demonstrated by the popularity of [GitHub co-pilot](https://github.com/features/copilot?ref=blog.langchain.com) and [Code Interpreter](https://www.pluralsight.com/resources/blog/data/chatgpt-code-interpreter-plugin-guide?ref=blog.langchain.com) as well as fine-tuned LLMs ( [Code LLaMA](https://ai.meta.com/blog/code-llama-large-language-model-coding/?ref=blog.langchain.com)). We've seen a number of prompts related to this theme:

代码分析是大语言模型（LLM）最热门的应用场景之一，这一点从 [GitHub Copilot](https://github.com/features/copilot?ref=blog.langchain.com) 和 [Code Interpreter](https://www.pluralsight.com/resources/blog/data/chatgpt-code-interpreter-plugin-guide?ref=blog.langchain.com) 的广泛采用，以及专为编程优化的微调模型（如 [Code LLaMA](https://ai.meta.com/blog/code-llama-large-language-model-coding/?ref=blog.langchain.com)）中可见一斑。我们已观察到大量围绕该主题设计的提示词：

**Examples**

**示例**

- [https://smith.langchain.com/hub/chuxij/open-interpreter-system](https://smith.langchain.com/hub/chuxij/open-interpreter-system?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/homanp/github-code-reviews](https://smith.langchain.com/hub/homanp/github-code-reviews?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/muhsinbashir/text-to-streamlit-webap](https://smith.langchain.com/hub/muhsinbashir/text-to-streamlit-webap?ref=blog.langchain.com)

### Summarization

### 文本摘要

[Summarization of content](https://blog.langchain.com/llms-to-improve-documentation/) is a powerful LLM use-case. Longer context LLMs, such as [Anthropic Claude2](https://www.anthropic.com/index/claude-2?ref=blog.langchain.com), can absorb > 70 pages for direct summarization. [Prompting techniques](https://twitter.com/vimota/status/1702503466994982914?ref=blog.langchain.com) like [chain of density](https://browse.arxiv.org/pdf/2309.04269.pdf?ref=blog.langchain.com) offer a complimentary approach, resulting in dense yet human-preferable summaries.

[内容摘要](https://blog.langchain.com/llms-to-improve-documentation/) 是大语言模型一项极为强大的应用能力。具备长上下文处理能力的模型（如 [Anthropic Claude 2](https://www.anthropic.com/index/claude-2?ref=blog.langchain.com)）可直接对超过 70 页的文本进行摘要。此外，[提示工程技巧](https://twitter.com/vimota/status/1702503466994982914?ref=blog.langchain.com)（例如 [密度链（Chain of Density）](https://browse.arxiv.org/pdf/2309.04269.pdf?ref=blog.langchain.com)）提供了有力的补充方法，能生成信息高度浓缩、同时更符合人类阅读偏好的摘要。

**Examples**

**示例**

- [https://smith.langchain.com/hub/lawwu/chain_of_density](https://smith.langchain.com/hub/lawwu/chain_of_density?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/hwchase17/anthropic-paper-qa](https://smith.langchain.com/hub/hwchase17/anthropic-paper-qa?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/muhsinbashir/youtube-transcript-to-article](https://smith.langchain.com/hub/muhsinbashir/youtube-transcript-to-article?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/hwchase17/anthropic-chain-of-density](https://smith.langchain.com/hub/hwchase17/anthropic-chain-of-density?ref=blog.langchain.com)

In addition, summarization can be applied to diverse content types like chat conversations (e.g., [compress the content](https://python.langchain.com/docs/modules/data_connection/retrievers/contextual_compression/?ref=blog.langchain.com) to pass as context into chat LLM memory) or domain specific data (financial table summarization)

此外，摘要技术可应用于多种类型的内容，例如聊天对话（如[压缩内容](https://python.langchain.com/docs/modules/data_connection/retrievers/contextual_compression/?ref=blog.langchain.com)，以便将其作为上下文传入聊天式大语言模型的内存中），或特定领域的数据（如财务表格摘要）。

**Examples**

**示例**

- [https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.com)
- [https://smith.langchain.com/hub/hwchase17/financial-table-insights](https://smith.langchain.com/hub/hwchase17/financial-table-insights?ref=blog.langchain.com)

### Conclusion

### 结论

You can easily test any of these prompts for yourself using "Try It" button:

您只需点击“Try It”（立即尝试）按钮，即可轻松自行测试上述任一提示词：

![](images/the-prompt-landscape/img_007.png)

This will open a playground for workshopping and debugging prompts with a broad set of different LLMs, many of which are free to use:

这将打开一个交互式实验平台，支持您针对大量不同大语言模型（其中许多可免费使用）对提示词进行打磨与调试：

![](images/the-prompt-landscape/img_008.png)

### Tags

### 标签

[![Extraction Benchmarking](images/the-prompt-landscape/img_009.jpg)](https://blog.langchain.com/extraction-benchmarking/)

[![抽取基准测试](images/the-prompt-landscape/img_009.jpg)](https://blog.langchain.com/extraction-benchmarking/)

[**Extraction Benchmarking**](https://blog.langchain.com/extraction-benchmarking/)

[**抽取基准测试**](https://blog.langchain.com/extraction-benchmarking/)

[![Applying OpenAI's RAG Strategies](images/the-prompt-landscape/img_010.png)](https://blog.langchain.com/applying-openai-rag/)

[![应用 OpenAI 的 RAG 策略](images/the-prompt-landscape/img_010.png)](https://blog.langchain.com/applying-openai-rag/)

[**Applying OpenAI's RAG Strategies**](https://blog.langchain.com/applying-openai-rag/)

[**应用 OpenAI 的 RAG 策略**](https://blog.langchain.com/applying-openai-rag/)

[![LangServe Playground and Configurability](images/the-prompt-landscape/img_011.png)](https://blog.langchain.com/langserve-playground-and-configurability/)

[![LangServe 交互式 Playground 与可配置性](images/the-prompt-landscape/img_011.png)](https://blog.langchain.com/langserve-playground-and-configurability/)

[**LangServe Playground and Configurability**](https://blog.langchain.com/langserve-playground-and-configurability/)

[**LangServe 交互式 Playground 与可配置性**](https://blog.langchain.com/langserve-playground-and-configurability/)

[![A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG](images/the-prompt-landscape/img_012.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[![换一个名字还叫“块”？——结构化文本切分与元数据增强的 RAG](images/the-prompt-landscape/img_012.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**换一个名字还叫“块”？——结构化文本切分与元数据增强的 RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)

[![Building Chat LangChain](images/the-prompt-landscape/img_013.png)](https://blog.langchain.com/building-chat-langchain-2/)

[**构建 Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)