---
render_with_liquid: false
title: "Auto-Evaluator Opportunities"
source: "LangChain Blog"
url: "https://blog.langchain.com/auto-evaluator-opportunities/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:01:23.240602926+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: this is a guest blog post by [Lance Martin](https://twitter.com/RLanceMartin?s=20&ref=blog.langchain.com).**

**编者按：本文为特邀博主 [Lance Martin](https://twitter.com/RLanceMartin?s=20&ref=blog.langchain.com) 撰写的客座博客文章。**

### **TL;DR**

We recently open-sourced an [auto-evaluator](https://blog.langchain.com/auto-eval-of-question-answering-tasks/) tool for grading LLM question-answer chains. We are now releasing an [open source](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com), free to use [hosted app](https://autoevaluator.langchain.com/?ref=blog.langchain.com) and [API](https://github.com/langchain-ai/auto-evaluator/tree/main/api?ref=blog.langchain.com) to expand usability. Below we discuss a few opportunities to further improve this.

### **简明摘要（TL;DR）**

我们近期开源了一款用于评估大语言模型（LLM）问答链（question-answer chains）质量的 [自动评估工具（auto-evaluator）](https://blog.langchain.com/auto-eval-of-question-answering-tasks/)。如今，我们进一步推出一款 [开源](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)、免费使用的 [托管应用（hosted app）](https://autoevaluator.langchain.com/?ref=blog.langchain.com) 和 [API](https://github.com/langchain-ai/auto-evaluator/tree/main/api?ref=blog.langchain.com)，以提升其可用性。下文我们将探讨若干可进一步优化该工具的方向。

### **Context**

Document [Question-Answering](https://python.langchain.com/docs/use_cases/question_answering?ref=blog.langchain.com) is a popular LLM use-case. LangChain makes it easy to assemble LLM components (e.g., models and retrievers) into chains that support question-answering: input documents are split into chunks and stored in a retriever, relevant chunks are retrieved given a user `question` and passed to an LLM for synthesis into an `answer`.

### **背景**

文档[问答（Question-Answering）](https://python.langchain.com/docs/use_cases/question_answering?ref=blog.langchain.com) 是大语言模型（LLM）一项广受欢迎的应用场景。LangChain 使用户能够轻松将各类 LLM 组件（例如模型与检索器）组装成支持问答任务的链式流程：输入文档被切分为文本块（chunks），并存入检索器；当用户提供一个 `question`（问题）时，系统从检索器中召回相关文本块，并将其送入大语言模型进行综合处理，最终生成一个 `answer`（答案）。

### Problem

The quality of QA systems can vary considerably; [we have seen](https://www.notion.so/Lex-GPT-a3ad671766d34f4a9a078da7adf9d382?ref=blog.langchain.com) cases of hallucination and poor answer quality due specific parameter settings. But, it is not always obvious to (1) evaluate the answer quality and (2) use this evaluation to guide improved QA chain settings (e.g., chunk size, retrieved docs count) or components (e.g., model or retriever choice).

### **问题**

问答（QA）系统的质量可能差异显著；我们已观察到[若干案例](https://www.notion.so/Lex-GPT-a3ad671766d34f4a9a078da7adf9d382?ref=blog.langchain.com)，因特定参数配置不当而导致模型“幻觉”（hallucination）或答案质量低下。然而，以下两点往往并不明确：（1）如何客观评估答案质量；（2）如何利用该评估结果指导优化问答链的配置（例如分块大小、召回文档数量）或组件选择（例如模型或检索器类型）。

### **App**

The `auto-evaluator` aims to address these limitations. It is inspired by work in two areas: 1) recent [work](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2212.xml?ref=blog.langchain.com) from Anthropic has used model-written evaluation sets and 2) OpenAI [has shown](https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml?ref=blog.langchain.com)  model-graded evaluation. This app combines both of these ideas into a single workspace, auto-generating a QA test set for a given input doc and auto-grading the result of the user-specified QA chain. Langchain’s abstraction make it easy to configure QA with modular components for testing (show in colors below).

### **应用**

`auto-evaluator`（自动评估器）旨在解决上述局限性。其设计灵感源自两个方向的研究进展：（1）Anthropic 近期[相关工作](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2212.xml?ref=blog.langchain.com)采用由大语言模型自动生成的评测数据集；（2）OpenAI [已证实](https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml?ref=blog.langchain.com)基于大语言模型的分级评估（model-graded evaluation）的有效性。本应用将二者融合于统一工作空间中：针对用户提供的输入文档，自动构建问答测试集；并针对用户指定的问答链，自动对其输出结果进行评分。LangChain 的抽象化设计使得用户能便捷地通过模块化组件配置问答流程，以支持各类测试（如下图中以不同颜色标示）。

![](https://blog.langchain.com/content/images/2023/05/autoeval.png)

### **Usage**

### **使用方法**

We are now releasing an [open source](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com), free to use [hosted app](https://autoevaluator.langchain.com/?ref=blog.langchain.com) and [API](https://github.com/langchain-ai/auto-evaluator/tree/main/api?ref=blog.langchain.com) to expand usability. The app can be used in two ways (see the [README](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com) for more details):

我们现已发布一个[开源](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)、可免费使用的[托管应用](https://autoevaluator.langchain.com/?ref=blog.langchain.com)和[API](https://github.com/langchain-ai/auto-evaluator/tree/main/api?ref=blog.langchain.com)，以提升可用性。该应用支持两种使用方式（更多详情请参阅[README](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)）：

- `Demo`: We pre-loaded a document (a [transcript](https://youtu.be/OYsYgzzsdT0?ref=blog.langchain.com) of the Lex Fridman podcast with Andrej Karpathy) and a set of 5 [question-answer pairs](https://github.com/langchain-ai/auto-evaluator/blob/main/api/docs/karpathy-lex-pod/karpathy-pod-eval.csv?ref=blog.langchain.com) from the podcast. You can configure QA chain(s) and run experiments to evaluate the relative performance.

- `演示模式（Demo）`：我们已预加载一份文档（即 Andrej Karpathy 与 Lex Fridman 的播客[文字稿](https://youtu.be/OYsYgzzsdT0?ref=blog.langchain.com)），以及该播客中提取的 5 组[问答对](https://github.com/langchain-ai/auto-evaluator/blob/main/api/docs/karpathy-lex-pod/karpathy-pod-eval.csv?ref=blog.langchain.com)。您可配置问答链（QA chain），并运行实验以评估不同方案的相对性能。

- `Playground`: Inspired by the [nat.dev](https://blog.langchain.com/auto-evaluator-opportunities/nat.dev) playground, a user can input a document to evaluate various QA chain(s) on. Optionally, a user can include a test set of question-answer pairs related to the document; see examples [here](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/karpathy-lex-pod?ref=blog.langchain.com) and [here](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/gpt3?ref=blog.langchain.com).

- `交互式沙盒（Playground）`：灵感源自[nat.dev](https://blog.langchain.com/auto-evaluator-opportunities/nat.dev) 沙盒界面，用户可上传任意文档，用于评测多种问答链（QA chain）。此外，用户还可选择提供一组与该文档相关的测试问答对；示例见[此处](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/karpathy-lex-pod?ref=blog.langchain.com)和[此处](https://github.com/langchain-ai/auto-evaluator/tree/main/api/docs/gpt3?ref=blog.langchain.com)。

![](https://blog.langchain.com/content/images/2023/05/evalfe.png)

### **Opportunities** for improvement

### **待优化方向**

**File handling**

**文件处理**

File transfer from client to back-end is slow. For 2 files (39MB), the transfer is ~40 sec:

客户端向后端传输文件速度较慢。传输两个共 39 MB 的文件耗时约 40 秒：

|  | Prod | Local |
| --- | --- | --- |
|  | OAI embedding | OAI embedding |
| Stage | Elapsed time | Elapsed time |
| Transfer file | 37 sec | 0 sec |
| Reading file | 5 sec | 1 sec |
| Splitting docs | 3 sec | 3 sec |
| Making LLM | 1 sec | 1 sec |
| Make retriever | 6 sec | 2 sec |
| Success | ✅ | ✅ |

|  | 生产环境（Prod） | 本地环境（Local） |
| --- | --- | --- |
|  | 使用 OpenAI Embedding | 使用 OpenAI Embedding |
| 阶段（Stage） | 耗时 | 耗时 |
| 文件传输（Transfer file） | 37 秒 | 0 秒 |
| 文件读取（Reading file） | 5 秒 | 1 秒 |
| 文档切分（Splitting docs） | 3 秒 | 3 秒 |
| 构建大语言模型（Making LLM） | 1 秒 | 1 秒 |
| 构建检索器（Make retriever） | 6 秒 | 2 秒 |
| 成功完成（Success） | ✅ | ✅ |

Images bloat the files and may be be stripped prior to transfer from the client:

图片会显著增大文件体积，建议在客户端上传前将其移除：

|  | Prod | Prod | Prod | Prod |
| --- | --- | --- | --- | --- |
|  | 1.3 MB, 40 pg | 3.5 MB, 42 pg | 7.7MB, 42 pg | 32MB, 54 pg |
| Stage | Elapsed time | Elapsed time | Elapsed time | Elapsed time |
| Transfer file | 1 sec | 3 sec | 5 sec | 35 sec |
| Reading file | 5 sec | 4 sec | 6 sec | 7 sec |
| Splitting docs | 0 sec | 0 sec | 0 sec | 1 sec |
| Making LLM | 1 sec | 1 sec | 1 sec | 1 sec |
| Make retriever | 3 sec | 3 sec | 3 sec | 4 sec |
| Success | ✅ | ✅ | ✅ | ✅ |

|  | 生产环境（Prod） | 生产环境（Prod） | 生产环境（Prod） | 生产环境（Prod） |
| --- | --- | --- | --- | --- |
|  | 1.3 MB，40 页 | 3.5 MB，42 页 | 7.7 MB，42 页 | 32 MB，54 页 |
| 阶段（Stage） | 耗时 | 耗时 | 耗时 | 耗时 |
| 文件传输（Transfer file） | 1 秒 | 3 秒 | 5 秒 | 35 秒 |
| 文件读取（Reading file） | 5 秒 | 4 秒 | 6 秒 | 7 秒 |
| 文档切分（Splitting docs） | 0 秒 | 0 秒 | 0 秒 | 1 秒 |
| 构建大语言模型（Making LLM） | 1 秒 | 1 秒 | 1 秒 | 1 秒 |
| 构建检索器（Make retriever） | 3 秒 | 3 秒 | 3 秒 | 4 秒 |
| 成功完成（Success） | ✅ | ✅ | ✅ | ✅ |

**Model-written-evaluations**

**模型生成的评估**

[Anthropic](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2212.xml?ref=blog.langchain.com) 等机构已发表关于由大语言模型自动生成评估（model-written evaluations）的研究。本文为追求效率，采取了一种极为朴素的方法：我们[从输入上下文中随机采样](https://github.com/langchain-ai/auto-evaluator/blob/43833787b2d754321da6ff0637bf130e0986b498/api/evaluator_app.py?ref=blog.langchain.com#L48)，并基于这些采样片段生成问答对（QA pairs）。更多技术细节请参阅我们的博客文章：[《自动评估问答任务》](https://blog.langchain.com/auto-eval-of-question-answering-tasks/)。该方法仍有巨大改进空间（例如，设计问题时可综合考虑整个输入上下文的信息）。

**Retrievers**

**检索器（Retrievers）**

LangChain 的 [检索器抽象层（retriever abstraction）](https://blog.langchain.com/retrieval/) 支持多种文档检索方法。其中，基于向量数据库（vectorDB）嵌入向量的 *k* 近邻（k-Nearest Neighbor, k-NN）查找（例如 [FAISS](https://github.com/facebookresearch/faiss?ref=blog.langchain.com)、[Chroma](https://www.trychroma.com/?ref=blog.langchain.com) 等）是一种主流方案，但并非唯一选择。例如，Karpathy 最近探讨了将 [支持向量机（SVMs）](https://twitter.com/karpathy/status/1647025230546886658?s=20&ref=blog.langchain.com) 用作检索器；而统计类方法如 [TF-IDF](https://en.wikipedia.org/wiki/Tf%E2%80%93idf?ref=blog.langchain.com) 也值得考虑。Auto-evaluator 框架使添加和/或测试各类检索器变得十分便捷。我们构建了一个包含 15 篇论文的测试集，全部选自 Kipply 出色的 [Transformer 分类法（transformer taxonomy）](https://kipp.ly/blog/transformer-taxonomy/?ref=blog.langchain.com)。以下是该测试集（当然，它仍有优化空间）：

| Question | Answer |
| --- | --- |
| What corpus of data was GPT-3 trained on? | GPT-3 was trained on a 300B token dataset consisting mostly of filtered Common Crawl, along with some books, webtext and Wikipedia. |
| 问题 | 答案 |
| GPT-3 是在什么语料库上训练的？ | GPT-3 在一个包含 3000 亿词元（token）的数据集上训练而成，该数据集主要由经过过滤的 Common Crawl 构成，此外还包括部分图书、网页文本和维基百科内容。 |
| What is in-context learning? | The broad set of skills and pattern recognition abilities gained during pre-training can be used at inference time to perform novel tasks given only input-output examples without any weight update. It is a an emergent behavior in large language models (LMs). |
| 什么是上下文学习（in-context learning）？ | 预训练过程中获得的广泛技能与模式识别能力，可在推理阶段仅凭输入-输出示例（无需更新模型权重）完成全新任务。这是大语言模型（LLMs）中涌现的一种行为。 |
| How much better is Galatica than GPT-3 on LaTex equations? | On LaTeX equations, Galatica achieves a score of 68.2% versus the latest GPT-3’s 49.0%. |
| Galatica 在 LaTeX 公式任务上比 GPT-3 高出多少？ | 在 LaTeX 公式任务上，Galatica 得分为 68.2%，而最新版 GPT-3 为 49.0%。 |
| What was the BLOOM model trained on? | BLOOM was trained on the ROOTS corpus, a composite collection of 498 Hugging Face datasets amounting to 1.61 terabytes of text that span 46 natural languages and 13 programming languages. |
| BLOOM 模型是在什么语料上训练的？ | BLOOM 在 ROOTS 语料库上训练而成——该语料是 498 个 Hugging Face 数据集的集合，总文本量达 1.61 TB，涵盖 46 种自然语言和 13 种编程语言。 |
| What does the Chinchilla paper argue is important for compute optimal training? | Chinchilla paper finds that for compute-optimal training, the model size and the number of training tokens should be scaled equally: for every doubling of model size the number of training tokens should also be doubled. |
| 《Chinchilla》论文指出，实现计算最优训练的关键是什么？ | 《Chinchilla》论文发现：为实现计算最优训练，模型规模与训练词元数量应等比例缩放——即模型参数量每翻一倍，训练词元数也需同步翻倍。 |

以下是汇总结果。详细结果请参阅 [此处](https://docs.google.com/spreadsheets/d/1pfo_ChvSJgLNT-GuRJFZB02RNf2FHwS-DK-gjWBlCrU/edit?usp=sharing&ref=blog.langchain.com)。

简言之，在本实验场景下，TF-IDF 和 SVM 的表现与 k-NN 相当，甚至略优。当然，这一结论并非普适，但其意义在于：检索环节存在多种可行方案，均值得深入探索与权衡。

![](images/auto-evaluator-opportunities/img_003.png)

**Model-Graded Eval**

**模型评分式评估（Model-Graded Eval）**

**Scoring prompts**

**评分提示词（Scoring prompts）**

The central idea is to use a prompt to grade model-generated answers (and retrieved docs) relative to a ground truth answer. We tested several prompts, which you can see [here](https://github.com/langchain-ai/auto-evaluator/blob/main/api/text_utils.py?ref=blog.langchain.com).

核心思想是：使用提示词（prompt）对模型生成的答案（以及检索到的文档）相对于标准答案（ground truth answer）进行评分。我们测试了多个提示词，详见[此处](https://github.com/langchain-ai/auto-evaluator/blob/main/api/text_utils.py?ref=blog.langchain.com)。

You can see results (question, answer, and grade justification) from each prompt [here](https://docs.google.com/spreadsheets/d/1pfo_ChvSJgLNT-GuRJFZB02RNf2FHwS-DK-gjWBlCrU/edit?ref=blog.langchain.com#gid=1013204299) and summary:

您可在此处查看各提示词对应的评测结果（含问题、回答及评分依据）：[链接](https://docs.google.com/spreadsheets/d/1pfo_ChvSJgLNT-GuRJFZB02RNf2FHwS-DK-gjWBlCrU/edit?ref=blog.langchain.com#gid=1013204299)，汇总如下：

| Prompt | Answer score (fraction correct) |
| --- | --- |
| Fast | 5 / 5 |
| Descriptive | 4 / 5 |
| Descriptive with bias | 5 / 5 |
| [https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml](https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml?ref=blog.langchain.com) | 2 / 5 |

| 提示词（Prompt） | 答案评分（正确率） |
| --- | --- |
| Fast | 5 / 5 |
| Descriptive | 4 / 5 |
| Descriptive with bias | 5 / 5 |
| [https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml](https://github.com/openai/evals/blob/main/evals/registry/modelgraded/closedqa.yaml?ref=blog.langchain.com) | 2 / 5 |

In short, answer scoring varies across prompts (e.g., OpenAI grading is the most stringent). Future work should focus on refining the prompts for model-graded-evaluation.

简言之，不同提示词得出的答案评分存在差异（例如，OpenAI 提供的评分标准最为严格）。后续工作应聚焦于优化面向模型自动评分（model-graded evaluation）的提示词设计。

**Variability**

**评分结果的不稳定性**

The app currently uses `GPT-3.5-turbo` as the grader, but discussion with OpenAI indicates that [GPT-4 is preferable](https://twitter.com/RLanceMartin/status/1650544176772296704?s=20&ref=blog.langchain.com). Here is one example: the grader appears to be confused by a double negative and produces a non-deterministic output for the same input answer question.

当前应用使用 `GPT-3.5-turbo` 作为评分模型，但据与 OpenAI 的交流确认，[GPT-4 是更优选择](https://twitter.com/RLanceMartin/status/1650544176772296704?s=20&ref=blog.langchain.com)。以下是一个典型示例：评分模型似乎被双重否定结构所干扰，对完全相同的问答输入却给出非确定性（即不一致）的评分结果。

| Experiment | Answer | Grade | Justification |
| --- | --- | --- | --- |
| 1 | A building permit is not required for a one-story detached accessory building or structure used as a tool and storage shed, playhouse, or similar use, provided the projected roof area does not exceed 100 square feet. | GRADE: Incorrect | JUSTIFICATION: The student answer is incorrect because it states that a building permit is not required for a structure with a projected roof area of 100 square feet or less, while the true answer states that a permit is required for any structure larger than 100 square feet. |
| 2 | A building permit is not required for one-story detached accessory buildings or structures used as tool and storage sheds, playhouses, and similar uses, provided the projected roof area does not exceed 100 square feet (9.29 m2). | GRADE: Correct | JUSTIFICATION: The student answer accurately states that a building permit is not required for structures under 100 square feet, which is true. |

| 实验编号 | 回答内容 | 评分结果 | 评分依据 |
| --- | --- | --- | --- |
| 1 | 建造一层独立附属建筑或结构（如工具与储物棚、儿童游乐屋等类似用途）无需申请建筑许可证，前提是其投影屋顶面积不超过100平方英尺。 | 评分：错误（Incorrect） | 依据：该学生回答有误，因其声称“投影屋顶面积≤100平方英尺的结构无需许可证”，而真实规则是“任何超过100平方英尺的结构均需许可证”。 |
| 2 | 建造一层独立附属建筑或结构（如工具与储物棚、儿童游乐屋等类似用途）无需申请建筑许可证，前提是其投影屋顶面积不超过100平方英尺（9.29平方米）。 | 评分：正确（Correct） | 依据：该学生回答准确指出“面积小于100平方英尺的结构无需许可证”，符合事实。 |

### Conclusion

### 结论

Feel free to contribute to the [open source](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com) repo or test the free [hosted app](https://autoevaluator.langchain.com/?ref=blog.langchain.com). Contributions related to file handling, prompts (e.g., for QA generation, grading, or QA), models (e.g., addition of open source models from Hugging Face), or retrievers are a few of the highest impact areas.

欢迎为该[开源项目](https://github.com/langchain-ai/auto-evaluator?ref=blog.langchain.com)贡献代码，或试用免费的[托管版应用](https://autoevaluator.langchain.com/?ref=blog.langchain.com)。其中，文件处理能力、提示词优化（例如用于问答生成、评分或问答任务的提示词）、模型扩展（例如集成 Hugging Face 上的开源模型）以及检索器（retriever）改进，均为当前最具影响力的重点贡献方向。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/auto-evaluator-opportunities/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/auto-evaluator-opportunities/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/auto-evaluator-opportunities/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/auto-evaluator-opportunities/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/auto-evaluator-opportunities/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/auto-evaluator-opportunities/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/auto-evaluator-opportunities/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/auto-evaluator-opportunities/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/auto-evaluator-opportunities/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/auto-evaluator-opportunities/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更轻松的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/auto-evaluator-opportunities/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/auto-evaluator-opportunities/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟