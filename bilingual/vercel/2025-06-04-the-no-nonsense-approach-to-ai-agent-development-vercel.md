---
title: "The no-nonsense approach to AI agent development - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-no-nonsense-approach-to-ai-agent-development"
date: "2025-06-04"
scraped_at: "2026-03-02T09:32:43.362206049+00:00"
language: "en-zh"
translated: true
description: "Learn how to build reliable, domain-specific AI agents by simulating tasks manually, structuring logic with code, and optimizing with real-world feedback. A clear, hands-on approach to practical autom..."
---

Jun 4, 2025

2025 年 6 月 4 日

AI agents are software systems that take over tasks made up of manual, multi-step processes. These often require context, judgment, and adaptation, making them difficult to automate with simple rule-based code.

AI 智能体（AI agents）是能够接管由人工执行、多步骤构成的任务的软件系统。这类任务通常需要上下文理解、判断力与动态适应能力，因此难以通过简单的基于规则的代码实现自动化。

While traditional automation is possible, it usually means hardcoding endless edge cases. Agents offer a more flexible approach. They use context to decide what to do next, reducing manual effort on tedious steps while keeping a review process in place for important decisions.

尽管传统自动化是可行的，但它往往意味着要硬编码无穷无尽的边界情况。而智能体则提供了一种更灵活的方案：它们利用上下文来决定下一步行动，在减少繁琐步骤人工干预的同时，仍为关键决策保留人工审核环节。

The most effective AI agents are narrow, tightly scoped, and domain-specific.

最有效的 AI 智能体往往是功能聚焦、范围明确且面向特定领域的。

Here's how to approach building one.

以下是构建此类智能体的方法。

## Step 1: Prototype the agent by hand

## 第一步：手动模拟智能体原型

Start by simulating the agent manually, before writing any code.

在编写任何代码之前，先手动模拟该智能体的行为。

Understand the task the way a person would approach it, step by step. Use real inputs, whether they’re screenshots, API responses, or messy CSV data. Feed those into an LLM manually and guide it through the process with prompts that mirror the actual workflow.

像人类一样，逐步理解这项任务。使用真实输入——无论是截图、API 响应，还是杂乱的 CSV 数据。将这些输入手动送入大语言模型（LLM），并通过贴合实际工作流的提示词引导其完成整个过程。

As you go, perform any resulting actions yourself. Pay attention to which parts feel repetitive or mechanical. These are strong candidates for automation later.

过程中，所有由此产生的操作均由你亲自执行。留意哪些环节显得重复或机械——这些正是后续自动化改造的理想候选对象。

Expect early results to be rough. When we started building [v0.dev](https://v0.dev/) in 2023, LLMs struggled to generate reliable HTML. The breakthrough wasn’t from better models, but from narrowing the scope and using structured inputs with Tailwind.

初期结果难免粗糙。2023 年我们启动 [v0.dev](https://v0.dev/) 的开发时，大语言模型尚难以生成稳定可靠的 HTML。真正的突破并非来自更强大的模型，而是源于任务范围的精准收窄，以及结合 Tailwind 使用结构化输入。

If the model consistently fails to make progress, even with adjustments, the task may not be a good fit for an agent. But if it works, or even comes close, it’s worth continuing.

如果模型即使经过多次调整仍持续无法取得进展，那么该任务可能并不适合交由智能体（agent）来处理；但只要它能够成功运行，甚至只是接近成功，就值得继续推进。

## Step 2: Automate the loop

## 第二步：将循环流程自动化

Once your manual simulation shows that the task is viable, begin writing code. This is where you build the skeleton of your agent.

当你的手动模拟验证了该任务具备可行性后，即可开始编写代码——这一步正是构建智能体骨架的过程。

Start by automating how it collects inputs. Use APIs, scrapers, screenshots, or anything else that fits the problem, then model the agent’s process as a loop or a simple state machine. Gather input, perform deterministic computation where possible, call the model when logic or judgment is needed, evaluate the result, and decide whether to continue or exit.

首先自动化输入采集环节：可采用 API、网络爬虫、截图等方式，视具体问题而定；随后将智能体的执行过程建模为一个循环或简单的状态机：采集输入 → 在可能的情况下执行确定性计算 → 在需要逻辑推理或主观判断时调用大语言模型 → 评估结果 → 决定是否继续迭代或退出。

LLMs are non-deterministic. If you can write a normal function to handle a step, do it. Use plain code for parsing, calculating, or sorting. Anything that does not require reasoning.

大语言模型（LLM）本质上是非确定性的。若某个步骤可通过普通函数实现，请务必如此处理；对解析、计算、排序等无需推理能力的任务，请直接使用常规代码实现。

```tsx
import { streamText, tool } from "ai";

import { anthropic } from "@ai-sdk/anthropic";

import { z } from "zod";



async function stockAnalysisAgent(

6  symbol: string,

6  symbol：字符串，

7  startDate: string,

7  startDate：字符串，

8  endDate: string

8  endDate：字符串

9) {

9) {

10  return streamText({

10  return streamText({

11    model: anthropic("claude-4-sonnet-20250514"),

11    model: anthropic("claude-4-sonnet-20250514"),

12    system: `You are a professional stock analyst AI powered by Claude Sonnet. You MUST perform a comprehensive analysis using BOTH available tools.



ANALYSIS STRUCTURE:

12    system: `你是一位由 Claude Sonnet 驱动的专业股票分析师 AI。你必须同时使用两种可用工具，进行全面分析。



分析结构：

15- Technical Analysis: Use price data, P/E ratio, beta, 52-week range, volume patterns

15–技术分析：使用股价数据、市盈率（P/E）、贝塔系数（beta）、52 周价格区间、成交量模式

16- Fundamental Analysis: Use news sentiment, earnings data, market cap, industry trends

16- 基本面分析：利用新闻情绪、盈利数据、市值及行业趋势

17- Investment Recommendation: Clear BUY/SELL/HOLD with specific price targets and reasoning

17- 投资建议：明确给出“买入/卖出/持有”评级，并附具体目标价及详细理由

IMPORTANT: You MUST use both tools before providing any analysis. Do not wait or ask - call both tools immediately and concurrently.

重要提示：在提供任何分析之前，你必须同时调用两个工具。不得等待或主动询问——请立即、并行地调用这两个工具。

NOTE: The news search uses Finnhub as the primary source (more reliable for stock news) with NewsAPI as fallback.

备注：新闻搜索以 Finnhub 为主要数据源（其股票新闻可靠性更高），NewsAPI 作为备用数据源。

22    prompt: `Analyze ${symbol.toUpperCase()} stock comprehensively. Use BOTH the getStockData and searchNews tools to gather complete market data, then provide detailed technical and fundamental analysis with a clear investment recommendation.`

22    提示词：`全面分析 ${symbol.toUpperCase()} 股票。请同时调用 getStockData 和 searchNews 两个工具，以获取完整的市场数据，随后提供详尽的技术面与基本面分析，并给出明确的投资建议。`

23    tools: {

23    工具：{

24      getStockData: tool({

24      getStockData: tool({

25        description: 

25        描述：

26          "Get real-time stock price, volume, financial metrics, and historical data for a given symbol using Finnhub API",

26          “使用 Finnhub API 获取指定股票代码的实时股价、成交量、财务指标及历史数据”。

27        parameters: z.object({

27        参数：z.object({

28          symbol: z.string().describe("Stock symbol (e.g., NVDA, AAPL, TSLA)"),

28          symbol: z.string().describe("股票代码（例如：NVDA、AAPL、TSLA）"),

29        }),

29        }),

30        execute: async ({ symbol }) => {

30        执行：async ({ symbol }) => {

31          return getStockData(symbol, startDate, endDate);

31          return getStockData(symbol, startDate, endDate);

32        },

32        },

33      }),

33      }),

34      searchNews: tool({

34      searchNews: tool({

35        description: 

35        描述：

36          "Search for recent news and analysis about a stock or company using Finnhub (primary) and NewsAPI (fallback)",

36          “使用 Finnhub（主用）和 NewsAPI（备用）搜索某只股票或公司的最新新闻与分析”,

37        parameters: z.object({

37        参数：z.object({

38          query: z

38          query: z

39            .string()

39            .string()

40            .describe(

40            .describe(

41              'Search query for news (e.g., "NVIDIA", "Apple earnings", "Tesla Model 3")'

41              “新闻搜索关键词（例如：‘NVIDIA’、‘Apple earnings’、‘Tesla Model 3’）”

42            ),

42            ),

43        }),

43        }),

44        execute: async ({ query }) => {

44        execute: async ({ query }) => {

45          return searchNews(query, startDate, endDate);

45          return searchNews(query, startDate, endDate);

46        },

47      }),

48    },

49    maxSteps: 5,

50  });

51}


```

示例：股票分析智能体

不要畏惧传统的编程方式。将大语言模型（LLM）留用于真正需要判断力的任务部分。

构建 AI 智能体看似是一项呼唤全新抽象范式的新任务，但实际上它就是常规的编程工作。请使用 `if` 语句、循环或 `switch` 语句——选择最适合当前场景的工具即可。无需过度纠结于架构设计。如需了解常见模式，请参阅 [我们的 AI SDK 智能体文档](https://ai-sdk.dev/docs/foundations/agents)。

The agent "works" when it reliably produces acceptable results with little to no intervention.

当代理能以极少甚至无需人工干预的方式稳定产出可接受的结果时，它才算真正“可用”。

## Step 3: Optimize for reliability

## 第三步：优化可靠性

Now that the agent is running end to end, shift your focus to improving quality. This means making the agent perform well on both specific examples and a wide range of real-world inputs.

如今代理已实现端到端运行，下一步应将重心转向质量提升。这意味着既要确保其在特定样例上表现良好，也要保证其能稳健应对各类真实世界输入。

Start by tightening the loop. Refine your prompts. Make tool calls more precise. Remove unnecessary retries. Replace model calls with plain deterministic functions wherever you can. If the agent produces incomplete results, use a second model to critique the results of the first model and continue the work.

首先收紧执行闭环：精炼提示词（prompts）；提升工具调用的准确性；剔除不必要的重试逻辑；在可行之处，用确定性的普通函数替代大模型调用；若代理输出结果不完整，可引入第二个模型对第一个模型的输出进行评估与修正，并继续后续任务。

At this stage, intuition and hands-on testing are your best tools. Iterate until the agent feels solid when running against real examples. Once the core loop is stable, [introduce structured evaluations](https://vercel.com/blog/eval-driven-development-build-better-ai-faster) to test performance across a broad range of inputs and edge cases. This helps catch regressions early and ensures quality holds up as the agent evolves.

此阶段，直觉判断与动手实测是你最有力的工具。持续迭代，直至代理在真实样例上运行时令人感到可靠稳固。一旦核心执行闭环趋于稳定，即可[引入结构化评估](https://vercel.com/blog/eval-driven-development-build-better-ai-faster)，在广泛输入及各类边界场景下系统性地检验其性能。这有助于尽早发现退化问题，并确保代理在持续演进过程中始终维持高质量表现。

## Takeaways

## 关键要点

AI agents expand what software can do, but building one doesn't require reinventing how you think about programming. The most reliable agents are built with the same fundamentals: clear logic, good structure, and tight feedback loops.

AI 代理拓展了软件的能力边界，但构建它并不意味着要彻底重构你对编程的认知方式。最可靠的代理，恰恰建立在那些久经考验的工程基本功之上：清晰的逻辑、良好的结构，以及紧密的反馈闭环。

Before committing to any implementation, test the task manually using real inputs and prompts. If the model can almost get there with help, it’s probably worth building. From there, structure the logic using ordinary code and only rely on the model when necessary. Once the agent is working, focus on making it resilient. Both on individual inputs and across real-world complexity.

在选定任一实现方案前，请先使用真实输入和提示词手动完成该任务。若模型在适当辅助下已接近达成目标，那么这项任务很可能值得投入开发。此后，应优先用常规代码组织逻辑流程，仅在必要时才调用模型。待代理初步可用后，重点转向提升其鲁棒性——既要保障单个输入下的稳定性，也要应对真实世界中纷繁复杂的整体挑战。

To recap, agents are useful when:

简言之，当满足以下条件之一时，采用代理尤为合适：

- The task is difficult to automate with traditional code  
- 该任务难以通过传统代码实现自动化

- Prompting the model manually shows signs of success

- 手动提示模型已初见成效

- You scope the agent narrowly and build on [solid software practices](https://ai-sdk.dev/docs/foundations/agents)

- 你将智能体的作用范围限定得较为狭窄，并基于[扎实的软件工程实践](https://ai-sdk.dev/docs/foundations/agents)进行构建

- You optimize both with hands-on intuition and structured evaluation

- 你既依靠实践直觉，也借助结构化评估来持续优化

When built right, AI agents feel like magic. But there’s no sorcery behind it. Just smart systems with reasoning built in.

若构建得当，AI 智能体便如魔法般神奇。但其背后并无任何神秘术法——仅是内嵌推理能力的智能系统。

[**Ready to build?**\\
\\
Get started with the AI SDK to build reliable, scoped AI agents using real software patterns.\\
\\
Try AI SDK](https://ai-sdk.dev/)

[**准备开始构建了吗？**\\
\\
立即上手 AI SDK，运用真实的软件工程模式，构建可靠、边界清晰的 AI 智能体。\\
\\
试用 AI SDK](https://ai-sdk.dev/)