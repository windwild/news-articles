---
title: "Eval-driven development: Build better AI faster - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/eval-driven-development-build-better-ai-faster"
date: "2024-10-17"
scraped_at: "2026-03-02T09:40:12.166921558+00:00"
language: "en-zh"
translated: true
description: "Learn how eval-driven development helps you build better AI faster. Discover a new testing paradigm for AI-native development and unlock continuous improvement."
---

Oct 17, 2024

2024 年 10 月 17 日

A look at Vercel's philosophy and techniques in AI-native development.

一窥 Vercel 在 AI 原生开发中的理念与实践方法。

AI changes how we build software. In combination with developers, it creates a positive feedback loop where we can achieve better results faster.

AI 正在改变我们构建软件的方式。当 AI 与开发者协同工作时，便形成一种正向反馈循环，使我们能够更快地取得更优成果。

However, traditional testing methods don't work well with AI's unpredictable nature. As we've been building AI products at Vercel, including v0, we've needed a new approach: eval-driven development.

然而，传统的测试方法难以应对 AI 固有的不可预测性。在 Vercel 开发 AI 产品（包括 v0）的过程中，我们亟需一种新范式：评估驱动开发（eval-driven development）。

This article explores the ins and outs of evals and their positive impact on AI-native development.

本文将深入探讨“评估”（evals）的方方面面，及其对 AI 原生开发所产生的积极影响。

## Evals: The new testing paradigm

## 评估（Evals）：新一代测试范式

Evaluations (evals) are like end-to-end tests for AI and other probabilistic systems. They assess output quality against defined criteria using automated checks, human judgment, and AI-assisted grading. This approach recognizes inherent variability and measures overall performance—not individual code paths.

评估（evals）类似于面向 AI 及其他概率型系统的端到端测试。它们通过自动化校验、人工判断和 AI 辅助评分等方式，依据预设标准对模型输出质量进行综合评估。该方法承认系统输出天然存在的变异性，关注的是整体性能表现，而非某一条具体代码路径。

![Evals complement your existing test suite.](images/eval-driven-development-build-better-ai-faster-vercel/img_001.jpg)![Evals complement your existing test suite.](images/eval-driven-development-build-better-ai-faster-vercel/img_002.jpg)Evals complement your existing test suite.

![评估（Evals）是对您现有测试套件的有力补充。](images/eval-driven-development-build-better-ai-faster-vercel/img_001.jpg)![评估（Evals）是对您现有测试套件的有力补充。](images/eval-driven-development-build-better-ai-faster-vercel/img_002.jpg)评估（evals）是对您现有测试套件的有力补充。

There are three primary types of evals:

主要存在三类评估（evals）：

- **Code-based grading:** Automated checks that use code are ideal for objective criteria and fast feedback. For example, you can check if AI output contains a specific keyword or matches a regular expression. Unfortunately, you can’t code every type of eval

- **基于代码的评分（Code-based grading）**：利用代码实现的自动化校验，适用于客观性标准且能提供快速反馈。例如，可检查 AI 输出是否包含特定关键词，或是否匹配某一正则表达式。遗憾的是，并非所有类型的评估都能通过编码实现。

- **Human grading:** Leveraging human judgment for subjective evaluations is essential for nuanced assessments of quality and creativity. This is particularly useful for evaluating the clarity, coherence, and overall effectiveness of generated text  

- **人工评分：** 借助人类判断开展主观性评估，对于细致入微地衡量内容质量与创造性至关重要。该方法尤其适用于评估生成文本的清晰度、连贯性及整体有效性。

- **LLM-based grading:** Using other AI models to assess the output offers scalability for complex judgments. While potentially less reliable than human grading, this approach is more cost-effective and efficient for large-scale evaluations. Note that LLM evals still cost 1.5x to 2x more than code-based grading  

- **基于大语言模型（LLM）的评分：** 利用其他AI模型对输出结果进行评估，可为复杂判断提供良好的可扩展性。尽管其可靠性可能低于人工评分，但该方法在大规模评估场景下更具成本效益和执行效率。需注意：LLM评估的成本仍比基于代码的评估高出1.5至2倍。

### From deterministic to probabilistic  

### 从确定性到概率性  

So, why do we need evals?  

那么，我们为何需要评估（evals）？  

With defined inputs, code produces predictable outputs: two plus two always equals four. Developers can use unit and automated testing to ensure quality.  

当输入明确时，代码会产生可预测的输出：例如，“2加2”永远等于“4”。开发者可通过单元测试和自动化测试来保障软件质量。  

LLMs, however, introduce probabilistic behavior. They operate as black boxes, making their responses difficult to predict. It's less like "two plus two" and more like predicting tomorrow's weather.  

大语言模型（LLMs）则引入了概率性行为。它们以“黑箱”方式运行，导致其响应难以准确预测——这不像“2加2”那样确定，而更接近于预测明天的天气。  

That's where evals come in. By adopting a framework that emphasizes continuous evaluation and refinement of non-deterministic outputs, developers can effectively use variable AI systems without compromising quality, reliability, and observability.  

这正是评估（evals）发挥作用之处。通过采用一种强调对非确定性输出持续评估与迭代优化的框架，开发者便能在不牺牲质量、可靠性与可观测性的前提下，高效利用具有可变性的AI系统。

### Lessons from search engines  

### 来自搜索引擎的启示  

This shift—from tests to evals—echoes challenges faced by web search engineers over the past two decades. Dealing with the web's vastness and unpredictable user queries, they recognized early on that exhaustive, hard-coded testing wasn't feasible.  

这一转变——即从传统测试转向评估（evals）——呼应了过去二十年间网络搜索工程师所面临的诸多挑战。面对互联网的海量信息与用户查询的高度不确定性，他们很早就意识到：穷尽式、硬编码的测试并不可行。  

Search quality teams adapted by using eval-centric processes, acknowledging that any change could bring improvements and regressions. While slower and more subjective than traditional testing, this eval-driven approach was most effective for improving search quality in a complex, non-deterministic environment.  

搜索质量团队随之转向以评估为中心的工作流程，承认每一次变更都可能带来改进，也可能引发退化。尽管这种以评估驱动的方法比传统测试更慢、主观性更强，但它被证明是在复杂、非确定性环境中提升搜索质量最有效的方式。

### Eval example: Generating a React component

### 评估示例：生成一个 React 组件

Let's look at an example: Imagine building an AI assistant that helps developers write React components based on user descriptions. How would you evaluate the output?

我们来看一个例子：假设你要构建一个 AI 助手，帮助开发者根据用户描述编写 React 组件。你将如何评估其输出？

**System prompt:** Generate a React functional component (arrow function) that displays a list of items. The component should accept an array of strings as props and render each string as a list item. Style the list using Tailwind CSS.

**系统提示：** 生成一个 React 函数式组件（箭头函数），用于展示一个项目列表。该组件应接收一个字符串数组作为 props，并将每个字符串渲染为一个列表项。使用 Tailwind CSS 对列表进行样式设置。

**User:** Create a component called `ItemList` that takes an array of item names and displays them in an unordered list. Each item should be displayed in bold font.

**用户：** 创建一个名为 `ItemList` 的组件，接收一个项目名称数组，并在无序列表中显示它们。每个项目应以粗体字体显示。

**Expected:**

**期望输出：**

```jsx
import React from "react";



const ItemList = ({ items }) => (

4  <ul className="list-none p-0">

5    {items.map((item, index) => (

6      <li key={index} className="font-bold">

6      <li key={index} className="font-bold">

7        {item}

7        {item}

8      </li>

8      </li>

9    ))}

9    ))}

10  </ul>

10  </ul>

11);



11);



export default ItemList;
```

```jsx
export default ItemList;
```

**Actual:**

**实际效果：**

```jsx
import React from "react";
```

```javascript
function ItemList(props) {

4  return (

5    <ul>

6      {props.items.map((item) => (

7        <li style={{ fontWeight: "bold" }}>{item}</li>

8      ))}

9    </ul>

10  );

11}
```

```javascript
function ItemList(props) {

4  返回 (

5    <ul>

6      {props.items.map((item) => (

7        <li style={{ fontWeight: "bold" }}>{item}</li>

8      ))}

9    </ul>

10  );

11}
```

```js
export default ItemList;
```

```js
export default ItemList;
```

In this example, the AI-generated code is functional but deviates from the expected, opinionated output.

在此示例中，AI 生成的代码虽可正常运行，但偏离了预期的、带有明确风格倾向（opinionated）的输出。

- **Styling:** The expected output uses Tailwind CSS classes (`list-none p-0`, `font-bold`), but the actual output uses inline styles  
- **样式：** 预期输出使用 Tailwind CSS 类（如 `list-none p-0`、`font-bold`），而实际输出却采用了内联样式（inline styles）

- **Key prop:** The expected output correctly includes the `key` prop for list items, but the actual output omits this  
- **key 属性：** 预期输出为列表项正确添加了 `key` 属性，而实际输出遗漏了该属性

- **Component definition:** The expected output uses an arrow function component, but the actual output uses a traditional function component  
- **组件定义方式：** 预期输出采用箭头函数组件（arrow function component），而实际输出则使用传统函数组件（traditional function component）

Evals assess not only basic functionality but also code quality, style, and adherence to arbitrary best practices. These differences can be subtle, but evals provide a mechanism for quantifying and addressing them.

评估（Evals）不仅考察基础功能是否实现，还衡量代码质量、编码风格以及对各类（哪怕是主观设定的）最佳实践的遵循程度。这些差异可能十分细微，但评估机制恰恰为此类差异提供了可量化、可追踪、可改进的途径。

For example, we could detect these nuances with:  

例如，我们可通过以下方式识别上述细微差异：

- **Code-based grading**: Regex for inline styles vs. Tailwind classes, or checking for the presence of `key` props  
- **基于代码的自动评分：** 使用正则表达式区分内联样式与 Tailwind 类名，或检查是否包含 `key` 属性

- **Human grading**: A domain expert or end user looks at the generated code and presses a thumb up or down, optionally providing comments  
- **人工评分：** 由领域专家或终端用户审阅生成的代码，并点击“赞”或“踩”进行反馈，还可选择性地附加评注

- **LLM-based grading**: Training a small model to compare the generated code against the expected output  
- **基于大语言模型的评分（LLM-based grading）**：训练一个小型模型，将生成的代码与预期输出进行比对。

Most importantly, any of these methods should provide a clear score across the domains you wish to evaluate. This makes it easy to tell whether the AI is improving or regressing on these criteria.  
最重要的是，上述任一方法都应在您希望评估的所有维度上提供清晰的得分。这使得我们能够轻松判断 AI 在这些指标上是持续进步，还是出现退化。

This analysis can then inform further fine-tuning and refinement of the model, leading to more reliable AI generation. And this is where evals become much more powerful.  
随后，该分析可为模型的进一步微调与优化提供依据，从而提升 AI 生成结果的可靠性。也正是在此处，评估（evals）展现出更强大的价值。

## The AI-native flywheel  
## AI 原生飞轮（AI-native flywheel）

Evals aren't just a replacement for traditional tests. In combination with high-quality data, great models and strategies, and user feedback, they become the engine of a new development cycle that we like to call the AI-native flywheel.  
评估（evals）远不止是传统测试的替代品。当它与高质量数据、优秀的模型与策略，以及用户反馈相结合时，便成为一种全新开发范式的引擎——我们称之为“AI 原生飞轮”。

![](images/eval-driven-development-build-better-ai-faster-vercel/img_003.jpg)![](images/eval-driven-development-build-better-ai-faster-vercel/img_004.jpg)  
![](images/eval-driven-development-build-better-ai-faster-vercel/img_003.jpg)![](images/eval-driven-development-build-better-ai-faster-vercel/img_004.jpg)

This positive feedback loop accelerates development and ensures your AI systems consistently improve. With it, you can use AI in more and more places to further improve processes.  
这一正向反馈循环可加速开发进程，并确保您的 AI 系统持续优化。借助它，您能将 AI 应用于越来越多的场景，从而进一步改进各项业务流程。

### Evals  
### 评估（Evals）

Evals are the foundation of AI development. They give you critical feedback about the strengths and weaknesses of your AI, replacing gut feelings with data-driven decisions and guiding your development process.  
评估是 AI 开发的基石。它们为您提供关于 AI 能力优势与短板的关键反馈，以数据驱动的决策取代主观直觉，并切实引导您的开发流程。

Effectively using and keeping track of your evals, however, is a whole other challenge. Methods can often be ad-hoc, relying on manual review or generic benchmarks. This doesn't scale well and lacks the specificity needed for targeted improvements.  
然而，如何高效地使用并系统化管理您的评估工作，本身又是一项全新挑战。当前方法往往具有临时性，依赖人工评审或通用基准测试，既难以规模化，也缺乏支撑精准优化所需的特异性。

You can use tools like [Braintrust](https://www.braintrust.dev/) to enable automated evaluations based on LLM evaluators, heuristics, and comparative analysis. It can help you integrate real-world feedback loops, incorporating production logs and user interactions into the evaluation data.

您可以使用 [Braintrust](https://www.braintrust.dev/) 等工具，基于大语言模型（LLM）评估器、启发式规则和对比分析，实现自动化评估。该工具可帮助您构建真实世界的反馈闭环，将生产日志与用户交互数据纳入评估体系。

### Data

### 数据

Robust evals are also key to pinpointing data gaps and target your data collection efforts. High-quality data fuels effective AI; _garbage in, garbage out_ still applies. With [golden data](https://vercel.com/blog/how-to-build-scalable-ai-applications#data-cleansing-and-management), you gain leverage for better fine-tuning and post-training techniques, improving overall system performance.

健全的评估体系同样是精准识别数据缺口、定向优化数据采集工作的关键。高质量的数据是高效 AI 的基石；“垃圾进，垃圾出”（_garbage in, garbage out_）这一原则依然适用。借助[黄金数据（golden data）](https://vercel.com/blog/how-to-build-scalable-ai-applications#data-cleansing-and-management)，您可更有效地开展微调与训后优化，从而全面提升系统性能。

Every new data source requires appropriate evals to ensure the AI effectively uses it without hallucinations or other issues.

每新增一个数据源，都需配套开展相应的评估，以确保 AI 能够有效利用该数据，避免幻觉（hallucinations）及其他问题。

### Models and strategies

### 模型与策略

The AI landscape changes daily with new models and research. Evals can help you navigate this by enabling rapid testing of different models and strategies against your defined criteria.

AI 领域日新月异，新模型与新研究成果层出不穷。评估体系可助您从容应对这一变化——通过快速测试不同模型与策略，并将其与您预设的评估标准进行比对。

This allows you to identify the optimal combination of model, [data augmentation](https://sdk.vercel.ai/docs/guides/rag-chatbot), and [prompting techniques](https://sdk.vercel.ai/docs/advanced/prompt-engineering) for the best accuracy, performance, and cost-effectiveness.

由此，您可甄选出在准确性、性能与成本效益三方面均表现最优的模型、[数据增强（data augmentation）](https://sdk.vercel.ai/docs/guides/rag-chatbot) 方法及[提示工程（prompting techniques）](https://sdk.vercel.ai/docs/advanced/prompt-engineering) 组合。

Note that the [AI SDK](https://sdk.vercel.ai/) (`npm i ai`), with its unified, type-safe abstraction layer, can simplify this process by allowing you to quickly switch between different providers and models with minimal code changes.

请注意，[AI SDK](https://sdk.vercel.ai/)（`npm i ai`）凭借其统一且类型安全的抽象层，可大幅简化该流程：您只需极少的代码改动，即可在不同服务商与模型之间快速切换。

### Feedback

### 反馈

Diverse feedback is crucial for continuous optimization. Direct, in-product feedback from real users gives you a clear look at how your AI performs in real-world scenarios. Consider these approaches:

多元化的反馈对于持续优化至关重要。来自真实用户的直接、嵌入产品内的反馈，能让您清晰洞察 AI 在真实场景中的实际表现。请考虑以下几种方式：

- **Explicit feedback:** Let users directly rate or review your AI's output. This could be a simple thumbs-up/thumbs-down, a star rating, or a detailed feedback form  

- **显式反馈：** 允许用户直接对 AI 的输出进行评分或评价。例如，可采用简单的“点赞/点踩”、星级评分，或更详尽的反馈表单。

- **Implicit feedback:** Track user behavior with your AI-powered features. For example, if users consistently rephrase or abandon queries, it might indicate issues with the AI's understanding  

- **隐式反馈：** 跟踪用户在使用 AI 功能时的行为数据。例如，若用户频繁修改查询语句或放弃提问，则可能表明 AI 对用户意图的理解存在缺陷。

- **Error reporting:** Implement robust error reporting to capture and analyze unexpected behavior. This helps identify and address bugs or limitations in your AI  

- **错误上报：** 建立健全的错误上报机制，以捕获并分析 AI 出现的异常行为。这有助于及时发现并修复 AI 中存在的程序缺陷或能力局限。

Combining these feedback types gives you a comprehensive understanding of your AI's strengths and weaknesses from a user's perspective. This feedback, fed directly into your evals, creates a continuous improvement cycle, driving the flywheel and ensuring your AI product constantly evolves.  

综合运用上述各类反馈，可从用户视角全面掌握 AI 的优势与不足。这些反馈被直接输入评估（evals）流程，从而构建起持续改进的闭环——推动飞轮效应，确保 AI 产品不断演进与优化。

## Vercel's v0: Eval-driven development in practice  

## Vercel 的 v0：评估驱动开发的实践典范  

Our flagship AI product, [v0](https://v0.dev/), is built on eval-driven development. Our multi-faceted evaluation strategy includes fast, reliable code checks, end user and internal human feedback, and LLM-based grading for complex judgments at scale. All this feedback pours back into evals.  

我们的旗舰 AI 产品 [v0](https://v0.dev/) 正是基于“评估驱动开发”（eval-driven development）构建而成。我们采用多维度评估策略，涵盖快速可靠的代码校验、终端用户与内部人员的人工反馈，以及基于大语言模型（LLM）的大规模复杂判断评分。所有这些反馈均回流至评估体系中。

This catches errors early, speeds up iteration, and drives continuous improvement based on real-world feedback. We iterate on prompts almost daily. Evals prevent regressions and ensure accurate source matching when updating RAG content.  

该机制有助于尽早发现错误、加速迭代周期，并依托真实世界反馈推动持续优化。我们几乎每天都会更新提示词（prompts）。评估体系有效防止功能退化，并在更新 RAG 内容时确保源信息匹配准确无误。

v0 allows you to generate user interfaces from text. Evals help us constantly improve the functionality, aesthetic, and efficiency of the code. (Generation sped up for demonstration.)  

v0 支持通过文本生成用户界面。评估体系助力我们持续提升所生成代码的功能性、视觉美感与运行效率。（演示中已加快生成速度。）

We prioritize refusal and safety evals, maintaining a 100% pass rate. While not all evals currently pass, we add new, failing prompts to the eval set for continuous improvement. When we add features like Vue or Python support, accompanying evals guarantee quality. Internal dogfooding provides invaluable feedback, helping us identify areas for improvement.  

我们高度重视拒答（refusal）与安全类评估，并始终保持 100% 的通过率。尽管并非所有评估项当前均能全部通过，但我们持续将新出现的失败用例（即触发失败的提示词）加入评估集，以实现持续改进。每当新增功能（如 Vue 或 Python 支持）时，配套的评估用例即同步上线，以保障交付质量。内部“自用先行”（dogfooding）为我们提供了极其宝贵的反馈，帮助我们精准识别待优化环节。

Code-based grading is particularly effective. Some of our checks for code quality include:  

基于代码的自动评分尤为高效。我们针对代码质量的部分检查项包括：

- Validating code blocks  
- 验证代码块的正确性  

- Ensuring correct imports  
- 确保导入语句正确无误  

- Confirming multi-file usage  
- 确认多文件调用逻辑的合理性  

- Verifying the balance of code comments versus actual code (correcting LLM laziness)  
- 核查代码注释与实际代码的比例（纠正大语言模型的“偷懒”倾向）  

An automated script runs the entire eval test suite and reports pass/fail rates, regressions, and improvements. Braintrust logs everything for manual review. Every GitHub pull request that impacts the output pipeline includes eval results.  
一套自动化脚本运行完整的评估测试套件，并报告通过率/失败率、性能退化情况及改进效果。Braintrust 会记录全部评估过程，供人工复核。所有影响输出流水线的 GitHub Pull Request 均附带本次评估结果。

Maintaining these evals presents an ongoing challenge and requires updates as the AI system evolves. We continue to look for ways to make managing the eval suite less time-consuming and more scalable, without totally giving up the human-in-the-loop.  
持续维护这些评估项本身即是一项长期挑战，需随 AI 系统的演进而动态更新。我们正不断探索更高效、更具可扩展性的评估套件管理方式，同时坚持保留“人在环路中”（human-in-the-loop）这一关键原则。

## The future of AI-native development  
## AI 原生开发的未来  

Eval-driven development is the foundation for building robust and innovative AI software. It empowers you to harness AI's potential without compromising quality, control, or user-centric design.  
以评估驱动的开发（Eval-Driven Development）是构建稳健且富有创新性的 AI 软件之基石。它使你得以充分释放 AI 的潜力，同时不牺牲质量、可控性或以用户为中心的设计理念。

The AI-native flywheel, with its continuous feedback loop, helps you navigate AI's complexities, iterate rapidly, and continuously improve. This process, combined with robust evaluation and a focus on UX, is key to creating intelligent and valuable applications.  
AI 原生飞轮（AI-native flywheel）依托持续的反馈闭环，助你驾驭 AI 的复杂性、快速迭代并持续优化。将这一机制与扎实的评估体系及对用户体验（UX）的专注相结合，正是打造智能、高价值应用的关键所在。

[**Bring any questions.**  
[**任何问题，欢迎提出。**  

\\  
Our engineers can recommend ways to build out scalable AI infrastructure from your existing codebase.  
\\  
我们的工程师可根据你现有的代码库，为你推荐构建可扩展 AI 基础设施的具体路径。  

\\  
Start a Conversation](https://vercel.com/contact/sales)  
\\  
开启对话](https://vercel.com/contact/sales)

Blog post

博客文章

Sep 20, 2024

2024 年 9 月 20 日

### AI SDK 3.4

### AI SDK 3.4

![](images/eval-driven-development-build-better-ai-faster-vercel/img_005.jpg)![](images/eval-driven-development-build-better-ai-faster-vercel/img_006.jpg)![](images/eval-driven-development-build-better-ai-faster-vercel/img_007.jpg)+2

Lars, Jared, and 2 others

Lars、Jared 及另外 2 人

Blog post

博客文章

Aug 12, 2024

2024 年 8 月 12 日

### How to build scalable AI applications

### 如何构建可扩展的 AI 应用

![](images/eval-driven-development-build-better-ai-faster-vercel/img_008.jpg)

Alice Alexandra Moore

爱丽丝·亚历山德拉·摩尔