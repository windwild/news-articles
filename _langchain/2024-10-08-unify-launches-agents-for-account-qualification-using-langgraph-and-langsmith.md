---
title: "Unify Launches Agents for Account Qualification using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/"
date: "2024-10-08"
scraped_at: "2026-03-03T07:52:02.076809656+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_**This is a guest blog post written by Sam and Connor at Unify.**_  
_**这是一篇由 Unify 公司的 Sam 和 Connor 撰写的客座博客文章。**_

[**_Unify_**](https://www.unifygtm.com/?ref=blog.langchain.com) **_is reinventing how go-to-market teams work using generative AI. As part of this transformation, they are launching a new agents feature today (powered by LangGraph and LangSmith). We had the pleasure of learning more about the engineering journey taken to launch this feature, and thought it would be a great story to share._**  
[**_Unify_**](https://www.unifygtm.com/?ref=blog.langchain.com) **正借助生成式 AI 重塑市场进入（Go-to-Market）团队的工作方式。作为此次转型的一部分，他们今天正式推出一项全新的“智能体（Agents）”功能（该功能由 LangGraph 和 LangSmith 驱动）。我们很荣幸深入了解了这一功能从构想到落地的工程实践历程，认为这是一个非常值得分享的故事。**

Agents are a new feature we’re launching alongside a broader automation suite we call Plays. Agents are effectively research tools—they can research companies or people by searching the web, visiting websites, navigating between pages, and performing standard LLM synthesis and reasoning to answer questions.  
“智能体（Agents）”是我们与一套更广泛的自动化工具集——我们称之为 “Plays”——同步推出的全新功能。本质上，智能体是一类研究型工具：它们可通过网络搜索、访问网站、在网页间跳转，并结合大语言模型（LLM）的标准合成与推理能力，对公司或个人开展深度调研并回答问题。

For the initial launch, the target use case of Agents is _account qualification_, which is the task of deciding whether a company fits your ideal customer profile to sell to or not. Given a company and a set of questions and criteria, the agent performs some research and decides whether they are “qualified” or not.  
在本次首发版本中，智能体的核心应用场景是**客户账户资质评估（account qualification）**——即判断某家公司是否符合您的理想客户画像（ICP），从而决定是否值得销售跟进。给定一家目标公司，以及一组预设的问题与评估标准，智能体将自主开展调研，并最终判定该公司是否“具备资质（qualified）”。

/0:35

1×

## Example Research Questions

## 典型调研问题示例

Here are some examples of qualification questions different users might ask the agent to research and qualify based on:  
以下是一些不同用户可能要求智能体调研并据此完成资质评估的典型问题示例：

- **An HR software company ⇒**  
  - **一家人力资源软件公司 ⇒**  
  - Are there any HR job postings on this company’s careers page?  
    - 该公司招聘页面上是否存在人力资源相关职位空缺？  
  - Do any of the job postings for HR roles mention a competitor’s software?  
    - 这些人力资源岗位的招聘启事中，是否提到了某竞品软件？

- **An AI infra company ⇒**  
  - **一家人工智能基础设施公司 ⇒**  
  - Does this company mention using LLMs anywhere on their website?  
    - 该公司官网任何位置是否提及使用大语言模型（LLMs）？  
  - Are any of the company’s open ML roles looking for experience with transformer models for language or audio?  
    - 该公司当前开放的机器学习相关岗位中，是否有职位明确要求具备语言或音频领域 Transformer 模型的应用经验？  
  - Does the website or any job postings mention open source LLMs?  
    - 该公司官网或任一招聘启事中，是否提及开源大语言模型（open source LLMs）？

## Agent v0

## 智能体 v0 版本

We used LangGraph as the framework for the agent state machine and LangSmith as the experimentation and tracing framework. Our starting point was a trivial agent that was about as barebones as you can imagine (not even a prompt):  
我们选用 LangGraph 作为智能体状态机的开发框架，LangSmith 则用于实验迭代与执行链路追踪。我们的起点是一个极简版本的智能体——其精简程度几乎超乎想象（甚至尚未定义任何提示词）：

![](images/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/img_001.png)

![](images/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/img_001.png)

这一方法在许多简单任务上实际表现尚可，但也常出错，且输出结果不一致。此外，分析其回答背后的推理过程也十分困难。

## Agent v1

## Agent v1（第一代智能体）

我们的下一轮迭代是构建一个更复杂的智能体结构，包含一个 _初始规划_（initial plan）步骤和一个 _反思_（reflect）步骤。该流程图如下所示：

![](images/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/img_002.png)

![](images/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/img_002.png)

第一步是利用大语言模型生成执行计划。在我们的测试中，主流模型（如 `gpt-4o`）若无非常具体的提示词引导，往往难以生成全面、周详的计划。此阶段我们获得的最佳效果来自 OpenAI 的 `o1-preview` 模型。`o1` 生成的计划尤为突出，其他模型难以复现，其特点包括：

- 极其详尽的分步操作指令；  
- 准确且实用的潜在风险与易犯错误提示；  
- 对用户问题意图的主动拓展与澄清，即使原始提问表述模糊或不完整。

`o1` 的主要缺点在于响应速度慢：单次响应可能耗时长达 30–45 秒，显著拖慢整个智能体的运行节奏。目前，我们正积极实验如何借助更快、更轻量的模型，复现同等质量的规划能力。

完成规划后，智能体即进入“反思”步骤与工具调用之间的循环。在此环节，我们尝试了多种模型。GPT-4o 和 Claude 3.5 Sonnet 等“主流”模型表现较为理想。而用于反思环节的模型最关键的一项能力，是能诚实地识别自身当前 *尚未掌握* 的信息，从而恰当地选择下一步行动。

## Agent v2

## Agent v2（第二代智能体）

We’re still using the plan-reflect-tools state machine structure for our latest iteration. The areas we’ve been most actively tuning and experimenting with are speed and user experience.

我们最新一轮迭代仍在沿用 plan-reflect-tools 状态机结构。目前我们重点调优和实验的方向集中在**运行速度**与**用户体验**两大方面。

### Speed

### 速度

The main downside of this architecture (especially when using heavier planning models like o1-preview) is that it increases the overall runtime substantially. We’ve found ways to deal with this by both speeding up the agent loop and by revising the UI/UX around using agents in our product.

该架构的主要缺点（尤其是使用 o1-preview 等计算开销较大的规划模型时）在于显著延长了整体运行时间。我们通过两种方式应对这一挑战：一是加速 agent 的执行循环，二是重构产品中与 agent 交互相关的用户界面与体验设计。

One of the biggest speed boosts we achieved came from parallelizing tool calls. For example, we allowed the model to scrape multiple web pages at a time. This helps a lot since each webpage can take several seconds to load. It works well intuitively because humans often do the same thing—quickly opening multiple Google results at once in new tabs.

其中一项最显著的提速措施是并行化工具调用。例如，我们允许模型同时抓取多个网页。这带来了巨大收益，因为单个网页加载往往需要数秒时间。该设计也高度符合人类直觉——人们通常也会在新标签页中一次性快速打开多个 Google 搜索结果。

### User Experience

### 用户体验

There’s ultimately a limit on how fast agents can be made without sacrificing accuracy and capabilities. We instead decided to rework the UI for building and testing agents in our product. The initial designs showed a spinner to the user while the agent ran (which gets pretty painful after a few seconds). Our updated interface instead shows the actions and decision-making process of the agent as it runs in real time. (See video at the top of this article)

归根结底，若不以牺牲准确性与功能完备性为代价，agent 的运行速度存在天然上限。因此，我们转而聚焦于重构产品中用于构建与测试 agent 的用户界面。早期设计方案在 agent 运行期间仅向用户展示一个旋转加载图标（spinner），但几秒钟后这种体验便令人倍感煎熬。而新版界面则实时呈现 agent 的每一步操作及其决策过程。（参见本文顶部的演示视频）

Pulling this off also required some engineering changes. We originally had a simple prediction endpoint that would hold a request open while the agent ran. To deal with longer agent runtimes and accomplish the new step-by-step UI, we converted this to an “async” endpoint that starts the agent execution and returns an ID that can be used to poll for progress. We added hooks into the agent graph and tools to “log” progress to our database. The frontend then polls for updates and displays newly completed steps as they are executed until the final result is obtained.

实现这一改进还需配套的工程调整。最初我们仅提供一个简单的预测接口（prediction endpoint），该接口会保持 HTTP 请求处于挂起状态，直至 agent 执行完成。为应对更长的 agent 运行时间，并支撑全新的分步式 UI，我们将该接口改造为“异步”（async）接口：它启动 agent 执行后立即返回一个唯一 ID，供前端轮询进度使用。我们还在 agent 图（agent graph）及各工具中嵌入了钩子（hooks），用于将执行进度“记录”到数据库中。前端则持续轮询更新，并在每一步执行完成后即时渲染对应内容，直至最终结果生成。

## Final Learnings

## 最终经验总结

### Embrace Experimentation

### 拥抱实验精神

Working with agents definitely required figuring new things out. The research space is super green at the moment and there’s no definitive SOTA agent architectures yet in the way we think of SOTA in other domains like vision or audio.

开发 agent 应用无疑要求我们不断探索、试错、学习新知。当前该研究领域仍处于非常早期的阶段，尚无公认的“最优（SOTA）”agent 架构——这与计算机视觉或语音等成熟领域中对 SOTA 的共识截然不同。

Given this, we have to lean heavily into good old fashioned ML experimentation and evaluation cycles to make substantive progress.

鉴于此，我们必须大力依靠传统而扎实的机器学习实验与评估循环，才能取得实质性进展。

💡

💡

Constructing an extensive and representative set of test cases, labeling them (oftentimes using the agent itself for the first pass and then correcting the labels), then running experiments is critical.

构建一套规模庞大且具有代表性的测试用例集，并为其打标签（通常先由智能体自身完成初版标注，再人工校正），随后开展实验——这一过程至关重要。

We’ve been really happy with LangSmith for this (we were also already using LangSmith for Smart Snippets, another LLM-powered feature in Unify). In particular, versioned datasets are exactly what we were hoping they would be. Running and comparing experiments is straightforward, and the tracing is also excellent. We’re able to run a new agent version on hundreds of examples and quickly compare it against previous versions on a given dataset with very little in house ML infra work.

在这一环节中，LangSmith 给我们带来了极大的满意度（此前我们已在 Unify 的另一项大语言模型驱动功能“Smart Snippets”中使用 LangSmith）。尤其是其版本化数据集功能，完全契合我们的期待。运行和对比实验操作简便，追踪（tracing）能力也极为出色。我们仅需极少的内部机器学习基础设施投入，即可让新版本智能体在数百个样例上运行，并快速将其与历史版本在指定数据集上的表现进行比对。

### Think of agents as summer interns

### 将智能体视作暑期实习生

💡

💡

Asking “How would it work if this was a human being instead of an agent?” has been a useful exercise for us when developing the UI/UX around agents.

在设计围绕智能体的用户界面与用户体验时，“如果这不是一个智能体，而是一位人类，事情会如何展开？”这一设问对我们而言一直是一项极富启发性的思考练习。

For example, many tools with agent building functionality have a UX that revolves around writing a prompt, running it on some test cases, waiting for a black box agent to run, inspecting the results, and then guessing at how to modify the prompt to try and improve it.

例如，许多具备智能体构建能力的工具，其用户体验流程往往围绕如下步骤展开：撰写提示词 → 在若干测试用例上运行 → 等待一个“黑箱”智能体执行 → 检查输出结果 → 再凭猜测调整提示词以期提升效果。

Now imagine the agent was instead a summer intern prone to oversights and mistakes. If you give the intern a task and they come back with the wrong answer, would you simply try to revise your instructions and then send them off on their own again? No — you would ask them to show how they accomplished the task so that you can identify what they’re doing wrong. Once you spot their mistake, it’s much easier to adjust your instructions to prevent the mistake from happening again.

现在，试想这位智能体其实是一位容易疏忽、常犯错误的暑期实习生。如果你交给他一项任务，他却给出了错误答案，你会仅仅修改一下指令，就再次放任他独自完成任务吗？不会——你更可能要求他展示完成任务的具体过程，以便你准确定位其失误所在；一旦发现错误根源，你便能更有针对性地优化指导方式，从而避免同类错误重演。

Bringing it back to agents, the UX we ended up at is one where users can clearly see what the agent is doing step-by-step to analyze its decision-making and figure out what additional guidance they need to provide.

回归到智能体本身，我们最终确立的用户体验正是：用户能够清晰地逐步观察智能体的行为过程，借此分析其决策逻辑，并判断自己还需提供哪些额外指导。

### o1-preview is a solid model, but very slow

### o1-preview 是一款稳健的模型，但速度极慢

Despite its slowness, OpenAI’s o1-preview model is a step up from other models we’ve experimented with for plan formation. It has a tendency to be verbose, but that verbosity is often valuable content rather than just filler or boilerplate. It consistently returns results that we aren’t able to reproduce with other models (yet), but with a painfully long wait. We were able to work around the slowness with UX improvements, but as we scale this system o1 will likely become a bottleneck.

尽管速度缓慢，OpenAI 的 o1-preview 模型在规划生成任务上仍明显优于我们此前测试过的其他模型。该模型倾向于输出冗长内容，但这种冗长往往承载着实质性信息，而非空洞的填充或模板化表述。它持续产出一些我们（目前）尚无法通过其他模型复现的结果——代价却是令人痛苦的漫长等待。我们已通过用户体验（UX）优化在一定程度上缓解了这一延迟问题；但随着系统规模扩大，o1 很可能成为性能瓶颈。

### Empower end users to experiment

### 赋能终端用户自主实验

The biggest challenge we see users face with LLM-powered features is figuring out how to iterate. Many users have little exposure to LLMs or prompting strategies. As a user, if I hit “generate” and the results are only partially right, what do I do next? How do I iterate in a way that makes progress without regressions in the examples that were already correct?

LLM 驱动功能带给用户的最大挑战，在于如何有效开展迭代。许多用户对大语言模型（LLM）本身或提示工程策略缺乏实际接触与经验。作为用户，当我点击“生成”后，结果仅部分正确，下一步该怎么做？我又该如何迭代，才能在推进改进的同时，避免破坏那些原本就已正确的示例？

We see the intersection of UX and LLMs as ripe for disruption. While we’re excited about the UI we’ve developed so far, making it easier for users to experiment and correct agents’ mistakes will be one of our biggest focuses going forward.

我们认为，用户体验（UX）与大语言模型（LLM）的交汇领域正亟待革新。尽管我们对目前已开发的用户界面（UI）充满期待，但未来一段时间内，我们的核心重点之一将是：降低用户自主实验与修正智能体错误的门槛。
&#123;% endraw %}
