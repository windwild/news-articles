---
title: "Supercharging If-Statements With Prompt Classification Using Ollama and LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchain/"
date: "2024-02-19"
scraped_at: "2026-03-03T08:11:36.812536775+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**Editor's Note:** [**Andrew Nguonly**](https://medium.com/@andrewnguonly?ref=blog.langchain.com) **has been building one of the more impressive projects we've seen recently - an LLM co-pilot for browsing the web, powered by local LLMs. There are a lot of small architectural decisions made that contain a ton of nuance, and so we're super excited to post this blog by him going over one of them in detail.**

**编辑注：** [**Andrew Nguonly**](https://medium.com/@andrewnguonly?ref=blog.langchain.com) **近期正在构建我们所见最具亮点的项目之一——一个由本地大语言模型（LLM）驱动的网页浏览辅助助手（LLM co-pilot）。该项目在架构设计中包含大量精妙而富有深意的小决策，因此我们非常激动地发布他撰写的这篇博客，深入剖析其中一项关键设计。**

## Reintroducing Lumos! 🪄

## 重新介绍 Lumos！🪄

I’ve written extensively about [Lumos](https://github.com/andrewnguonly/Lumos?ref=blog.langchain.com) in the past so I’ll keep the reintroduction short and sweet. [Lumos is an LLM co-pilot for browsing the web, powered by local LLMs](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-236817f335da?ref=blog.langchain.com). It’s a Chrome extension that [scrapes the content on the current page](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-part-2-6eb10caf39a1?ref=blog.langchain.com) and processes the parsed results in an [online, in-memory RAG workflow](https://medium.com/@andrewnguonly/lets-normalize-online-in-memory-rag-88e8169e9806?ref=blog.langchain.com), all in a single request context. Lumos is built on LangChain and powered by [Ollama](https://ollama.com/?ref=blog.langchain.com). It’s open-source and free to use.

我此前已多次详述过 [Lumos](https://github.com/andrewnguonly/Lumos?ref=blog.langchain.com)，因此本次重推将简明扼要。[Lumos 是一款面向网页浏览的 LLM 辅助助手，完全由本地运行的大语言模型驱动](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-236817f335da?ref=blog.langchain.com)。它是一款 Chrome 扩展程序，可[抓取当前网页的内容](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-part-2-6eb10caf39a1?ref=blog.langchain.com)，并在单次请求上下文中，对解析后的结果执行[在线、内存驻留的 RAG（检索增强生成）流程](https://medium.com/@andrewnguonly/lets-normalize-online-in-memory-rag-88e8169e9806?ref=blog.langchain.com)。Lumos 基于 LangChain 构建，并由 [Ollama](https://ollama.com/?ref=blog.langchain.com) 提供模型支持。项目开源且免费使用。

Lumos is great for tasks that we know LLMs are strong at:

Lumos 非常适用于我们已知 LLM 擅长的任务，例如：

- summarizing news articles, threads, and chat histories  
- summarizing 新闻文章、社交媒体帖子和聊天记录  
- asking questions about restaurant and product reviews  
- 就餐厅评价与商品评论提出问题  
- extracting details from dense technical documentation  
- 从密集的技术文档中提取关键信息  

I’ve even found Lumos to be [helpful with my Spanish studies](https://twitter.com/andrewnguonly/status/1757107944662139016?ref=blog.langchain.com). The ergonomics of the app are incredibly convenient. As I’m using the app more and more, I’m discovering new ways that LLMs in the browser can be handy.

我甚至发现 Lumos 对我的[西班牙语学习也颇有帮助](https://twitter.com/andrewnguonly/status/1757107944662139016?ref=blog.langchain.com)。该应用的人机交互体验极为便捷。随着我使用频率日益提高，我也不断发掘出浏览器内嵌 LLM 的更多实用场景。

## Rebuilding the Calculator 🧮

## 重构计算器 🧮

For text-based tasks, LLMs are creative and clever. However, they are not designed to be deterministic. [Andrej Karpathy once described LLMs as “dream machines.”](https://twitter.com/karpathy/status/1733299213503787018?ref=blog.langchain.com) An operation as simple as computing `456*4343` is not guaranteed by an LLM. For a complex equation with several operands and operators, even the top models don’t stand a chance.

在文本类任务上，大语言模型富有创造力且思维敏捷；但它们并非为确定性计算而设计。[Andrej Karpathy 曾将大语言模型形容为“造梦机器”](https://twitter.com/karpathy/status/1733299213503787018?ref=blog.langchain.com)。就连 `456*4343` 这样简单的算术运算，LLM 也无法保证结果正确。对于含多个操作数与运算符的复杂算式，即便是当前最顶尖的模型也无能为力。

What’s `456*4343 — 56/(443-11+4)`?

那么，`456*4343 — 56/(443-11+4)` 的结果是多少？

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_001.png)GPT-3.5 incorrectly “computes” 456\*4343  
![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_001.png)GPT-3.5 错误地“计算”了 456×4343  

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_002.png)Llama2 incorrectly “computes” 456\*4343  
![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_002.png)Llama2 同样错误地“计算”了 456×4343

LLMs need additional tools for certain work, such as executing code or solving math problems. Lumos is no exception. I don’t recall exactly why I needed a calculator in my browser (calculating taxes?), but I know I didn’t want to pull out my phone or open a new tab. I just wanted my LLM to answer the math problem correctly.

大型语言模型（LLM）在执行某些任务时需要额外的工具支持，例如运行代码或求解数学问题。Lumos 同样如此。我已记不清当初为何需要在浏览器中内置一个计算器（可能是为了计算税费？），但我清楚地记得：我不想掏出手机，也不想新开一个浏览器标签页——我只希望我的 LLM 能准确解答数学问题。

So, I decided to build a calculator into Lumos.

因此，我决定将计算器功能集成进 Lumos。

## Prompt Classification with Ollama 🦙

## 使用 Ollama 进行提示词分类 🦙

[I previously experimented with prompt classification using Ollama](https://medium.com/@andrewnguonly/how-did-we-get-stuck-with-temperature-and-frequency-penalty-553c3e585544?ref=blog.langchain.com) and deemed that the technique was very valuable. The output of a “classification prompt” could supercharge if-statements and branching logic if reliable.

我此前曾[使用 Ollama 尝试过提示词分类](https://medium.com/@andrewnguonly/how-did-we-get-stuck-with-temperature-and-frequency-penalty-553c3e585544?ref=blog.langchain.com)，并认为该技术极具价值。“分类型提示词”的输出结果，若足够可靠，便可极大增强 `if` 语句与分支逻辑的能力。

Although Lumos is not implemented as a [LangChain Agent](https://js.langchain.com/docs/modules/agents/?ref=blog.langchain.com), I wanted the experience of using it to be like that of interacting with one. It should execute tools independent of direct instruction. The app should just know when to use a calculator. Using Ollama to determine if a prompt needed the calculator tool was easy to implement.

尽管 Lumos 并非基于 [LangChain Agent](https://js.langchain.com/docs/modules/agents/?ref=blog.langchain.com) 实现，但我希望用户使用它的体验，能接近于与 LangChain Agent 交互的感觉：它应能自主调用工具，而无需用户显式指令；应用本身就应该“知道”何时启用计算器。利用 Ollama 判断提示词是否需要调用计算器工具，实现起来非常简单。

```
const isArithmeticExpression = async (
  baseURL: string,
  model: string,
  prompt: string,
): Promise<boolean> => {
  // check for prefix trigger
  if (prompt.trim().toLowerCase().startsWith("calculate:")) {
    return new Promise((resolve) => resolve(true));
  }

  // otherwise, attempt to classify prompt
  const ollama = new Ollama({ baseUrl: baseURL, model: model, temperature: 0, stop: [".", ","]});
  const question = `Is the following prompt a math equation with numbers and operators? Answer with 'yes' or 'no'.\n\nPrompt: ${prompt}`;
  return ollama.invoke(question).then((response) => {
    console.log(`isArithmeticExpression classification response: ${response}`);
    const answer = response.trim().split(" ")[0].toLowerCase();
    return answer.includes("yes");
  });
};
```

```
const isArithmeticExpression = async (
  baseURL: string,
  model: string,
  prompt: string,
): Promise<boolean> => {
  // 检查前缀触发词
  if (prompt.trim().toLowerCase().startsWith("calculate:")) {
    return new Promise((resolve) => resolve(true));
  }

  // 否则，尝试对提示词进行分类
  const ollama = new Ollama({ baseUrl: baseURL, model: model, temperature: 0, stop: [".", ","]});
  const question = `以下提示词是否为包含数字和运算符的数学算式？请仅回答“yes”或“no”。\n\nPrompt: ${prompt}`;
  return ollama.invoke(question).then((response) => {
    console.log(`isArithmeticExpression 分类响应：${response}`);
    const answer = response.trim().split(" ")[0].toLowerCase();
    return answer.includes("yes");
  });
};
```

Simply ask the LLM if the prompt was a math equation with numbers and operators and check if the response contained a “yes” or “no”. Dead simple. The implementation is even reliable without JSON mode or function calling. Prompting an LLM for a binary response contrasts with the approach of asking it to classify against an arbitrary number of potentially unrelated categories. This scenario arises when trying to match prompts with tools.

只需让 LLM 判断该提示词是否为含数字与运算符的数学算式，并检查其响应是否包含 “yes” 或 “no” —— 简单至极。该实现甚至无需启用 JSON 模式或函数调用，即可保持高度可靠性。向 LLM 请求二元（binary）响应，与要求其在大量可能互不相关的类别中做多选分类，是两种截然不同的思路；后者常见于将提示词匹配到各类工具的场景中。

[Llama2](https://ollama.com/library/llama2?ref=blog.langchain.com) and [Mistral](https://ollama.com/library/mistral?ref=blog.langchain.com) both performed well in my testing. Setting the model temperature to 0 and configuring stop sequences (`[".", ","]`) improved reliability and response latency even further. Relative to the average inference time experienced by a user for regular prompts (e.g. several seconds), the elapsed time for classification was only incremental. Admittedly, this added latency may not be sufficient for some use cases.

在我测试中，[Llama2](https://ollama.com/library/llama2?ref=blog.langchain.com) 和 [Mistral](https://ollama.com/library/mistral?ref=blog.langchain.com) 均表现出色。将模型温度设为 0，并配置终止序列（`[".", ","]`），进一步提升了分类结果的可靠性与响应速度。相较于用户处理常规提示词所需的平均推理时间（例如数秒），此次分类所增加的耗时仅属微增量。诚然，这一额外延迟未必能满足所有应用场景的需求。

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_003.png)Lumos console logs

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_003.png)Lumos 控制台日志

It’s also important to reiterate that leveraging local LLMs makes this operation effectively free. The utility of Ollama truly shines for this use case. To give users maximum control, the mechanism also includes functionality for a trigger, a prefix that the user can include in the prompt to guarantee that a tool will be executed. This is similar to ChatGPT’s `@` reference to invoke specific GPTs.

同样重要的是，需再次强调：借助本地大语言模型（LLM）可使该操作近乎零成本。Ollama 在这一应用场景中真正展现出其强大价值。为赋予用户最大程度的控制权，该机制还内置了“触发器”功能——即用户可在提示词（prompt）中加入特定前缀，以确保某项工具必然被调用。这与 ChatGPT 中使用 `@` 符号调用特定 GPT 的方式类似。

## `456 x 4343 =`1980408 🔢

## `456 × 4343 =`1980408 🔢

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_004.png)Lumos correctly computes 456\*4343

![](images/supercharging-if-statements-with-prompt-classification-using-ollama-and-langchai/img_004.png)Lumos 准确计算出 456 × 4343 的结果

The implementation of [Lumos’s calculator](https://github.com/andrewnguonly/Lumos/blob/main/docs/tools.md?ref=blog.langchain.com#calculator) is straightforward. It’s built as a [LangChain Tool](https://js.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com) to preserve future portability of the app into a robust Agent. For custom tools, [LangChain suggests building a](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com) [`DynamicTool`](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com) [or](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com) [`DynamicStructuredTool`](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com), but it’s easy to subclass the base [`Tool`](https://github.com/langchain-ai/langchainjs/blob/main/langchain-core/src/tools.ts?ref=blog.langchain.com) class as well.

[Lumos 计算器](https://github.com/andrewnguonly/Lumos/blob/main/docs/tools.md?ref=blog.langchain.com#calculator) 的实现非常简洁明了。它被构建为一个 [LangChain Tool](https://js.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com)，以确保未来能将该应用无缝迁移至功能完备的智能体（Agent）架构中。对于自定义工具，[LangChain 建议采用](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com) [`DynamicTool`](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com) 或 [`DynamicStructuredTool`](https://js.langchain.com/docs/modules/agents/tools/dynamic?ref=blog.langchain.com)；当然，直接继承基础的 [`Tool`](https://github.com/langchain-ai/langchainjs/blob/main/langchain-core/src/tools.ts?ref=blog.langchain.com) 类也同样简便易行。

```
import { Tool } from "@langchain/core/tools";

export class Calculator extends Tool {
  name = "calculator";
  description = "A tool for evaluating arithmetic expressions";

  constructor() {
    super();
  }

  protected _call = (expression: string): Promise<string> => {
    const tokens = this._extractTokens(expression);
    let answer;
    try {
      answer = this._evaluateExpression(tokens);
    } catch (error) {
      if (error instanceof Error) {
        answer = `Error: ${error.message}`;
      } else {
        answer = "Error: Unable to execute calculator tool.";
      }
    }
    return Promise.resolve(answer.toString());
  };

  _extractTokens = (expression: string): string[] => { ... };

  _evaluateExpression = (tokens: string[]): number => { ... };
}
```

When Lumos receives a prompt that resembles a math equation, simple or complex, it simply knows to invoke the calculator.

当 Lumos 接收到一个形似数学算式的提示（无论简单或复杂）时，它会自动调用计算器功能。

# Scaling Classification For Complex Conditionals 🌲

# 面向复杂条件判断的分类能力扩展 🌲

The classification technique is replicated again for [Lumos’s multimodal functionality](https://github.com/andrewnguonly/Lumos/blob/main/docs/multimodal.md?ref=blog.langchain.com). If a user asks about an image, the app should know to download the image from the page. Otherwise, it should skip the download for obvious efficiency reasons. I decided to generalize the approach and make a configurable function.

该分类技术在 [Lumos 的多模态功能](https://github.com/andrewnguonly/Lumos/blob/main/docs/multimodal.md?ref=blog.langchain.com) 中再次复用。若用户提问涉及某张图像，应用应能识别并从网页下载该图像；否则，出于显而易见的效率考量，应跳过下载步骤。我决定将这一方法泛化，封装为一个可配置的函数。

```
const classifyPrompt = async (
  baseURL: string,
  model: string,
  type: string,
  originalPrompt: string,
  classifcationPrompt: string,
  prefixTrigger?: string,
): Promise<boolean> => {
  // check for prefix trigger
  if (prefixTrigger) {
    if (originalPrompt.trim().toLowerCase().startsWith(prefixTrigger)) {
      return new Promise((resolve) => resolve(true));
    }
  }

  // otherwise, attempt to classify prompt
  const ollama = new Ollama({
    baseUrl: baseURL,
    model: model,
    temperature: 0,
    stop: [".", ","],
  });
  const finalPrompt = `${classifcationPrompt} Answer with 'yes' or 'no'.\n\nPrompt: ${originalPrompt}`;
  return ollama.invoke(finalPrompt).then((response) => {
    console.log(`${type} classification response: ${response}`);
    const answer = response.trim().split(" ")[0].toLowerCase();
    return answer.includes("yes");
  });
};
```

```
const classifyPrompt = async (
  baseURL: string,
  model: string,
  type: string,
  originalPrompt: string,
  classifcationPrompt: string,
  prefixTrigger?: string,
): Promise<boolean> => {
  // 检查前缀触发词
  if (prefixTrigger) {
    if (originalPrompt.trim().toLowerCase().startsWith(prefixTrigger)) {
      return new Promise((resolve) => resolve(true));
    }
  }

  // 否则，尝试对提示进行分类
  const ollama = new Ollama({
    baseUrl: baseURL,
    model: model,
    temperature: 0,
    stop: [".", ","],
  });
  const finalPrompt = `${classifcationPrompt} 请仅用“yes”或“no”作答。\n\nPrompt: ${originalPrompt}`;
  return ollama.invoke(finalPrompt).then((response) => {
    console.log(`${type} 分类响应：${response}`);
    const answer = response.trim().split(" ")[0].toLowerCase();
    return answer.includes("yes");
  });
};
```

Now, `classifyPrompt()` accepts a “classification prompt” and a trigger parameter. The function can be reused throughout the application code.

如今，`classifyPrompt()` 函数支持传入一个“分类提示（classification prompt）”和一个触发参数（trigger parameter），可在整个应用代码中复用。

现在，`classifyPrompt()` 函数接收一个“分类提示（classification prompt）”和一个触发参数（trigger parameter），可在整个应用代码中复用。

The decision to download an image is also predicated on the availability of a multimodal model (e.g. [LLaVA](https://ollama.com/library/llava?ref=blog.langchain.com)). A user must have downloaded one before issuing a prompt to describe an image. In Lumos, user configuration is also checked as part of the download decision.

是否下载图像，还取决于本地是否已部署多模态模型（例如 [LLaVA](https://ollama.com/library/llava?ref=blog.langchain.com)）。用户必须事先下载并运行此类模型，才能发出描述图像的提示。在 Lumos 中，用户的配置选项也会被纳入图像下载决策流程中一并检查。

```
import { getLumosOptions, isMultimodal } from "../pages/Options";

const CLS_IMG_TYPE = "isImagePrompt";
const CLS_IMG_PROMPT = "Is the following prompt referring to an image or asking to describe an image?";
const CLS_IMG_TRIGGER = "based on the image";

const options = await getLumosOptions();
```

```
import { getLumosOptions, isMultimodal } from "../pages/Options";

const CLS_IMG_TYPE = "isImagePrompt";
const CLS_IMG_PROMPT = "以下提示是否指向某张图像，或要求描述一张图像？";
const CLS_IMG_TRIGGER = "based on the image";

const options = await getLumosOptions();
```

```javascript
if (
  isMultimodal(options.ollamaModel) &&
  (await classifyPrompt(
    options.ollamaHost,
    options.ollamaModel,
    CLS_IMG_TYPE,
    prompt,
    CLS_IMG_PROMPT,
    CLS_IMG_TRIGGER,
  ))
) {
  // download images
  ...
}
```

```javascript
如果 (
  isMultimodal(options.ollamaModel) &&
  (await classifyPrompt(
    options.ollamaHost,
    options.ollamaModel,
    CLS_IMG_TYPE,
    prompt,
    CLS_IMG_PROMPT,
    CLS_IMG_TRIGGER,
  ))
) {
  // 下载图像
  ...
}
```

Including the classification result in an if-statement expression felt natural, simple, and effective. With this method, a developer has full control over the execution of an application. To some degree, code branches that depend on LLMs potentially become testable!

将分类结果直接嵌入 `if` 语句表达式中，显得自然、简洁且高效。借助这种方法，开发者能够完全掌控应用程序的执行流程。在某种程度上，依赖大语言模型（LLM）决策的代码分支也因此具备了可测试性！

For Lumos to determine whether an image is downloaded or not, the classification result is combined with the user’s configuration state. Moreover, consistent decision-making based on combining complex application states (e.g. user configuration, access controls, cache state, etc) and classification results may be more challenging for LLMs to accomplish at scale.

为了让 Lumos 判断是否需要下载图像，系统将分类结果与用户的配置状态相结合。此外，若需基于复杂应用状态（例如用户配置、访问控制、缓存状态等）与分类结果共同做出一致、可靠的决策，这对 LLM 在大规模场景下的能力提出了更高挑战。

A/B testing several LLM features at once may benefit from this approach. For sensitive use cases such as permissioned tool execution or privileged data access for RAG, this design may be attractive. No decision can be left to chance.

同时对多个 LLM 功能开展 A/B 测试时，这种设计方式尤为受益。对于权限管控类工具调用或 RAG 场景中涉及敏感数据访问等高风险用例，该架构更具吸引力——任何关键决策都不应交由“偶然性”决定。

## What’s Next For Lumos? 🔮

## Lumos 的下一步？🔮

In the short term, I’ll continue to explore [integrating more tools](https://js.langchain.com/docs/integrations/tools?ref=blog.langchain.com) into Lumos. I’ll evaluate the benefits of migrating to an Agent architecture and chip away at some of the known efficiency and speed challenges with running local LLM apps.

短期内，我将持续探索将更多工具集成进 Lumos，例如 [LangChain 工具集成库](https://js.langchain.com/docs/integrations/tools?ref=blog.langchain.com)。我还将评估迁移到 Agent 架构的收益，并逐步攻克本地运行 LLM 应用时已知的效率与性能瓶颈。

In the long term, however, there is a bigger opportunity to consider. A Chrome extension is powerful, but it is still very limited in its capability. As I’m thinking through new use cases for LLMs in the browser, it’s worth examining whether or not a new browser is needed altogether. For now, these are just ideas. In the meantime, I’ll just enjoy the rollercoaster that is building LLM apps at this early and exciting time. LangChain and Ollama make the ride a little bit smoother. 😎

但从长远来看，一个更宏大的机遇值得思考：Chrome 扩展虽功能强大，但其能力依然十分有限。当我深入构思 LLM 在浏览器环境中的全新应用场景时，或许值得认真探讨——我们是否需要从头打造一款专为 LLM 优化的新浏览器？目前这些尚属初步构想。而当下，我愿尽情享受这一早期却激动人心的 LLM 应用开发过山车之旅。LangChain 与 Ollama 让这段旅程变得稍加平顺。😎

## References

## 参考资料

1. [Lumos (GitHub)](https://github.com/andrewnguonly/Lumos?ref=blog.langchain.com)  
1. [Lumos（GitHub 仓库）](https://github.com/andrewnguonly/Lumos?ref=blog.langchain.com)  

2. [Local LLM in the Browser Powered by Ollama (Part 1)](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-236817f335da?ref=blog.langchain.com)  
2. [基于 Ollama 的浏览器端本地大语言模型（第一部分）](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-236817f335da?ref=blog.langchain.com)  

3. [Local LLM in the Browser Powered by Ollama (Part 2)](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-part-2-6eb10caf39a1?ref=blog.langchain.com)  
3. [基于 Ollama 的浏览器端本地大语言模型（第二部分）](https://medium.com/@andrewnguonly/local-llm-in-the-browser-powered-by-ollama-part-2-6eb10caf39a1?ref=blog.langchain.com)  

4. [Let’s Normalize Online, In-Memory RAG! (Part 3)](https://medium.com/@andrewnguonly/lets-normalize-online-in-memory-rag-88e8169e9806?ref=blog.langchain.com)  
4. [让我们标准化在线、内存驻留型 RAG！（第三部分）](https://medium.com/@andrewnguonly/lets-normalize-online-in-memory-rag-88e8169e9806?ref=blog.langchain.com)
{% endraw %}
