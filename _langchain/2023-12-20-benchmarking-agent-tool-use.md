---
render_with_liquid: false
title: "Benchmarking Agent Tool Use"
source: "LangChain Blog"
url: "https://blog.langchain.com/benchmarking-agent-tool-use/"
date: "2023-12-20"
scraped_at: "2026-03-03T08:19:21.584081262+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Agents may be _the_ [“killer” LLM app](https://www.latent.space/p/agents?ref=blog.langchain.com), but building and evaluating agents is hard.  
代理可能是 _那个_ [“杀手级”大语言模型应用](https://www.latent.space/p/agents?ref=blog.langchain.com)，但构建和评估代理却十分困难。

Function calling is a key skill for effective tool use, but there aren’t many good benchmarks for measuring function calling performance.  
函数调用是高效使用工具的一项关键能力，但目前尚缺乏足够优质的基准测试来衡量函数调用性能。

Today, we are excited to release [four new test environments](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com) for benchmarking LLMs’ ability to effectively use tools to accomplish tasks.  
今天，我们很高兴地发布 [四个全新的测试环境](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com)，用于评测大语言模型（LLM）有效运用工具完成任务的能力。

We hope this makes it easier for everyone to test different LLM and prompting strategies to show what enables the best agentic behavior.  
我们希望这能帮助大家更便捷地测试不同的大语言模型与提示策略，从而揭示哪些因素最有助于实现卓越的代理行为。

![](images/benchmarking-agent-tool-use/img_001.png)Example successful tool use for the Relational Data task  
![](images/benchmarking-agent-tool-use/img_001.png)关系型数据任务中工具成功调用的示例

We designed these tasks to test capabilities we consider to be prerequisites for common agentic workflows, such as planning / task decomposition, function calling, and the ability to override pre-trained biases when needed.  
我们设计这些任务，旨在检验那些我们认为是常见代理工作流所必需的前提能力，例如：规划／任务分解、函数调用，以及在必要时覆盖预训练偏差的能力。

If an LLM is **unable** to solve these types of tasks (without explicit fine-tuning), it will likely struggle to perform and generalize reliably for other workflows where “reasoning” is required.  
如果某一大语言模型 **无法**（在未经显式微调的前提下）解决此类任务，则它在其他需要“推理”能力的工作流中，很可能也难以稳定执行并可靠泛化。

Below are some key take-aways for those eager to see our findings:  
以下是我们研究发现中一些关键结论，供急于了解结果的读者参考：

![](images/benchmarking-agent-tool-use/img_002.png)Overall performance across all tasks (weighted average). Error bars computed using standard error.  
![](images/benchmarking-agent-tool-use/img_002.png)所有任务上的整体表现（加权平均值）。误差线基于标准误计算得出。

💡  

**Key Findings**  
**关键发现**

**\-** _All_ of the models can fail over longer trajectories, even for simple tasks.  
**–** 所有模型在较长的推理轨迹中均可能出现失败，即使面对的是简单任务。

\- GPT-4 got the highest score on the Relational Data task, which most closely approximates common usage.  
– GPT-4 在关系型数据任务中得分最高，该任务最贴近实际应用场景。

**-** GPT-4 seems to be _worse_ than GPT-3.5 on the Multiverse Math task; it's possible its pretrained bias hinders its performance in an example of [inverse scaling](https://github.com/inverse-scaling/prize?ref=blog.langchain.com).  
**–** GPT-4 在多元宇宙数学（Multiverse Math）任务中的表现似乎 **逊于** GPT-3.5；这很可能是其预训练偏差所致，属于典型的 [逆向缩放（inverse scaling）](https://github.com/inverse-scaling/prize?ref=blog.langchain.com) 现象。

\- Claude-2.1 performs within the error bounds of GPT-4 for 3 of 4 tasks, though seems to lag GPT-4 on the relational data task.  
– Claude-2.1 在四项任务中的三项上表现处于 GPT-4 的误差范围之内；但在关系型数据任务上，其表现似乎略逊于 GPT-4。

\- 尽管能够输出格式良好的工具调用，AnyScale 微调版本的 Mistral 7B 在可靠地组合超过 2 次调用方面仍存在困难。未来开源的函数调用（function calling）研究工作，除需确保单次调用的正确性外，还应重点关注函数组合（function composition）能力。

\- 除模型质量外，服务可靠性同样重要。我们在使用最受欢迎的模型提供商服务时，频繁遭遇随机出现的 5xx 错误。

🦜

**那么，这意味着什么？**

\- 即便模型具备超人的知识广度，若你的任务类型或领域知识与其预训练数据存在显著差异，这种优势也无从发挥。在部署前，请务必针对你所期望的关键行为模式，对所选大语言模型（LLM）进行充分验证。

\- 规划（planning）对当前 LLM 而言仍是难点——即使对于简单任务，所需执行步骤越多，失败概率也越高。

\- 函数调用虽能轻松实现 100% 的 Schema 正确性，但这远不足以保证任务层面的正确性。若你正为智能体（agent）应用微调模型，则必须在多步推理轨迹（multi-step trajectories）上进行训练。

在本文后续部分，我们将逐一介绍各项任务，并分享部分初步基准测试结果。

## 实验概览

在本次发布中，我们公开了涵盖 4 类工具使用任务、共 7 款模型的实验结果与可复现代码：

- [Typewriter (Single tool):](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_1.html?ref=blog.langchain.com) sequentially call a single tool to type out a word.  
- [打字机（单工具）：](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_1.html?ref=blog.langchain.com) 依次调用单一工具，逐个字母拼写出一个单词。

- [Typewriter (26 tools):](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_26.html?ref=blog.langchain.com) call different tools in sequence to type out a word.  
- [打字机（26 工具）：](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_26.html?ref=blog.langchain.com) 按顺序调用不同的工具（共 26 个，每个对应一个字母），拼写出一个单词。

- [Relational Data:](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/relational_data.html?ref=blog.langchain.com) answer questions based on information in three tables.  
- [关系型数据：](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/relational_data.html?ref=blog.langchain.com) 基于三张表格中的信息回答问题。

- [Multiverse Math:](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com) use tools to answer math problems, where the underlying math rules have changed slightly.  
- [多元宇宙数学：](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com) 使用工具解答数学问题，其中底层数学规则发生了细微变化。

We calculate four metrics across these tasks:  
我们在上述各项任务中计算四项评估指标：

1. Correctness (compared to the ground truth) - this uses an LLM as a judge. Since the answers for all these questions are concise and fairly binary, we found the judgements to correspond to our own decisions.  
1. 正确性（与标准答案对比）——该指标使用大语言模型（LLM）作为裁判。由于所有问题的答案均简洁且具有较强的二元性（即“对/错”倾向明显），我们发现模型的判断结果与人工判断高度一致。

2. Correct final state (environment) - for the typewriter tasks, each tool invocation updates the world state. We directly check the equivalence of the environment at the end of each test row.  
2. 最终状态正确性（环境一致性）——在打字机类任务中，每次工具调用都会更新世界状态。我们直接比对每条测试样本执行完毕后环境状态是否与标准状态完全一致。

3. Intermediate step correctness - each data point has an optimal sequence of function calls to obtain the correct answer. We directly check the order of function calls against the ground truth.  
3. 中间步骤正确性——每个数据样本均对应一条获取正确答案的最优函数调用序列。我们直接将实际调用顺序与标准序列进行比对。

4. Ratio of steps taken to the expected steps - it may be that an agent ultimately returns the correct answer despite choosing a suboptimal set of tools. This metric will reflect discrepancies without being as strict as the exact match intermediate step correctness.  
4. 实际步数与预期步数之比——智能体可能虽未选择最优工具组合，但仍最终返回了正确答案。该指标可反映路径效率差异，其严格程度低于“中间步骤完全匹配”的精确性要求。

We compared both closed source models as well as open source. Expand the section below for more details.  
我们同时对比了闭源模型与开源模型。请展开下方章节以查看详细信息。

#### Models Tested  
#### 测试模型

**Open Source:**  
**开源模型：**

- Mistral-7b-instruct-v0.1: Mistral’s 7B parameter model [adapted by Anyscale](https://docs.endpoints.anyscale.com/guides/function-calling/?ref=blog.langchain.com) for function calling.  
- Mistral-7b-instruct-v0.1：Mistral 公司推出的 70 亿参数模型，由 [Anyscale](https://docs.endpoints.anyscale.com/guides/function-calling/?ref=blog.langchain.com) 针对函数调用能力进行了适配。

- Mixtral-8x7b-instruct: Mistral's 7B parameter mixture of experts model, adapted using instruction tuning by [Fireworks.ai](https://app.fireworks.ai/models/fireworks/mixtral-8x7b-instruct?ref=blog.langchain.com).  
- Mixtral-8x7b-instruct：Mistral 公司推出的基于稀疏专家混合（MoE）架构的 70 亿参数模型（共 8 个专家），由 [Fireworks.ai](https://app.fireworks.ai/models/fireworks/mixtral-8x7b-instruct?ref=blog.langchain.com) 通过指令微调（instruction tuning）适配而成。

**OpenAI - (Tool Calling Agent)**  
**OpenAI —（支持工具调用的智能体）**

- GPT-3.5-0613  
- GPT-3.5-1106-preview  
- GPT-4-0613  
- GPT-4-1106-preview  

**Anthropic**  
**Anthropic**

- Claude 2.1 使用 XML 提示（XML prompting）及其 [tool user](https://github.com/anthropics/anthropic-tools?ref=blog.langchain.com) 工具库。

## ⌨ 打字机任务（单工具场景）

## ⌨ 打字机任务（单工具场景）

打字机任务非常简单：智能体必须“输入”给定的单词，然后停止。单词难度从简单（如 `a` 或 `cat`）到稍难（如 `communication` 和 `keyboard`）不等。在[单工具设定](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_1.html?ref=blog.langchain.com)中，模型仅被赋予一个 `type_letter` 工具，该工具接受单个字符作为输入。要通过该任务，智能体只需按正确顺序对每个字母依次调用该工具即可。例如，对于单词 `cat`，智能体将执行如下操作：

![](images/benchmarking-agent-tool-use/img_003.png)单工具打字机任务中工具成功调用的示例

您可通过[此链接查看完整数据集](https://smith.langchain.com/public/ff14ecb2-3664-4c4a-b2dc-d8aa9fd2185d/d?ref=blog.langchain.com)，了解其具体形式；也可查阅[相关文档](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_1.html?ref=blog.langchain.com)，获取更多关于如何自行运行该任务的信息。

对于任何值得尊重的智能体而言，顺利通过如此简单的任务只是基本门槛；人们自然会预期像 `gpt-4` 这类具备工具调用能力的大模型能轻松、出色地完成该任务——但我们的实测结果却表明，事实并非总是如此！例如，[这个案例](https://smith.langchain.com/public/ff14ecb2-3664-4c4a-b2dc-d8aa9fd2185d/d/96bfa9ef-a5fa-44f2-a77c-28d5a18901db/p/r/0edc843e-20a7-4438-88be-ffd038969002?ref=blog.langchain.com)中，智能体直接拒绝尝试输入单词 “keyboard”；又如[另一个案例](https://smith.langchain.com/public/ff14ecb2-3664-4c4a-b2dc-d8aa9fd2185d/d/96bfa9ef-a5fa-44f2-a77c-28d5a18901db/p/r/7562cf69-b8cf-47d0-a605-825d2809f08e?ref=blog.langchain.com)，智能体甚至未能识别出所给定的单词 “head”。

![](images/benchmarking-agent-tool-use/img_004.png)GPT-4 未能正确理解所提供的单词。

以下是各测试智能体在该任务上的表现结果：

![](images/benchmarking-agent-tool-use/img_005.svg)大多数闭源模型的表现彼此接近，均处于相近的误差范围内。经过函数微调（function-tuned）的 `mistral-7b` 模型无法有效连续调用超过 1 个工具。

上图展示了各智能体在给定数据集上的平均正确率。误差线表示标准误（standard error）。

Standard Error=p^±p×(1−p)n \\text{Standard Error} = \\hat{p}\\pm\\sqrt{\\frac{p \\times (1 - p)}{n}}Standard Error=p^​±np×(1−p)​​

标准误 = $\hat{p} \pm \sqrt{\dfrac{p \times (1 - p)}{n}}$

We were surprised by the poor performance of the fine-tuned `mistral-7b-instruct-v0.1` model. Why does it struggle for this task? Let's review one of its runs to see where it could be improved. For the data point ["aaa" (see linked run)](https://smith.langchain.com/public/ff14ecb2-3664-4c4a-b2dc-d8aa9fd2185d/d/b35a7f62-4ed2-4473-825d-05ac52ed6c4f/p/r/b8b01e0d-eae1-4978-aafd-4b34c86d7591?ref=blog.langchain.com), the model first invokes "a", then responds in text "a" with a mis-formatted function call for the letter "b". The agent then returns.

我们对微调后的 `mistral-7b-instruct-v0.1` 模型表现欠佳感到意外。为何它在此任务上力不从心？让我们回顾一次其实际运行过程，以定位可改进之处。针对数据点 ["aaa"（参见关联的运行记录）](https://smith.langchain.com/public/ff14ecb2-3664-4c4a-b2dc-d8aa9fd2185d/d/b35a7f62-4ed2-4473-825d-05ac52ed6c4f/p/r/b8b01e0d-eae1-4978-aafd-4b34c86d7591?ref=blog.langchain.com)，该模型首先调用工具 "a"，随后在文本响应中输出 "a"，但紧接着为字母 "b" 生成了一个格式错误的函数调用，之后智能体即终止运行。

![](images/benchmarking-agent-tool-use/img_006.png)Failing response on the second invocation.

![](images/benchmarking-agent-tool-use/img_006.png)第二次调用时的失败响应。

The image above is taken from the second LLM invocation, after it has succesfully typed the letter "a". Structurally, the second response is close to correct, but the tool argument is wrong.

上图截取自第二次大语言模型调用过程，此时模型已成功输入字母 "a"。从结构上看，第二次响应已接近正确，但所调用工具的参数有误。

## ⌨️ Typewriter (26 tools)

## ⌨️ 打字机任务（26 个工具）

You’ll likely want your agent to be able to use more than one tool in your application, but will it be able to use them all effectively? How much is too much?

在您的应用中，您很可能希望智能体能够调用多个工具；但它真能高效地使用全部这些工具吗？究竟多少才算“过多”？

The 26-tool typewriter task tests the same thing as the single-tool use case: is the agent able to type the provided word using the provided tools (and then stop)? The difference here is that the agent must select between each of 26 tools, 1 for each letter in the English alphabet. None of the tools accept any arguments. Our `cat` example above would be passed by doing the following:

26 工具打字机任务所测试的内容与单工具用例完全一致：智能体能否利用所提供的工具准确输入指定单词（并在完成后及时停止）？区别在于，此处智能体必须在全部 26 个工具中进行选择——每个工具对应英文字母表中的一个字母，且所有工具均不接受任何参数。前文提到的 `cat` 示例，可通过如下方式顺利通过：

![](images/benchmarking-agent-tool-use/img_007.png)Example successful tool use for the 26-tool typewriter task

![](images/benchmarking-agent-tool-use/img_007.png)26 工具打字机任务中一次成功的工具调用示例

The dataset for this task uses the same test input words as the dataset for the single-tool typewriter. You can check out the dataset [at this link](https://smith.langchain.com/o/30239cd8-922f-4722-808d-897e1e722845/datasets/0c8a0acd-0308-4298-82bb-e28cec0ca5e1?tab=1&ref=blog.langchain.com) and review the [task documentation](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_26.html?ref=blog.langchain.com) for more details, including how to run your own agent on this benchmark.

本任务所用数据集与单工具打字机任务完全相同，均采用相同的测试输入单词。您可通过[此链接](https://smith.langchain.com/o/30239cd8-922f-4722-808d-897e1e722845/datasets/0c8a0acd-0308-4298-82bb-e28cec0ca5e1?tab=1&ref=blog.langchain.com)查看该数据集，并查阅[任务文档](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/typewriter_26.html?ref=blog.langchain.com)，获取更多详细信息，包括如何在该基准测试上运行您自己的智能体。

Once again, you'd assume this task to be trivial for a powerful model like `gpt-4`, but you'd once again be proven incorrect. Take [this run](https://smith.langchain.com/public/04e87ccf-50e3-487d-b3d8-24b85fad728c/d/fc001162-6568-48dd-be78-e67aba550cb3/p/r/ad2e21d6-16ec-4fca-9747-af4df92cff7c?ref=blog.langchain.com) as an example. When asked to type "aaaa", it types the four a's out at first but then fails to halt, typing "a" 4 more times before deciding it is done.

再一次，您或许会认为对于 `gpt-4` 这类强大模型而言，此项任务应轻而易举；但事实再次证明这种假设是错误的。以[此次运行记录](https://smith.langchain.com/public/04e87ccf-50e3-487d-b3d8-24b85fad728c/d/fc001162-6568-48dd-be78-e67aba550cb3/p/r/ad2e21d6-16ec-4fca-9747-af4df92cff7c?ref=blog.langchain.com)为例：当被要求输入 "aaaa" 时，模型起初确实连续输出了四个 "a"，但随后未能及时终止，又额外重复输入了四次 "a"，才最终判定任务完成。

![](images/benchmarking-agent-tool-use/img_008.png)GPT-4 失败，未能返回结果，持续调用额外函数。

Below are the results for this task across the tested agents:

以下是在各受测智能体上该任务的评测结果：

![](images/benchmarking-agent-tool-use/img_009.svg)This task was particularly difficult to benchmark due to frequent internal errors as it seems to trigger pathological behavior across many models, resulting in a large drop in performance for agents based on OpenAI models.

![](images/benchmarking-agent-tool-use/img_009.svg)由于频繁出现内部错误，该任务的基准测试尤为困难——它似乎会触发多种模型的病理性行为，导致基于 OpenAI 模型的智能体性能大幅下降。

## 🕷️ Relational Data

## 🕷️ 关系型数据

A helpful AI assistant should be able to reason about objects and their relationships. Answering a real-world question usually requires synthesizing responses from disparate sources, but how reliable are LLMs at "thinking" in this way?

一个有用的 AI 助手应能对对象及其相互关系进行推理。回答现实世界中的问题通常需要从多个异构来源中综合信息，但大语言模型（LLM）在以这种方式“思考”时，其可靠性究竟如何？

[In the relational data task](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/relational_data.html?ref=blog.langchain.com), the agent must answer questions based on data contained across 3 relational tables. To use the tools, it is given the following instructions:

[在“关系型数据”任务中](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/relational_data.html?ref=blog.langchain.com)，智能体需基于分布在 3 张关系型表中的数据来回答问题。为使用工具，它被赋予如下指令：

_Please answer the user's question by using the tools provided. Do not guess the answer. Keep in mind that entities like users, foods and locations have both a name and an ID, which are not the same._

请使用所提供的工具回答用户的问题；切勿猜测答案。请注意：用户、食物、地点等实体均同时具有名称（name）和 ID，二者并不相同。

The agent can query these tables for the correct answer using a set of 17 tools at its disposal. The three tables contain information about users, locations and foods, respectively. Of all the synthetic datasets released today, this dataset most closely resembles tool usage in real-life web applications.

智能体可借助其可用的 17 种工具查询这些表，从而获取正确答案。三张表分别存储关于用户、地点和食物的信息。在今日发布的所有合成数据集中，该数据集最贴近真实 Web 应用中的工具使用场景。

Using the data in the tables, it’s possible to answer questions like: “ [what can you tell me about Alice](https://smith.langchain.com/public/76d4cadd-9d65-41b9-a934-e3b96c98d270/r/e729c5a0-5d0d-4bc8-9fab-89bc86d934ff?ref=blog.langchain.com)?” or “ [is it likely that Alice needs an umbrella now?](https://smith.langchain.com/public/945226fb-2b96-41fb-b07d-59b78b73337e/r/f21b0d61-b096-4d5a-b252-e754a316439b?ref=blog.langchain.com)” (sample data shown below).

利用表中数据，可回答如下问题：“[关于 Alice，你能告诉我些什么？](https://smith.langchain.com/public/76d4cadd-9d65-41b9-a934-e3b96c98d270/r/e729c5a0-5d0d-4bc8-9fab-89bc86d934ff?ref=blog.langchain.com)” 或 “[Alice 现在很可能需要雨伞吗？](https://smith.langchain.com/public/945226fb-2b96-41fb-b07d-59b78b73337e/r/f21b0d61-b096-4d5a-b252-e754a316439b?ref=blog.langchain.com)”（下方展示部分示例数据）。

Below is an illustration of the latter question:

下方即为后一问题的示意图：

![](images/benchmarking-agent-tool-use/img_001.png)  
![](images/benchmarking-agent-tool-use/img_001.png)  
Example successful tool use for the Relational Data task  

关系数据任务中工具成功调用的示例  

For this example, the agent selects the following 3 tools from the 17 at its disposal:  

本例中，智能体从其可使用的 17 个工具中选出了以下 3 个工具：  

- `find_users_by_name(name)` → search for users by name.  
- `find_users_by_name(name)` → 根据姓名搜索用户。  
- `get_user_location(user_id)` → look up the given user’s favorite color.  
- `get_user_location(user_id)` → 查询指定用户的所在地（注：原文此处描述有误，实际应为“所在地”，见下文表格及上下文；正确语义参见 Locations 表）。  
- `get_weather_at_location(location_id)` → get the weather at the given location.  
- `get_weather_at_location(location_id)` → 获取指定地点的天气信息。  

By looking at the first 2 records of each table, we can see the results that these function calls will return:  

通过查看每张表的前两条记录，我们可以了解这些函数调用将返回的结果：  

**Users**  

**用户表（Users）**  

| id | name | email | location | favorite\_color | favorite\_foods |  
| --- | --- | --- | --- | --- | --- |  
| 1 | Alice | alice@gmail.com | 1 | red | \[1, 2, 3\] |  
| 21 | Bob | bob@hotmail.com | 2 | orange | \[4, 5, 6\] |  

**Locations**  

**地点表（Locations）**  

| id | city | current\_time | current\_weather |  
| --- | --- | --- | --- |  
| 1 | New York | 2023-11-14 10:30 AM | Partly Cloudy, Temperature: 68°F |  
| 2 | Los Angeles | 2023-11-14 7:45 AM | Sunny, Temperature: 75°F |  

**Foods**  

**食物表（Foods）**  

| id | name | calories | allergic\_ingredients |  
| --- | --- | --- | --- |  
| 1 | Pizza | 285 | \["Gluten", "Dairy"\] |  
| 2 | Chocolate | 50 | \["Milk", "Soy"\] |

The agent first retrieves Alice's user ID, then uses that user ID to fetch the current location, and finally it uses the location ID to fetch the current weather. Since the current weather in Alice's location is partly cloudy, it is unlikely that she will need an umbrella. If the agent skips any of these steps, it will lack the required information to accurately provide the final answer.

代理首先检索 Alice 的用户 ID，然后使用该用户 ID 获取其当前所在位置，最后再利用该位置 ID 获取当前天气。由于 Alice 所在地当前天气为局部多云，她大概率不需要雨伞。如果代理跳过其中任一环节，便会缺少必要信息，从而无法准确给出最终答案。

The evaluation dataset consists of 20 questions of varying difficulty, letting us test how well the agent can reason about how each function depends on the others. You can explore the dataset at [this link](https://smith.langchain.com/public/c0ed663a-bd4b-41e6-9ddc-0f8043e576ce/d?tab=1&ref=blog.langchain.com). The chart below shares the results for this task across the tested agents:

评估数据集共包含 20 道难度各异的问题，用于测试代理对各函数间依赖关系的推理能力。您可通过[此链接](https://smith.langchain.com/public/c0ed663a-bd4b-41e6-9ddc-0f8043e576ce/d?tab=1&ref=blog.langchain.com)浏览该数据集。下方图表展示了各被测代理在此任务上的表现结果：

![](images/benchmarking-agent-tool-use/img_011.png)The Relational Data task results are ranked closer to what you would expect, given these models' performances on other benchmarks. This task is most similar to common application requirements. The OSS models we tested still have room for improvement.

![](images/benchmarking-agent-tool-use/img_011.png)“关系型数据”任务的结果排名更接近我们基于这些模型在其他基准测试中的表现所预期的水平。该任务与常见应用需求最为相似。我们所测试的开源（OSS）模型仍有提升空间。

Despite being somewhat more difficult than the first two tasks in terms of reasoning ability required, GPT-4 does quite well on this task, answering all but [1 question correctly](https://smith.langchain.com/public/c0ed663a-bd4b-41e6-9ddc-0f8043e576ce/d/d69bf909-b92d-47ab-907e-639eda223368/p/r/1b3dad9f-54b3-4b1a-bdee-b125a7eaf490?ref=blog.langchain.com). Let's walk through this failure. For this data point, the agent is prompted with "Frank who is Even's friend is allergic to dairy. Can he eat the salad?"

尽管该任务对推理能力的要求略高于前两项任务，GPT-4 在此项任务中仍表现出色，仅[一道题回答错误](https://smith.langchain.com/public/c0ed663a-bd4b-41e6-9ddc-0f8043e576ce/d/d69bf909-b92d-47ab-907e-639eda223368/p/r/1b3dad9f-54b3-4b1a-bdee-b125a7eaf490?ref=blog.langchain.com)。下面我们分析这次失败案例。针对该数据点，代理收到的提示是：“Frank 是 Even 的朋友，他对乳制品过敏。他能吃这份沙拉吗？”

![](images/benchmarking-agent-tool-use/img_012.png)Agent ignores the tool response, deciding it doesn't match the provided user.

![](images/benchmarking-agent-tool-use/img_012.png)代理忽略了工具返回的结果，判定其与所请求的用户不匹配。

In this case, `GPT-4` makes the correct first call to `get_users_by_name("Frank")`. The tool returns with information about "Frank the Cat." The model then decides this doesn't match the requested "frank", so it queries again for "Even". There is no direct match, so the agent gives up, responding that it cannot find a user named "Even". While it may be understandable that it would be less confident about "Frank the cat", the agent neither considers it as a possible match nor does the agent mention it in its ultimate response to the user, meaning the user wouldn't be able to effectively provide feedback to help the agent self-correct.

本例中，`GPT-4` 正确地首次调用了 `get_users_by_name("Frank")`。工具返回了关于“Frank the Cat”（猫弗兰克）的信息。但模型随即判定该结果与所请求的“Frank”不匹配，于是转而再次查询“Even”。由于未找到直接匹配项，代理便放弃尝试，并回复用户“找不到名为 ‘Even’ 的用户”。尽管模型对“猫弗兰克”这一结果信心不足尚可理解，但它既未将该结果视为潜在匹配项，也未在最终回复中向用户提及，导致用户无法提供有效反馈以帮助代理自我修正。

## 🌌 Multiverse Math

## 🌌 多元宇宙数学

LLMs are marketed as “reasoning machines,” but how well can they “reason” in practice?

大语言模型（LLM）常被宣传为“推理机器”，但它们在实际场景中究竟有多强的“推理”能力？

In the [multiverse math task](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com), agents must answer simple math questions, such as [add 2 and 3](https://smith.langchain.com/public/594f9f60-30a0-49bf-b075-f44beabf546a/d/20ea2f0e-b306-474a-8daa-f4386cc16599/e?ref=blog.langchain.com). The twist is that that in _this_ “mathematical universe”, math operations are not the same as what you’d expect. Want to do `2 + 2`? The answer is `5.2` . Subtract `5.2` and `2` ? The answer is `0.2`.

在[多元宇宙数学任务](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com)中，代理需回答诸如[将 2 和 3 相加](https://smith.langchain.com/public/594f9f60-30a0-49bf-b075-f44beabf546a/d/20ea2f0e-b306-474a-8daa-f4386cc16599/e?ref=blog.langchain.com)等简单算术问题。其特殊之处在于：在这个“数学宇宙”中，运算规则与常规认知截然不同。例如，`2 + 2` 的结果是 `5.2`；而 `5.2 − 2` 的结果则是 `0.2`。

The full task instructions provided to the LLM (provided in the system prompt where available) are provided below:

以下为提供给大语言模型的完整任务说明（在支持系统提示词的场景下，即通过 system prompt 提供）：

_You are requested to solve math questions in an alternate mathematical universe. The operations have been altered to yield different results than expected. Do not guess the answer or rely on your innate knowledge of math. Use the provided tools to answer the question. While associativity and commutativity apply, distributivity does not. Answer the question using the fewest possible tools. Only include the numeric response without any clarifications._

_您被要求在一个替代数学宇宙中解答数学问题。其中的运算规则已被修改，所得结果与常规数学预期不同。请勿猜测答案，也不要依赖您固有的数学知识。请使用所提供的工具来解答问题。尽管结合律和交换律依然成立，但分配律不成立。请使用尽可能少的工具来解答问题。仅输出纯数字结果，不得包含任何解释性文字。_

Importantly, while these common operations (add, subtract, multiply, divide, cos, etc.) are all slightly altered, most mathematical properties still hold. Operations are still commutative and associative, though they are not distributive.

重要的是，尽管这些常见运算（加、减、乘、除、cos 等）均被轻微修改，但大多数数学性质依然保持不变：运算仍满足交换律和结合律，但不满足分配律。

Let’s walk through [an example](https://smith.langchain.com/public/224dc6f5-fce6-4fa6-b8f2-b050a431e581/d/11cca141-212f-4d65-a2cd-ebbe497aa894/e?ref=blog.langchain.com) to illustrate what we mean: "ecoli divides every 20 minutes. How many cells will be there after 2 hours (120 minutes) if we start with 5 cells?"

让我们通过[一个示例](https://smith.langchain.com/public/224dc6f5-fce6-4fa6-b8f2-b050a431e581/d/11cca141-212f-4d65-a2cd-ebbe497aa894/e?ref=blog.langchain.com)来说明我们的含义：“大肠杆菌每 20 分钟分裂一次。若初始有 5 个细胞，2 小时（即 120 分钟）后将有多少个细胞？”

![](images/benchmarking-agent-tool-use/img_013.png)Example successful tool use for the Multiverse Math task

![](images/benchmarking-agent-tool-use/img_013.png)“多元宇宙数学”任务中工具成功调用的示例

To solve this using the provided tools, the agent needs to identify:

要使用所提供的工具解决此问题，智能体需识别出：

- How many divisions `d` will occur in the allotted time? (`d = 120/20`)  
- 在规定时间内将发生多少次分裂？（`d = 120 / 20`）

- Then, for each cell `c`, how many cells will be produced? (`c = 2**d`)  
- 接着，每个初始细胞将产生多少个细胞？（`c = 2 ** d`）

- Then how many cells will result `f` at the end (`f = 5*c`)  
- 最终总细胞数 `f` 是多少？（`f = 5 * c`）

`GPT-4` may have seen each of these steps during training, but since it knows that these operations have been modified, it must refrain from skipping steps and instead focus on composing the tools. Below are the results for this task across the tested agents:

`GPT-4` 在训练过程中可能已见过上述每一步，但由于它知晓这些运算已被修改，因此必须避免跳过步骤，而应专注于工具的组合调用。以下是各测试模型在此任务上的表现结果：

![](images/benchmarking-agent-tool-use/img_014.png)GPT-4 does not reliably out-perform gpt-3.5 or claude-2.1 (or even the open-source `mistral-7b` model) on this task. Scale does not always translate to quality improvements if the task is out of distribution.

![](images/benchmarking-agent-tool-use/img_014.png)在此任务上，`GPT-4` 并不能稳定地超越 `gpt-3.5` 或 `claude-2.1`（甚至无法超越开源的 `mistral-7b` 模型）。当任务属于分布外（out-of-distribution）时，模型规模的扩大并不总能带来质量提升。

The multiverse math dataset tests two important characteristics of an LLM in isolation, without letting its factual knowledge interfere:

“多元宇宙数学”数据集在排除事实性知识干扰的前提下，独立检验大语言模型的两项关键能力：

- How well can it “reason” compositionally?  
- 它在多大程度上能够进行“组合式推理”？

- How well does it following instructions that may contradict the pre-trained knowledge?  
- 它在多大程度上能遵循可能与其预训练知识相冲突的指令？

It’s easy to [ace a test when you’ve memorized the answers](https://arxiv.org/abs/2309.08632?ref=blog.langchain.com). It’s harder when the answers contradict patterns you’re used to. Let's seen one of the many examples `GPT-4` fails: " [how much is 131,778 divided by 2?](https://smith.langchain.com/public/c92080f3-abae-440e-b528-ea901f614fa9/r/d3752681-4dcb-424f-801e-39cd587b1281?ref=blog.langchain.com)"

轻松“考满分”——只要你已死记硬背下标准答案（参见：[https://arxiv.org/abs/2309.08632?ref=blog.langchain.com](https://arxiv.org/abs/2309.08632?ref=blog.langchain.com)）。但当正确答案与你习以为常的模式相冲突时，问题就变难了。我们来看一个 `GPT-4` 屡屡出错的典型例子：“[131,778 除以 2 等于多少？](https://smith.langchain.com/public/c92080f3-abae-440e-b528-ea901f614fa9/r/d3752681-4dcb-424f-801e-39cd587b1281?ref=blog.langchain.com)”

![](images/benchmarking-agent-tool-use/img_015.png)GPT-4 using memorized answer (65,589) instead of the tool output (32,944.5)

![](images/benchmarking-agent-tool-use/img_015.png)GPT-4 使用了记忆中的答案（65,589），而非工具实际输出的结果（32,944.5）

While the `GPT-4` agent correctly calls the `divide()` tool, it ignores the output from the tool and instead uses what it thinks the answer should be. This happens despite the instructions to the agent stating that it should only rely on tool outputs for its answers.

尽管 `GPT-4` 智能体正确调用了 `divide()` 工具，却完全忽略了该工具返回的实际输出，转而使用其“自认为”正确的答案。这种情况的发生，与系统明确指示智能体“仅应依据工具输出作答”的指令直接相悖。

`mistral-7b-instruct-v0.1` , the OSS model fine-tuned by Anyscale for function calling, performs surprisingly well on this task. This dataset on average has _fewer_ questions requiring multiple tool invocations (compared to our other tasks). That the model fails on the simple typewriter tasks but performs reasonably well here highlights how fine-tuning only on 1-hop function calling can lead to unintended performance degradations.

`mistral-7b-instruct-v0.1` 是 Anyscale 针对函数调用任务微调的开源模型（OSS model），在本项任务中表现意外出色。该数据集平均而言需多次调用工具的问题数量 _更少_（相较于我们的其他评测任务）。该模型在简单的“打字机”（Typewriter）任务上失败，却在此处表现尚可，恰恰凸显出：若仅在单跳（1-hop）函数调用数据上进行微调，反而可能引发意料之外的性能下降。

## Additional Observations:

## 其他观察发现：

For these results, we communicated model _quality,_ but building an AI app also requires service reliability and stability. Despite the relatively small dataset size for these experiments and despite adding client-side rate limiting to our evaluation suite, we still ran into random-yet-frequent 5xx internal server errors from the popular model providers.

上述结果主要反映的是模型的 _质量_；但构建一个真正可用的 AI 应用，还需兼顾服务的可靠性与稳定性。尽管本次实验所用数据集规模相对较小，且我们在评测套件中已加入客户端限流机制，仍频繁遭遇主流大模型服务商返回的、随机却高频的 5xx 服务器内部错误。

We originally planned to benchmark Google's `gemini-pro` model, but because of the rate of internal server errors it rose during evaluations, we decided to leave it out of our results. The API also rejected multiple data points for the Typewriter and Multiverse Math datasets as being "unsafe" (for instance ["what is the result of 2 to the power of 3"](https://smith.langchain.com/public/da25fb81-44eb-4c64-a8c9-455bfca04ad9/r/7a7e40ef-6b29-4541-ae50-a69392ed7e25?ref=blog.langchain.com))

我们原本计划将 Google 的 `gemini-pro` 模型纳入基准测试，但由于其在评测过程中内部服务器错误率急剧升高，最终决定将其从本次结果中剔除。此外，该 API 还将“打字机”（Typewriter）和“多元宇宙数学”（Multiverse Math）数据集中的多个样本判定为“不安全”并予以拒绝（例如：[“2 的 3 次方结果是多少？”](https://smith.langchain.com/public/da25fb81-44eb-4c64-a8c9-455bfca04ad9/r/7a7e40ef-6b29-4541-ae50-a69392ed7e25?ref=blog.langchain.com)）

![](images/benchmarking-agent-tool-use/img_016.png)

![](images/benchmarking-agent-tool-use/img_016.png)

Safety filters can be helpful, but if the false positive rate is too high, it can impact your service quality.

安全过滤器固然有益，但若误报率（false positive rate）过高，则会直接影响您的服务质量。

Finally, we have shown a clear need for better open-source alternatives for tool use. The open-source community is rapidly developing better function calling models, and we expect more competitive options to be broadly available soon. To test your function calling model on these benchmarks, follow the instructions [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com), or if you'd like us to run a specific model, [open an issue in the GitHub repo.](https://github.com/langchain-ai/langchain-benchmarks/issues?ref=blog.langchain.com) We'd love for these results to change!

最后，我们清晰地揭示了当前对更优开源工具调用方案的迫切需求。开源社区正快速推进更强大的函数调用模型研发，我们预计更具竞争力的开源选项将在不久后广泛落地。如需在本系列基准测试中评估您自己的函数调用模型，请参照此处指南：[https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/intro.html?ref=blog.langchain.com)；若您希望我们为您运行某个特定模型，欢迎 [在 GitHub 仓库中提交 Issue](https://github.com/langchain-ai/langchain-benchmarks/issues?ref=blog.langchain.com)。我们热切期待这些评测结果早日被刷新！

## Conclusion

## 结论

Thanks for reading! We’d love to hear your feedback on what other models and architectures you’d like to see tested on these environments, and what other tests would help make _your_ life easier when trying to use agents in your app.

感谢阅读！我们非常期待听到您的反馈：您希望在这些环境中测试哪些其他模型和架构？还有哪些测试能帮助您更轻松地在应用中使用智能体（agents）？

You can check out our previous findings on [document Q&A](https://blog.langchain.com/public-langsmith-benchmarks/), [extraction](https://blog.langchain.com/extraction-benchmarking/), [Q&A over semi-structured tables](https://blog.langchain.com/benchmarking-rag-on-tables/), and [multimodal reasoning abilities](https://blog.langchain.com/multi-modal-rag-template/) in the linked posts.

您可通过以下链接查阅我们此前的研究成果：[文档问答（document Q&A）](https://blog.langchain.com/public-langsmith-benchmarks/)、[信息抽取（extraction）](https://blog.langchain.com/extraction-benchmarking/)、[半结构化表格上的问答（Q&A over semi-structured tables）](https://blog.langchain.com/benchmarking-rag-on-tables/)，以及[多模态推理能力（multimodal reasoning abilities）](https://blog.langchain.com/multi-modal-rag-template/)。

You can also see how to reproduce these results yourself by running the notebooks in the [`langchain-benchmarks`](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.dev) package.

您还可通过运行 [`langchain-benchmarks`](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.dev) 代码包中的 Jupyter Notebook，自行复现上述实验结果。

Thanks again!

再次感谢！

![](images/benchmarking-agent-tool-use/img_017.png)