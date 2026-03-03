---
title: "SCIPE - Systematic Chain Improvement and Problem Evaluation"
source: "LangChain Blog"
url: "https://blog.langchain.com/scipe-systematic-chain-improvement-and-problem-evaluation/"
date: "2024-11-07"
scraped_at: "2026-03-03T07:50:00.967912912+00:00"
language: "en-zh"
translated: true
---

**_Editor's Note: we're EXTREMELY excited to highlight this research from Ankush Garg and Shreya Shankar from Berkeley. At LangChain, two of the biggest problems we think about are evals and agents, and this research sits right at the intersection. You can try it out today in their Python package._**

**_编者按：我们非常激动地向大家推介来自加州大学伯克利分校的 Ankush Garg 与 Shreya Shankar 的这项研究。在 LangChain，我们最关注的两大挑战是评估（evals）与智能体（agents），而本研究恰恰处于这两者的交汇点。您今天即可通过他们的 Python 包亲自体验该工具。_**

**_TLDR: It helps you find underperforming nodes in LLM chains._**

**_一句话概括：它可帮助您定位大语言模型（LLM）链中表现欠佳的节点。_**

## The problem it solves

## 它所解决的问题

Building LLM-powered applications is challenging, and the complexity multiplies with LLM chains that can have multiple LLM calls per query.

构建基于大语言模型（LLM）的应用本身已颇具挑战性；而当应用采用 LLM 链（即单次查询需调用多个 LLM 节点）时，其复杂度更呈倍数增长。

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_001.jpg)

While assessing the final outputs is critical in ensuring AI applications are working as designed, assessing intermediate outputs is largely ignored. This is most likely due to resource constraints applications developers may have.

尽管对最终输出进行评估对于确保 AI 应用按预期运行至关重要，但对中间输出的评估却长期被忽视——这很可能源于应用开发者所面临的资源限制（如计算成本、时间与人力）。

A single node in an LLM chain can cause the entire chain to malfunction, causing a ripple effect, making it difficult to debug and fix.

LLM 链中的单个节点一旦出错，便可能引发整条链的故障，并产生连锁反应，从而极大增加调试与修复的难度。

In this post, we introduce [SCIPE](https://github.com/garg-ankush/scipe/tree/main?ref=blog.langchain.com), a lightweight, yet powerful tool that conducts error analysis on LLM chains. This tool can benefit anyone creating applications that rely on LLMs for making decisions and carrying out tasks.

本文将介绍 [SCIPE](https://github.com/garg-ankush/scipe/tree/main?ref=blog.langchain.com) ——一款轻量却功能强大的工具，专为 LLM 链开展错误分析而设计。任何依赖大语言模型进行决策或执行任务的应用开发者，均可从中获益。

SCIPE works by analyzing inputs and outputs for each node in the LLM chain and identifying the most important node to fix–the node that, if accuracy is improved, will _most_ improve the final or downstream output accuracy.

SCIPE 的工作原理是：逐节点分析 LLM 链中各环节的输入与输出，并识别出最亟需修复的关键节点——即，若提升该节点的准确性，将能最大程度地提升最终输出或下游输出的准确率。

You can try out SCIPE in our [Colab Notebook](https://colab.research.google.com/drive/1INuL-6cQ-R9z4Clx9L8416ykv6XsRWwg?ref=blog.langchain.com#scrollTo=33z20rSze8CK).

您可在我们的 [Colab 笔记本](https://colab.research.google.com/drive/1INuL-6cQ-R9z4Clx9L8416ykv6XsRWwg?ref=blog.langchain.com#scrollTo=33z20rSze8CK) 中立即试用 SCIPE。

## Technical Details - How it works

## 技术细节——工作原理

SCIPE works by analyzing the failure probabilities of nodes in your application graph to identify the most impactful source of failures. Importantly, it requires _no labeled data_ or ground truth examples to perform this analysis. The core problem it addresses is:

SCIPE 通过分析应用程序图中各节点的故障概率，识别对系统整体影响最大的故障源头。重要的是，该方法在执行此类分析时 _无需标注数据_ 或真实标签样本。它所解决的核心问题是：

**What node’s failures have the biggest impact on the most downstream node’s failures?**

**哪个节点的故障对最下游节点的故障影响最大？**

For each node in the application graph, SCIPE models two distinct types of failures that can occur:

对于应用程序图中的每个节点，SCIPE 建模两类截然不同的故障情形：

- **Independent Failures**: These occur when the node itself (or the LLM processing it) may be the primary cause of the failure (i.e., the node fails even though its upstream dependencies are correct).

- **独立故障**：指节点自身（或处理该节点的 LLM）成为故障主因的情形（即：尽管其上游依赖项均正常，该节点仍发生故障）。

- **Dependent Failures**: These happen when a node fails while one or more of its upstream dependencies have failed.

- **依赖故障**：指当一个或多个上游依赖项已发生故障时，该节点随之发生的故障。

To detect these failures without requiring ground truth data, SCIPE uses an LLM as a judge to evaluate each node in the graph.

为在不依赖真实标签数据的前提下检测上述故障，SCIPE 利用大语言模型（LLM）作为“裁判”，对图中每个节点进行评估。

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_002.jpg)

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_002.jpg)

This evaluation process creates a pass/fail score for each node, for each of its input and output pairs. The LLM judge then determines whether each node's output is valid given its input, generating a comprehensive dataset of node evaluations across multiple samples. This dataset is used to calculate conditional and independent failure probabilities to find problematic nodes.

该评估过程为每个节点的每组输入–输出对生成一个“通过/失败”评分。LLM 裁判据此判断：在给定输入的前提下，该节点的输出是否有效；由此，在多个样本上构建出一份全面的节点评估数据集。该数据集用于计算条件故障概率与独立故障概率，从而定位存在问题的节点。

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_003.jpg)

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_003.jpg)

Starting from the most downstream node, SCIPE computes conditional failure probabilities to understand how each node's failures relate to its dependencies' failures. Conditional failure probability is the node failure rate while its dependency (parent node) is also failing.

SCIPE 从最下游节点出发，逐级向上计算条件故障概率，以厘清各节点故障与其依赖项（上游节点）故障之间的关联关系。所谓条件故障概率，是指当某节点的依赖项（父节点）也处于故障状态时，该节点自身的故障发生率。

If a node has no dependencies or its independent failure probability is highest among its local neighborhood, it's identified as a potential root cause, ending the analysis. Otherwise, the analysis continues recursively traversing upstream through the graph until the true root cause is identified—the node whose failures are most likely independent (originating from itself rather than being propagated from its dependencies).

如果一个节点没有依赖项，或者其独立失效概率在其局部邻域中最高，则该节点被识别为潜在根因，分析随即终止；否则，分析将递归地沿图向上游遍历，直至定位真正的根因——即其失效最可能源于自身（而非由其依赖项传播而来）的节点。

To illustrate, here's high-level pseudocode on how SCIPE finds problematic nodes.

为便于理解，以下为 SCIPE 定位问题节点的高层级伪代码：

```
function find_root_cause(node, data, graph):
    calculate probabilities for node (overall, independent, and dependent)
    if node has no dependencies or independent failure probability is highest:
        mark node as root cause
        return node
    else:
        find dependency with highest conditional failure probability
        recursively call find_root_cause on that dependency

function find_problematic_node(data, graph):
    identify the most downstream node in the graph
    root_cause = find_root_cause(downstream_node, data, graph)
    calculate probabilities for all nodes in the graph
    construct debug trace from downstream node to root cause
    return EvaluationResult(root_cause, debug_path, node_results)
```

```
function find_root_cause(node, data, graph):
    计算该节点的各项概率（整体失效概率、独立失效概率、依赖性失效概率）
    如果该节点无依赖项，或其独立失效概率最高：
        将该节点标记为根因
        返回该节点
    否则：
        找出条件失效概率最高的依赖项
        递归调用 find_root_cause 处理该依赖项

function find_problematic_node(data, graph):
    在图中识别最下游的节点
    root_cause = find_root_cause(downstream_node, data, graph)
    计算图中所有节点的概率
    构建从下游节点到根因节点的调试追踪路径
    返回 EvaluationResult(root_cause, debug_path, node_results)
```

## Getting Started: Prerequisites

## 入门指南：前提条件

If you are using SCIPE on your own application, you’ll need the following:

若您计划在自己的应用中使用 SCIPE，则需满足以下前提条件：

### Graph

### 图结构

A compiled graph from [Langgraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com). We need to access the internal graph structure to run SCIPE.

一个由 [Langgraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 编译生成的图。我们需要访问其内部图结构，才能运行 SCIPE。

### Application Responses

### 应用响应数据

We need prompts and LLM responses for all the nodes in our application as a dataframe. We need this to run validations on and to identify nodes that fail at the highest rate.

我们需要以 DataFrame 格式提供应用中所有节点对应的提示词（prompts）和大语言模型（LLM）响应。该数据用于执行各项校验，并识别失效率最高的节点。

Each row of the application responses dataframe is a single user query that cascades through the entire LLM Graph. Here are a couple of example rows of the applications' input/output responses dataframe.

应用响应数据框（dataframe）中的每一行代表一个用户查询，该查询会贯穿整个大语言模型（LLM）图（LLM Graph）。以下是应用程序输入/输出响应数据框的若干示例行。

![](images/scipe-systematic-chain-improvement-and-problem-evaluation/img_004.jpg)

In this example, we have two rows of the dataframe with 3 LLM calls, each responsible for a single step.

本示例中，数据框包含两行，每行对应 3 次 LLM 调用，每次调用分别负责一个独立步骤：

- Redact PII  
- Extract useful information  
- Summarize the chat  

- 脱敏处理个人身份信息（PII）  
- 提取有用信息  
- 汇总聊天内容  

### Configs

### 配置项

- PATH\_TO\_SAVE\_VALIDATIONS - Path for saving the LLM as a judge responses  
- MODEL\_NAME - Model to be used here. We support all the models supported by [LiteLLM](https://docs.litellm.ai/docs/providers?ref=blog.langchain.com)  
- node\_input\_output\_mappings - This creates the relationship between the application graph and the application responses.  

- `PATH_TO_SAVE_VALIDATIONS` —— 用于保存“LLM 作为裁判”（LLM-as-a-judge）评估结果的路径  
- `MODEL_NAME` —— 此处所用模型名称。我们支持 [LiteLLM](https://docs.litellm.ai/docs/providers?ref=blog.langchain.com) 所支持的全部模型  
- `node_input_output_mappings` —— 建立应用程序图（application graph）与应用响应（application responses）之间的映射关系  

Once we have application responses, a compiled graph, and have set up our configuration file, we’re ready to run validations and find the nodes with a high failure rate.

一旦我们获得了应用响应、已编译的图（compiled graph），并完成了配置文件的设置，即可运行验证流程，并识别出故障率较高的节点。

## Example: How to use SCIPE

## 示例：如何使用 SCIPE

SCIPE uses a compiled StateGraph from LangGraph , which we’ll convert into a lightweight format by using convert\_edges\_to\_dag function.

SCIPE 使用来自 LangGraph 的已编译 `StateGraph`，我们将通过 `convert_edges_to_dag` 函数将其转换为轻量级格式。

```
from scipe.middleware import convert_edges_to_dag
```

# Convert a compiled langgraph into a lightweight dag  
# 将已编译的 LangGraph 转换为轻量级有向无环图（DAG）

```  
converted_graph = convert_edges_to_dag(graph=graph)  
```  

```
Define configs for the evaluator.  

定义评估器的配置。
```  

```  
config = {  
 'PATH_TO_SAVE_VALIDATIONS': 'validations.csv',  
 'MODEL_NAME': 'claude-3-5-sonnet-20240620',  
 # Input and Output mappings for SCIPE  
 # SCIPE 的输入与输出映射  
 'node_input_output_mappings': {  
    'pii_agent': ['pii_agent_input', 'pii_agent_output'],  
    'extractor': ['extractor_input', 'extractor_output'],  
    'Summarizer': ['summarizer_input', 'summarizer_output']  
  }  
}  
```  

We can then import `LLMEvaluator` from `scipe` and instantiate an object by passing in `config`, `responses` (application responses), and the graph we converted.  
接下来，我们可以从 `scipe` 导入 `LLMEvaluator`，并通过传入 `config`、`responses`（应用程序响应）以及我们已转换的图来实例化该对象。

```  
from scipe import LLMEvaluator  

evaluator = LLMEvaluator(  
  config=config,  
  responses=application_responses, # DataFrame input/output pairs  
  graph=converted_graph # Converted Langgraph  
)  
```  

`LLMEvaluator` simplifies managing/running LLM-based evaluations on the application responses, and then finding problematic nodes in the application graph. First, it constructs input and output pairs from application responses based on the `node_input_output_mappings` in configs. Then, it runs validations using an LLM as Judge and saves the validations to the `PATH_TO_SAVE_VALIDATIONS` in the config.  
`LLMEvaluator` 简化了在应用程序响应上执行基于大语言模型（LLM）的评估流程，并进一步识别应用图中存在问题的节点。首先，它依据配置中的 `node_input_output_mappings`，从应用程序响应中构建输入–输出配对；随后，它调用一个作为“裁判”（Judge）的 LLM 执行各项验证，并将验证结果保存至配置中指定的 `PATH_TO_SAVE_VALIDATIONS` 路径。

```  
results = evaluator.run_validation(  
        special_instructions=None  
).find_problematic_node()  
```  

Note: The `run_validation` method can take in `special_instructions`, that we might want to pass to the LLM judge. These instructions will be appended to the LLM judge prompt that SCIPE uses internally.  
注意：`run_validation` 方法可接收 `special_instructions` 参数，该参数将传递给作为裁判的 LLM；这些指令会被追加至 SCIPE 内部所使用的 LLM 裁判提示词（prompt）末尾。

The `find_problematic_node()` method traverses through the graph to figure out which node has the highest failure rate. Once it finds the problematic node, the algorithm stops and returns the result.  
`find_problematic_node()` 方法遍历整个图，以识别失败率最高的节点；一旦定位到问题节点，算法即刻终止并返回该结果。

The output is an EvaluationResult which contains the root cause, the debug path (from terminal node backwards), and the failure rate for each node.

输出为一个 `EvaluationResult`，其中包含根本原因、调试路径（从终端节点反向追溯）以及每个节点的失败率。

You can look at the results of the algorithm by converting the results to JSON.

您可以通过将结果转换为 JSON 格式来查看该算法的运行结果。

```
results.to_json()
```

```
results.to_json()
```

```
Output:

{'root_cause': 'pii_agent',
 'debug_path': ['summarizer', 'extractor', 'pii_agent'],
 'node_results': {'summarizer': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 0.0,
   'conditional_failure_probabilities': {'extractor': 1.0},
   'dependencies': ['extractor'],
   'is_root_cause': False},
  'extractor': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 0.0,
   'conditional_failure_probabilities': {'pii_agent': 1.0},
   'dependencies': ['pii_agent'],
   'is_root_cause': False},
  'pii_agent': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 1.0,
   'conditional_failure_probabilities': {},
   'dependencies': [],
   'is_root_cause': True}}}
```

```
输出：

{'root_cause': 'pii_agent',
 'debug_path': ['summarizer', 'extractor', 'pii_agent'],
 'node_results': {'summarizer': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 0.0,
   'conditional_failure_probabilities': {'extractor': 1.0},
   'dependencies': ['extractor'],
   'is_root_cause': False},
  'extractor': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 0.0,
   'conditional_failure_probabilities': {'pii_agent': 1.0},
   'dependencies': ['pii_agent'],
   'is_root_cause': False},
  'pii_agent': {'overall_failure_probability': 1.0,
   'independent_failure_probability': 1.0,
   'conditional_failure_probabilities': {},
   'dependencies': [],
   'is_root_cause': True}}}
```

Application developers can use the failure probabilities of problematic nodes up the LLM chain to further explore what’s causing this node to fail and what can be done to fix it. The results output here tell us that the pii\_agent node is the root cause, failing independently at a higher rate compared to other nodes and should be fixed/improved upon.

应用程序开发者可利用 LLM 链中各问题节点的失败概率，进一步探究导致该节点失败的具体原因，并确定可行的修复或优化方案。此处输出的结果表明，`pii_agent` 节点是根本原因——其独立失败概率显著高于其他节点，因此应作为首要对象进行修复或改进。

## Conclusion

## 结论

In conclusion, SCIPE analyzes independent and dependent failure probabilities to identify the most impactful problematic node in the system. This helps developers pinpoint and fix issues in their LLM-based application graph, improving overall performance and reliability.

综上所述，SCIPE 通过分析各节点的独立失败概率与依赖性失败概率，识别出系统中影响最大的问题节点。这有助于开发者准确定位并修复基于大语言模型（LLM）的应用图谱中的缺陷，从而提升整体性能与可靠性。

We're actively developing SCIPE and would love to hear from you! If you're interested in participating in our user study, have feedback on the tool, or want to stay updated on future developments, please email us at ankush-garg@berkeley.edu.

我们正在积极开发 SCIPE，非常期待您的反馈！如果您有兴趣参与我们的用户研究、对本工具提出建议，或希望及时了解后续进展，请发送邮件至 ankush-garg@berkeley.edu。