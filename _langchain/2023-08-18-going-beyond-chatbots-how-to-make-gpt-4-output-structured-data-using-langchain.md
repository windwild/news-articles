---
title: "Going Beyond Chatbots: How to Make GPT-4 Output Structured Data Using LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:01:25.450244196+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

By [Jacob Lee](https://twitter.com/hacubu?lang=en&ref=blog.langchain.com)

作者：[Jacob Lee](https://twitter.com/hacubu?lang=en&ref=blog.langchain.com)

Over the past few months, I had the opportunity to do some cool exploratory work for a client that integrated LLMs like GPT-4 and Claude into their internal workflow, rather than exposing them through a chat interface. The general idea was to take some input data, analyze it using an LLM, enrich the LLM's output using existing data sources, and then sanity check it using both traditional tools and LLMs. This process could repeat several times until finally storing a final result in a database. I've been thinking of it as a pipeline that mixes LLMs with more mundane APIs where the output of one step feeds directly into the next.

过去几个月，我有幸为一位客户开展了一些富有探索性的有趣工作——将 GPT-4 和 Claude 等大语言模型（LLM）深度集成到其内部工作流中，而非仅通过聊天界面对外暴露。整体思路是：接收某些输入数据，利用 LLM 进行分析；再结合现有数据源对 LLM 的输出进行增强；最后，同时借助传统工具与 LLM 对结果进行合理性校验。该流程可多次迭代，直至将最终结果存入数据库。我将其视为一条混合了 LLM 与常规 API 的处理流水线，其中前一步的输出直接作为后一步的输入。

![](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_001.jpg)

## **The Problem**

## **问题所在**

While building such pipelines, I quickly realized that while natural language is an excellent interface for a chatbot, it's quite a difficult one to use with existing APIs.

在构建此类流水线的过程中，我很快意识到：尽管自然语言是聊天机器人的绝佳交互接口，但它与现有 API 却极难协同工作。

To illustrate this, let's say you wanted to generate and store a list of countries in Airtable. Naively asking an LLM `Give me a list of 5 countries` results in a numbered list of countries:

为说明这一点，假设你想在 Airtable 中生成并存储一份国家列表。若简单地向 LLM 提问：“给我列出 5 个国家”，它可能返回如下带编号的国家列表：

```text
'1. United States\n' +
'2. Canada\n' +
'3. United Kingdom\n' +
'4. Australia\n' +
'5. Japan'
```

There are a few problems here - while the above output happens to be a numbered list, there is no guarantee of that. Also, you would need to write some awkward custom string parsing logic to extract the data for use in the next step of the pipeline.

这里存在几个问题：首先，上述输出虽恰好是编号列表，但 LLM 并不保证每次都以这种格式返回；其次，你不得不编写繁琐且脆弱的自定义字符串解析逻辑，才能从中提取结构化数据，供流水线后续步骤使用。

The solution is to prompt the LLM to output data in some structured format, but it's not quite that simple. For example, asking, `Give me a list of 5 countries, formatted as Airtable records` might result in something like this:

一种解决方案是提示 LLM 以某种结构化格式输出数据——但实际操作远非如此简单。例如，若提问：“给我列出 5 个国家，并按 Airtable 记录格式输出”，LLM 可能返回如下内容：

```text
'Airtable records require a unique ID and field values in a JSON format. Here is a list of 5 countries formatted as Airtable records:\n' +
'\n' +
'1. {\n' +
'  "id": "rec1",\n' +
'  "fields": {\n' +
'    "Country": "United States",\n' +
'    "Continent": "North America"\n' +
'  }\n' +
'}\n' +
'2. {\n' +
'  "id": "rec2",\n' +
'  "fields": {\n' +
'    "Country": "Canada",\n' +
'    "Continent": "North America"\n' +
'  }\n' +
'}\n' +
...
```

Though the LLM (in this case GPT-4) impressively knows the general schema of an Airtable record, this is even worse than the original attempt. There is conversational text at the top that must be parsed out, and the output format is still a numbered list. Additionally, the LLM has assumed the field names of your Airtable schema, which likely do not match your internal definitions.

尽管大语言模型（此处为 GPT-4）令人印象深刻地掌握了 Airtable 记录的一般结构，但该结果甚至比最初的尝试更差：顶部仍包含需人工解析的对话式文本，且输出格式仍是编号列表；此外，模型还擅自假设了你的 Airtable 字段名称，而这些名称很可能与你内部定义的实际字段不一致。

I experimented with a few custom prompting strategies like `Output only an array of JSON objects containing X, Y, and Z`, but adding such language to all my prompts quickly became tedious. Furthermore, this was somewhat unreliable due to the non-deterministic nature of LLMs, particularly with long, complex prompts and higher temperatures.

我尝试了几种自定义提示策略，例如要求模型“仅输出包含 X、Y 和 Z 的 JSON 对象数组”，但将此类指令添加到所有提示词中很快变得繁琐不堪。此外，由于大语言模型本身具有非确定性（尤其在处理长而复杂的提示词、或设置较高 temperature 值时），该方法的可靠性也较为有限。

## **The Solution**

## **解决方案**

I had already been using [LangChainJS](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com), an open-source framework that helps with building complex applications around LLMs, for various pieces of the project. After asking around their Discord community, I discovered an elegant, built-in solution: [output fixing parsers](https://js.langchain.com/docs/modules/prompts/output_parsers/?ref=blog.langchain.com#output-fixing-parser)!

项目中我早已在多个模块中使用了开源框架 [LangChainJS](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com)——一个专为围绕大语言模型构建复杂应用而设计的工具集。在向其 Discord 社区咨询后，我发现了其内置的一个优雅方案：[输出修复解析器（output fixing parsers）](https://js.langchain.com/docs/modules/prompts/output_parsers/?ref=blog.langchain.com#output-fixing-parser)！

Output fixing parsers contain two components:

输出修复解析器包含两个核心组件：

1. An easy, consistent way of generating output formatting instructions (using a popular TypeScript validation framework, [Zod](https://github.com/colinhacks/zod?ref=blog.langchain.com)).
2. An LLM-powered recovery mechanism for handling badly formatted outputs using a more focused prompt.

1. 一种简洁、统一的方式，用于生成输出格式化指令（借助广受欢迎的 TypeScript 类型验证框架 [Zod](https://github.com/colinhacks/zod?ref=blog.langchain.com)）；  
2. 一种由大语言模型驱动的恢复机制，可通过更聚焦的提示词自动修正格式错误的输出。

You could use one to solve the earlier problem like this (note that you will need to run `yarn add langchain` and `yarn add zod` if they aren't already in your dependencies):

你可以按如下方式使用该解析器解决前述问题（注意：若尚未安装相关依赖，请先运行 `yarn add langchain` 和 `yarn add zod`）：

```typescript
import { z } from "zod";
import { ChatOpenAI } from "langchain/chat_models/openai";
import { PromptTemplate } from "langchain/prompts";
import { LLMChain } from "langchain/chains";
import {
  StructuredOutputParser,
  OutputFixingParser
} from "langchain/output_parsers";

const outputParser = StructuredOutputParser.fromZodSchema(
  z.array(
    z.object({
      fields: z.object({
        Name: z.string().describe("The name of the country"),
        Capital: z.string().describe("The country's capital")
      })
    })
  ).describe("An array of Airtable records, each representing a country")
);

const chatModel = new ChatOpenAI({
  modelName: "gpt-4", // Or gpt-3.5-turbo
  temperature: 0 // For best results with the output fixing parser
});
```

```typescript
const outputFixingParser = OutputFixingParser.fromLLM(
  chatModel,
  outputParser
);

const prompt = new PromptTemplate({
  template: `Answer the user's question as best you can:\n{format_instructions}\n{query}`,
  inputVariables: ['query'],
  partialVariables: {
    format_instructions: outputFixingParser.getFormatInstructions()
  }
});

// For those unfamiliar with LangChain, a class used to call LLMs
const answerFormattingChain = new LLMChain({
  llm: chatModel,
  prompt: prompt,
  outputKey: "records", // For readability - otherwise the chain output will default to a property named "text"
  outputParser: outputFixingParser
});

const result = await answerFormattingChain.call({
  query: "List 5 countries."
});

console.log(JSON.stringify(result.records, null, 2));
```

简洁清晰！以下是实际输出结果的示例：

```typescript
[\
  {\
    "fields": {\
      "Name": "United States",\
      "Capital": "Washington, D.C."\
    }\
  },\
  {\
    "fields": {\
      "Name": "Canada",\
      "Capital": "Ottawa"\
    }\
  },\
  {\
    "fields": {\
      "Name": "Germany",\
      "Capital": "Berlin"\
    }\
  },\
  {\
    "fields": {\
      "Name": "Japan",\
      "Capital": "Tokyo"\
    }\
  },\
  {\
    "fields": {\
      "Name": "Australia",\
      "Capital": "Canberra"\
    }\
  }\
]
```

成功！返回结果已自动被类型化为对象数组，因此无需调用 `JSON.parse()` 或进行任何额外解析。

请注意：若因任何原因（例如模型输出格式严重偏离），输出修正解析器（output fixing parser）无法生成符合所提供 Zod schema 的输出，则会直接抛出错误。你甚至可以将该结果直接传入 Airtable API 调用！

## **其他实用技巧**

## **其他实用技巧**

Descriptions provided with `.describe()` are optional, but give the LLM helpful context when populating individual fields. The LLM will also use clues like the field name and the overall structure of the provided schema.

`.describe()` 方法提供的描述是可选的，但能为大语言模型（LLM）在填充各个字段时提供有益的上下文信息。LLM 还会结合字段名称以及所提供 Schema 的整体结构等线索进行推理。

- If you're struggling to generate output in the right format, adding descriptions or tweaking the language in these descriptions can help.  
- 如果你难以生成符合预期格式的输出，添加字段描述或调整描述中的措辞可能会有所帮助。

- You can use different model instances in the output fixing parser and whatever chain you're using, allowing you to mix and match temperatures and even providers for best results.  
- 你可以在输出修正解析器（output fixing parser）以及所使用的任意链（chain）中采用不同的模型实例，从而灵活组合不同温度值（temperature）乃至不同服务商（provider），以获得最佳效果。

## **Thanks for Reading!**

## **感谢阅读！**

I hope this post helps you better use the power of LLMs in your projects!

希望本文能帮助你在项目中更高效地发挥大语言模型（LLM）的强大能力！

I've actually enjoyed building with LLMs and specifically [LangChain](https://js.langchain.com/?ref=blog.langchain.com) so much that I recently joined their team, so expect to see more related content over the coming months! And if you have any questions or have ideas for what you'd like me to write about next, reach out to me on Twitter [@Hacubu](https://twitter.com/hacubu?lang=en&ref=blog.langchain.com). I'll be active in the JS channels of [LangChain's community Discord server](https://discord.com/invite/6adMQxSpJS?ref=blog.langchain.com) as well.

事实上，我非常享受使用大语言模型（尤其是 [LangChain](https://js.langchain.com/?ref=blog.langchain.com)）进行开发的过程，以至于我最近已正式加入 LangChain 团队！因此，未来几个月你将看到更多相关主题的内容。如果你有任何问题，或对后续想了解的主题有建议，欢迎通过 Twitter 联系我：[@Hacubu](https://twitter.com/hacubu?lang=en&ref=blog.langchain.com)。我也会活跃在 [LangChain 社区 Discord 服务器](https://discord.com/invite/6adMQxSpJS?ref=blog.langchain.com) 的 JavaScript 相关频道中。

Happy prompting!

愿你提示词（prompt）顺心，输出如意！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：让模型评估变得更轻松**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/going-beyond-chatbots-how-to-make-gpt-4-output-structured-data-using-langchain/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
