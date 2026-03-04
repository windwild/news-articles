---
render_with_liquid: false
title: "LangChain Expression Language"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-expression-language/"
date: "2023-11-14"
scraped_at: "2026-03-03T08:27:38.022824416+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

**TL;DR:**

**简明摘要：**

- **我们很高兴地宣布一种全新的 [语法](https://python.langchain.com/docs/guides/expression_language/?ref=blog.langchain.com)，用于通过组合方式构建链（chains）。该语法配套提供了一个全新接口，开箱即支持批量处理（batch）、异步调用（async）和流式响应（streaming）。我们将这种语法命名为 LangChain 表达式语言（LangChain Expression Language，简称 LCEL）。**  
- **我们开发了一个 “[LangChain 教师](https://langchain-teacher-lcel.streamlit.app/?ref=blog.langchain.com)” 交互式教学应用，帮助你学习 LCEL（需具备 LangChain 基础知识）。**  
- **我们将于 8 月 2 日举办一场 [线上研讨会（webinar）](https://www.crowdcast.io/c/ckw1tydg29er?ref=blog.langchain.com)，深入讲解 LCEL 及其实际使用方法。**  
- **LCEL 的目标是简化复杂链的构建过程，并与我们近期发布的 [LangSmith](https://blog.langchain.com/announcing-langsmith/) 平台完美协同——LangSmith 是专为助力开发者从原型快速迈向生产环境而设计的平台。**

The idea of chaining has proven popular when building applications with language models. Chaining can come in a few different forms, each with their own benefits. Some examples of these are:

“链式调用”（chaining）这一理念在基于大语言模型构建应用时已广受欢迎。链式调用有多种表现形式，各自具备独特优势。以下是一些典型示例：

**Making Multiple LLM Calls**

**多次调用大语言模型（LLM）**

Chaining can mean making multiple LLM calls in a sequence. Language models are often non deterministic and can make errors, so making multiple calls to check previous outputs or to break down larger tasks into bite-sized steps can improve results.

链式调用可表现为按顺序发起多次 LLM 调用。由于语言模型通常具有不确定性，且可能产生错误，因此通过多次调用以验证先前输出，或将大型任务拆解为若干小步骤，有助于提升最终结果质量。

**Constructing the Input to LLMs**

**构造大语言模型的输入**

Chaining can mean combining data transformation with a call to an LLM. For example, formatting a prompt template with user input or using retrieval to look up additional information to insert into the prompt template. This is necessary because you often need data from multiple sources to perform a task, which may be fetched at runtime conditional on the input.

链式调用也可指将数据转换操作与 LLM 调用相结合。例如，将用户输入填充至提示词模板中，或通过检索机制动态查找额外信息并插入模板。之所以需要这种方式，是因为完成一项任务往往需整合多个数据源的信息，而这些信息常需根据运行时输入动态获取。

**Using the Output of LLMs**

**利用大语言模型的输出**

Another form of chaining refers to passing the output of an LLM call to a downstream application. For example, using the LLM to generate Python code and then running that code; using the LLM to generate SQL and then executing that against a SQL database.

另一种链式调用形式，是将 LLM 的输出传递给下游应用程序。例如：利用 LLM 生成 Python 代码并立即执行；或让 LLM 生成 SQL 查询语句，再将其提交至 SQL 数据库执行。

There’s also something about working with language models that makes the idea of chaining appealing. Sure, all the above operations could be done with code, but people have gravitated towards the idea of chaining - as evidenced by the multitude of low-code/no-code platforms for building language model applications (some like [Flowwise](https://flowiseai.com/?ref=blog.langchain.com) and [LangFlow](https://github.com/logspace-ai/langflow?ref=blog.langchain.com) built on top of LangChain). Why? It’s become a bit of a meme, but if [text is the universal interface](https://scale.com/blog/text-universal-interface?ref=blog.langchain.com), and all of these operations involve manipulation of text, then this sets itself up incredibly naturally for an expression language to support this.

此外，语言模型本身的特性也让“链式调用”的理念格外契合。诚然，上述所有操作均可通过传统编程实现；但开发者却普遍倾向于采用链式调用范式——这一点从大量涌现的低代码/无代码语言模型应用平台（如基于 LangChain 构建的 [Flowwise](https://flowiseai.com/?ref=blog.langchain.com) 和 [LangFlow](https://github.com/logspace-ai/langflow?ref=blog.langchain.com)）中可见一斑。为何如此？这虽已略带网络迷因（meme）色彩，但若认同 “[文本即通用接口](https://scale.com/blog/text-universal-interface?ref=blog.langchain.com)” 这一观点，而所有这些操作本质上又都围绕文本的生成与变换展开，那么，为支持此类模式而设计一门表达式语言（expression language），便显得水到渠成、顺理成章。

LangChain was born from the idea of making these types of operations easy. We saw people doing common patterns and factored them out into pre-built chains: LLMChain, ConversationalRetrievalChain, SQLQueryChain.

LangChain 的诞生源于一个理念：让此类操作变得简单易行。我们观察到开发者反复实践一些常见模式，于是将这些模式提炼并封装为预构建的链（chains）：`LLMChain`、`ConversationalRetrievalChain`、`SQLQueryChain`。

But these chains weren’t really composable. Sure - we had SequentialChain, but that wasn’t amazingly usable. And under the hood the other chains involved a lot of custom code, which made it tough to enforce a common interface for all chains, and ensure that all had equal levels of batch, streaming, and async support.

但这些链本质上并不具备良好的可组合性。诚然，我们提供了 `SequentialChain`，但其可用性远未达到理想水平。此外，其他链在底层大量依赖定制化代码，这使得统一所有链的接口变得困难，也难以确保每条链都具备同等水平的批量处理（batch）、流式响应（streaming）和异步（async）支持。

Today we’re excited to announce a new way of constructing chains. We’re calling this the LangChain Expression Language (in the same spirit as [SQLAlchemyExpressionLanguage](https://docs.sqlalchemy.org/en/14/core/tutorial.html?ref=blog.langchain.com)). This is a declarative way to truly compose chains - and get streaming, batch, and async support out of the box. You can use all the same existing LangChain constructs to create them.

今天，我们非常高兴地宣布一种全新的链构建方式——我们将其命名为 **LangChain 表达式语言（LangChain Expression Language）**（其设计精神与 [SQLAlchemy 表达式语言（SQLAlchemy Expression Language）](https://docs.sqlalchemy.org/en/14/core/tutorial.html?ref=blog.langchain.com) 一脉相承）。这是一种声明式（declarative）方法，真正实现了链的灵活组合，并开箱即用地提供流式响应、批量处理和异步调用支持。你仍可沿用所有现有的 LangChain 构建模块来创建表达式链。

We’ve included guides on [how to work with the interface](https://python.langchain.com/docs/guides/expression_language/interface?ref=blog.langchain.com) as well as [some examples of using it](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com). Let’s take a look at one of the more common ways below:

我们已提供相关指南，包括：[如何使用该接口](https://python.langchain.com/docs/guides/expression_language/interface?ref=blog.langchain.com)，以及 [若干实用示例](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com)。下面让我们来看一个较为常见的用法：

```python
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate

model = ChatOpenAI()
prompt = ChatPromptTemplate.from_template("tell me a joke about {foo}")
chain = prompt | model

chain.invoke({"foo": "bears"})
>>> AIMessage(content="Why don't bears ever wear shoes?\n\nBecause they have bear feet!", additional_kwargs={}, example=False)
```

```python
from langchain.chat_models import ChatOpenAI
from langchain.prompts import ChatPromptTemplate

model = ChatOpenAI()
prompt = ChatPromptTemplate.from_template("讲一个关于 {foo} 的笑话")
chain = prompt | model

chain.invoke({"foo": "熊"})
>>> AIMessage(content="为什么熊从来不穿鞋？\n\n因为它们有熊掌！", additional_kwargs={}, example=False)
```

This uses a standard ChatOpenAI model and prompt template. You chain them together with the `|` operator, and then call it with `chain.invoke`. We can also get async, batch, and streaming support out of the box.

此处使用了标准的 `ChatOpenAI` 模型与提示词模板（prompt template）。你可通过 `|` 运算符将二者串联成链，再通过 `chain.invoke` 方法调用。此外，该链还开箱即用地支持异步调用、批量处理与流式响应。

**Batch**

**批量处理（Batch）**

`batch` takes in a list of inputs. If optimizations can be done internally (like literally batching calls to LLM providers) those are done.

`batch` 方法接收一个输入列表。若内部可进行优化（例如，真正意义上将对大语言模型服务提供商的多次调用合并为单次批量请求），系统将自动执行此类优化。

```
chain.batch([{"foo": "bears"}, {"foo": "cats"}])
>>> [AIMessage(content="Why don't bears ever wear shoes?\n\nBecause they have bear feet!", additional_kwargs={}, example=False),\
 AIMessage(content="Why don't cats play poker in the wild?\n\nToo many cheetahs!", additional_kwargs={}, example=False)]
```

```
chain.batch([{"foo": "bears"}, {"foo": "cats"}])
>>> [AIMessage(content="为什么熊从不穿鞋？\n\n因为它们有‘熊’脚！", additional_kwargs={}, example=False),\
 AIMessage(content="为什么野生的猫不在野外打扑克？\n\n因为‘猎豹’太多了！", additional_kwargs={}, example=False)]
```

**Stream**

`stream` returns an iterable that you can consume.

**流式处理（Stream）**

`stream` 方法返回一个可迭代对象，你可以逐项消费其输出。

```
for s in chain.stream({"foo": "bears"}):
    print(s.content, end="")
```

```
for s in chain.stream({"foo": "bears"}):
    print(s.content, end="")
```

**Async**

All of `invoke`, `batch`, and `stream` expose async methods. We only show `ainvoke` here for simplicity, although you can check out our notebook that deep dives into the interface to see more.

**异步支持（Async）**

`invoke`、`batch` 和 `stream` 均提供对应的异步方法。为简洁起见，此处仅展示 `ainvoke`；你也可查阅我们的 Notebook，其中深入剖析了该接口的全部用法。

```
await chain.ainvoke({"foo": "bears"})
```

```
await chain.ainvoke({"foo": "bears"})
```

In our cookbook we’ve included examples of doing this with:

我们在官方“食谱（Cookbook）”中已收录以下场景的使用示例：

- [Multiple LLM calls](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#multiple-llm-chains)  
- [Function calling](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#attaching-function-call-information)  
- [Retrieval](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#llmchain--retriever)  
- [Arbitrary Functions](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#arbitrary-functions)  
- [SQL Database query](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#sql-database)  
- [Python execution](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#code-writing)

- [多次大语言模型调用（Multiple LLM calls）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#multiple-llm-chains)  
- [函数调用（Function calling）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#attaching-function-call-information)  
- [检索增强（Retrieval）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#llmchain--retriever)  
- [任意函数集成（Arbitrary Functions）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#arbitrary-functions)  
- [SQL 数据库查询（SQL Database query）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#sql-database)  
- [Python 代码执行（Python execution）](https://python.langchain.com/docs/guides/expression_language/cookbook?ref=blog.langchain.com#code-writing)

We’ll be constantly beefing up support for this and adding more examples of functionality, so let us know what you’d like to see. We'll also be incorporating this more into LangChain - already the `create_sql_query_chain` uses this under the hood.

我们将持续增强对此功能的支持，并不断补充更多实用示例——欢迎告诉我们你希望看到哪些新能力！此外，该范式也正深度融入 LangChain 生态：例如，当前的 `create_sql_query_chain` 已在底层默认采用此机制。

Besides the benefit of adding standard interfaces, another benefit is that this will make it easier for users to customize parts of the chain. Since the chain is expressed in such a declarative and composable nature, it will be much more clear how to swap certain components out. It also now brings the prompts front and center - making it more clear how to modify those. The prompts in LangChain are just defaults, and are largely intended to be modified for your particular use case if you are seriously trying to take an application into production. Previously, the prompts were a bit hidden and hard to change. With LCEL, they are more prominent and easily swappable.

除了增加标准接口这一优势外，另一大好处是：这将使用户更轻松地定制链中的部分组件。由于该链以声明式且可组合的方式表达，因此替换特定组件的方式将变得清晰得多。同时，提示词（prompts）现在被置于核心位置，使其修改方式也更加直观明确。LangChain 中的提示词仅作为默认值提供，若你正认真考虑将应用投入生产环境，则强烈建议根据具体使用场景对其进行调整。此前，提示词相对隐蔽，修改起来较为困难；而借助 LCEL，它们变得更加醒目，也更易于替换。

LangChain Expression Language creates chains that integrate seamlessly with LangSmith. Here is a trace for the above:

LangChain 表达式语言（LCEL）所创建的链可与 LangSmith 无缝集成。以下是上述示例的执行追踪图：

![](images/langchain-expression-language/img_001.png)

You can inspect the trace [here](https://smith.langchain.com/public/779f432a-fa8c-4b85-bf7d-3dca9a8c569c/r?ref=blog.langchain.com). Previously, when creating a custom chain there was actually a good bit of work to be done to make sure callbacks were passed through correctly so that it could be traced correctly. With LangChain Expression Language that happens automatically.

你可在此处查看该追踪记录：[点击访问](https://smith.langchain.com/public/779f432a-fa8c-4b85-bf7d-3dca9a8c569c/r?ref=blog.langchain.com)。此前，当构建自定义链时，需额外投入不少工作，以确保回调（callbacks）被正确传递，从而实现准确的链路追踪。而借助 LangChain 表达式语言，这一切均自动完成。

We've also tried to make this as easy as possible for people to learn by creating a "LangChain Teacher" application that will walk you through the basics of getting started with LangChain Expression Language. You can access it [here](https://langchain-teacher-lcel.streamlit.app/?ref=blog.langchain.com). We'll be open sourcing this soon.

我们还专门开发了一款名为 “LangChain 教师”（LangChain Teacher）的应用程序，旨在尽可能降低学习门槛，手把手带你入门 LangChain 表达式语言。你可通过以下链接访问：[点击进入](https://langchain-teacher-lcel.streamlit.app/?ref=blog.langchain.com)。该应用即将开源。

We'll also be doing a webinar on this tomorrow. We'll cover the standard interface it exposes, how to use it, and why to use it. Register for that [here](https://www.crowdcast.io/c/ckw1tydg29er?ref=blog.langchain.com).

我们还将于明日举办一场专题网络研讨会（webinar），深入讲解 LCEL 所暴露的标准接口、使用方法及其设计初衷。欢迎点击此处注册参加：[立即报名](https://www.crowdcast.io/c/ckw1tydg29er?ref=blog.langchain.com)。

We're incredibly excited about this being an easy and lightweight way to truly compose chains together. If you're excited as well, we're hiring for roles that would work directly on this. The best way to get our attention is to open a PR or two adding more functionality. There's still a lot to build :)

我们对 LCEL 能以如此简洁轻量的方式真正实现链的组合深感振奋！如果你也同样激动不已，我们正在招聘直接参与此项工作的工程师。最能引起我们注意的方式，就是为你感兴趣的模块提交一两个功能增强型 Pull Request（PR）。前方仍有大量工作等待共建！🙂

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/langchain-expression-language/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langchain-expression-language/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-expression-language/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langchain-expression-language/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langchain-expression-language/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/langchain-expression-language/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langchain-expression-language/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langchain-expression-language/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-expression-language/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/langchain-expression-language/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-expression-language/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/langchain-expression-language/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟