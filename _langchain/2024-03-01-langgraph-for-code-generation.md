---
render_with_liquid: false
title: "LangGraph for Code Generation"
source: "LangChain Blog"
url: "https://blog.langchain.com/code-execution-with-langgraph/"
date: "2024-03-01"
scraped_at: "2026-03-03T08:10:01.341566510+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

### Key Links

### 关键链接

- [LangGraph 食谱（cookbook）](https://github.com/langchain-ai/langgraph/blob/main/examples/code_assistant/langgraph_code_assistant.ipynb?ref=blog.langchain.com)
- [视频演示](https://www.youtube.com/watch?v=MvNdgmM7uyc&ref=blog.langchain.com)

### Motivation

### 动机

代码生成与代码分析是大语言模型（LLM）最重要、应用最广泛的两大场景，这一点从 [GitHub Copilot](https://github.com/features/copilot?ref=blog.langchain.com) 等产品的普及，以及 [GPT-engineer](https://github.com/gpt-engineer-org/gpt-engineer?ref=blog.langchain.com) 等开源项目的广泛流行中可见一斑。近期发布的 [AlphaCodium](https://arxiv.org/pdf/2401.08500.pdf?ref=blog.langchain.com) 研究表明：相较于朴素的“提示→回答”（`prompt:answer`）范式，采用基于**流程**（`flow`）的范式可显著提升代码生成质量——答案可通过以下两个步骤**迭代式地**构建：（1）对生成的代码进行测试；（2）基于测试结果进行[反思（reflection）](https://blog.langchain.com/reflection-agents/)，从而持续优化解决方案。

![](images/langgraph-for-code-generation/img_001.png)AlphaCodium 的流程图

我们近期正式发布了 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)，以支持“流程工程”（flow engineering），使用户能够将复杂逻辑建模为有向图。受 [AlphaCodium](https://arxiv.org/pdf/2401.08500.pdf?ref=blog.langchain.com) 和 [Reflexion（反思智能体）](https://blog.langchain.com/reflection-agents/) 等工作的启发，我们希望验证 LangGraph 是否能复现上图所示的、包含循环与决策点的代码生成流程。

具体而言，我们旨在构建并对比两种不同架构：

- 基于提示词（prompting）与上下文填充（context stuffing）的传统代码生成方式；
- 一种包含代码校验、执行，并在出错时自动反馈修正的闭环式代码生成流程。

该实验试图回答一个核心问题：此类代码检查机制，究竟能在多大程度上提升代码生成系统的性能？

答案是？

💡

系统在检查代码并尝试修复代码方面，相较于单次生成的基线方法取得了显著提升（81% 对比 55%）。

### Problem  
### 问题  

为在限定范围的文档语料库上展示代码生成能力，我们选取了 LangChain 文档的一个子集，聚焦于 [LangChain 表达式语言](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)（LCEL）。该主题既具有明确边界（约 60k token），又广受开发者关注。我们从 [`chat-langchain`](https://chat.langchain.com/?ref=blog.langchain.com) 平台过去 30 天的对话记录中挖掘出与 LCEL 相关的问题（相关代码见 [此处](https://github.com/langchain-ai/lcel-teacher/blob/main/eval/build_eval_set.ipynb?ref=blog.langchain.com)）。通过筛选提及 “LCEL” 的对话，我们将原始 `>60k` 条聊天记录精简至约 `500` 条。随后对这约 500 条问题进行聚类，并使用一个大语言模型（GPT-4，128k 上下文窗口）对各聚类生成摘要，从而提炼出每类中具有代表性的典型问题。我们人工审阅了所有代表性问题，并为每个问题编写了标准答案（共 20 道题的评测集见 [此处](https://github.com/langchain-ai/lcel-teacher/blob/main/eval/eval.csv?ref=blog.langchain.com)）。最后，我们将该数据集上传至 LangSmith：[点击访问](https://smith.langchain.com/public/ea1f6ca5-de52-4d36-bd7b-fde3faa74a70/d?ref=blog.langchain.com)。

![](images/langgraph-for-code-generation/img_002.png)  
LCEL 教师评测集构建工作流

### Code generation with reflection using LangGraph  
### 基于 LangGraph 的带反思机制的代码生成  

我们实现了一套具备以下组件的代码生成流程：

- 受近期长上下文大语言模型（如 [Gemini](https://blog.google/technology/ai/google-gemini-next-generation-model-february-2024/?ref=blog.langchain.com)）发展趋势启发，我们利用 GPT-4（支持 128k token 上下文窗口）将约 60k token 的 LCEL 文档“注入”（context-stuff）到提示词中；再将用户提出的 LCEL 相关问题输入该增强上下文的 LCEL 链，以生成初始答案。
- 我们使用 OpenAI 工具调用 [输出解析器](https://python.langchain.com/docs/modules/model_io/output_parsers/types/pydantic?ref=blog.langchain.com)，将模型输出结构化为一个 [Pydantic](https://docs.pydantic.dev/latest/?ref=blog.langchain.com) 对象，该对象包含三部分：（1）描述问题背景的前言（preamble）；（2）导入语句块（import block）；（3）主体代码（code）。
- 我们首先执行 **导入语句检查**，因为我们发现（参见 [此表格](https://docs.google.com/spreadsheets/d/1SkHHw52AHFFBnmljKW3Vq_YvnPpAhhBVhd1SF9mPFUk/edit?ref=blog.langchain.com#gid=0)）代码生成过程中，幻觉（hallucination）极易出现在 import 语句中。
- 若 **导入检查通过**，则进一步验证主体代码是否可成功执行。在生成提示词中，我们明确指示大语言模型：不得在代码解法中使用伪代码或未定义变量，从而确保生成的代码具备可执行性。
- 关键在于：若任一检查失败，我们将错误堆栈（stack trace）连同此前生成的答案一并传回生成节点，触发 [反思机制（reflection）](https://blog.langchain.com/reflection-agents/)。我们默认允许该流程最多重试 3 次（仅为默认值，实际中可根据需要灵活扩展）。

![](images/langgraph-for-code-generation/img_003.png)  
基于 LangGraph 的代码执行流程：含错误检查、反馈与反思机制

### Evaluation with LangSmith  
### 基于 LangSmith 的评测

As a baseline, we implement `context stuffing` without LangGraph, which is the first node in our graph without any of the checks or feedback: we context stuff the 60k token LCEL docs using GPT-4 with a 128k token context window. We pass a question about LCEL to our context-stuffed LCEL chain for answer generation.

作为基线方案，我们实现了**不使用 LangGraph 的 `context stuffing`（上下文填充）**，即图中第一个节点，不包含任何校验或反馈机制：我们使用具备 128k token 上下文窗口的 GPT-4，将 60k token 的 LCEL 文档进行上下文填充。随后，我们将一个关于 LCEL 的问题输入该上下文填充后的 LCEL 链，以生成答案。

We implement [LangSmith custom evaluators](https://docs.smith.langchain.com/evaluation/faq/custom-evaluators?ref=blog.langchain.com) for both (1) import evaluation and (2) code execution. We run evaluation on `context stuffing` with our 20 question eval set four times. [Here](https://smith.langchain.com/public/ea1f6ca5-de52-4d36-bd7b-fde3faa74a70/d?ref=blog.langchain.com) is our eval result. With `context stuffing` we see `~98%` of the import tests are correct and `~55%` of the code execution tests (`N=79` successful trials). We use LangSmith to look at our failures: [here](https://smith.langchain.com/public/b04f4258-173f-4b79-a935-1e7c8bc4526c/r?ref=blog.langchain.com) is one example, which fails to see that the `RunnableLambda` function input will be a `dict` and thinks that it is a `string`: `AttributeError: 'dict' object has no attribute 'upper'`

我们为（1）导入语句评估和（2）代码执行评估分别实现了 [LangSmith 自定义评估器](https://docs.smith.langchain.com/evaluation/faq/custom-evaluators?ref=blog.langchain.com)。我们在包含 20 个问题的评估集上对 `context stuffing` 进行了四轮评估。[此处](https://smith.langchain.com/public/ea1f6ca5-de52-4d36-bd7b-fde3faa74a70/d?ref=blog.langchain.com) 是我们的评估结果。在 `context stuffing` 方案下，导入语句测试的准确率为 `~98%`，而代码执行测试的准确率仅为 `~55%`（共 `N=79` 次成功运行）。我们借助 LangSmith 分析失败案例：[此处](https://smith.langchain.com/public/b04f4258-173f-4b79-a935-1e7c8bc4526c/r?ref=blog.langchain.com) 是一个典型示例——模型未能识别 `RunnableLambda` 函数的输入是一个 `dict`，错误地将其当作 `string` 处理，从而引发异常：`AttributeError: 'dict' object has no attribute 'upper'`。

We then tested `context stuffing + LangGraph` to (1) perform checks for errors like this in both imports and code execution and (2) [reflect](https://blog.langchain.com/reflection-agents/) on any errors when performing updated answer generation. On the same eval set, we see `100%` of the import tests are correct along with `~81%` of the code execution tests (`N=78` trials).

随后，我们测试了 **`context stuffing + LangGraph`** 方案，旨在：（1）在导入与代码执行环节主动检测此类错误；（2）在生成更新答案时，对已发生的错误进行 [反思（reflection）](https://blog.langchain.com/reflection-agents/)。在相同的评估集上，我们观察到：导入语句测试准确率达到 `100%`，代码执行测试准确率提升至 `~81%`（共 `N=78` 次运行）。

We can revisit the above failure to demonstrate why: the full [trace](https://smith.langchain.com/public/b595525e-59fe-4cb6-905b-2bad8e0e9165/r?ref=blog.langchain.com) shows that we **do** hit that same error [here](https://smith.langchain.com/public/0a1c33fa-c947-42ab-9dae-16fc7868ad53/r?ref=blog.langchain.com), in our second attempt at answering the question. We include this error in our [reflection](https://blog.langchain.com/reflection-agents/) step in which both the prior solution and the resulting error are provided within the prompt for the final (correct) answer:

我们可以回溯上述失败案例，以说明改进原理：完整的 [执行追踪（trace）](https://smith.langchain.com/public/b595525e-59fe-4cb6-905b-2bad8e0e9165/r?ref=blog.langchain.com) 显示，我们在回答该问题的**第二次尝试中确实复现了同一错误**（见 [此处](https://smith.langchain.com/public/0a1c33fa-c947-42ab-9dae-16fc7868ad53/r?ref=blog.langchain.com)）。该错误被纳入我们的 [反思（reflection）](https://blog.langchain.com/reflection-agents/) 步骤——在生成最终（正确）答案的提示词（prompt）中，同时提供了前一次的解决方案及由此产生的错误信息：

```python
You previously tried to solve this problem.
...
--- Most recent run error ---
Execution error: 'dict' object has no attribute 'upper'
...
Please re-try to answer this.
...
```

```python
你此前曾尝试解决此问题。
...
--- 最近一次运行报错 ---
执行错误：'dict' 对象没有属性 'upper'
...
请重新尝试回答此问题。
...
```

The [final generation](https://smith.langchain.com/public/b595525e-59fe-4cb6-905b-2bad8e0e9165/r?ref=blog.langchain.com) then correctly handles the input dict in the `RunnableLambda` function, bypassing the error observed in the `context stuffing` base case. Overall, adding this simple reflection step and re-try using LangGraph results in a substantial improvement on code execution, `~47%` improvement:

[最终生成结果](https://smith.langchain.com/public/b595525e-59fe-4cb6-905b-2bad8e0e9165/r?ref=blog.langchain.com) 正确处理了 `RunnableLambda` 函数的 `dict` 类型输入，成功规避了基线 `context stuffing` 方案中出现的错误。总体而言，仅通过在 LangGraph 中加入这一简单的反思步骤与重试机制，代码执行准确率即获得显著提升，达 `~47%`：

![](images/langgraph-for-code-generation/img_004.png)LangSmith evaluation for imports and code execution with and without LangGraph

![](images/langgraph-for-code-generation/img_004.png)使用与不使用 LangGraph 时，LangSmith 对导入语句与代码执行的评估结果对比

### Conclusion

### 结论

LangGraph makes it easy to engineer flows with various cycles and decision points. [Recent work](https://arxiv.org/pdf/2401.08500.pdf?ref=blog.langchain.com) has shown that this is powerful for code generation, where answers to coding questions can be constructed iteratively using using tests to check answers, [reflect](https://blog.langchain.com/reflection-agents/) on failures, and iteratively improve the answer. We show that this can be implemented in LangGraph and test it on 20 questions related to LCEL for both code imports and execution. We find that `context stuffing + LangGraph` with reflection results in `~47%` improvement in code execution relative `context stuffing`. The notebook is [here](https://github.com/langchain-ai/langgraph/blob/main/examples/code_assistant/lcel-teacher-langgraph.ipynb?ref=blog.langchain.com) and be extended to other codebases trivially.

LangGraph 极大简化了具备多种循环与决策点的工作流构建。[近期研究](https://arxiv.org/pdf/2401.08500.pdf?ref=blog.langchain.com) 表明，该能力在代码生成任务中尤为强大：针对编程类问题的答案可借助测试用例验证、对失败结果进行 [反思（reflection）](https://blog.langchain.com/reflection-agents/)，并迭代优化答案。本文展示了如何在 LangGraph 中实现该范式，并在 20 个与 LCEL 相关的问题上，分别对代码导入与执行进行了实证测试。结果表明，相比纯 `context stuffing`，引入反思机制的 `context stuffing + LangGraph` 方案使代码执行准确率提升了 `~47%`。相关 Notebook 示例见 [此处](https://github.com/langchain-ai/langgraph/blob/main/examples/code_assistant/lcel-teacher-langgraph.ipynb?ref=blog.langchain.com)，且可轻松迁移适配至其他代码库。