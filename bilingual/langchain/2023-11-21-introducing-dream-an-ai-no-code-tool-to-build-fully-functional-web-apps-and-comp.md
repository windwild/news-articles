---
title: "Introducing Dream – an AI no-code tool to build fully functional web apps and components with natural language"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-dream/"
date: "2023-11-21"
scraped_at: "2026-03-03T08:25:41.822131689+00:00"
language: "en-zh"
translated: true
---

I’m Calix, and I’m currently a sophomore at USC Iovine & Young Academy. For my hacker residency at LangChain, I continued working on my project, Dream.

我是 Calix，目前是南加州大学（USC）Iovine & Young 学院的大二学生。在 LangChain 的黑客驻留项目期间，我继续推进我的项目——Dream。

Dream is an AI no-code tool to build fully functional web apps and components with natural language. Whether it’s an AI app, a game, or an internal tool, Dream is a way for any technical or non-technical person to build and deploy functional websites. Users on Dream can create website projects, they can create pages within each project, and within each page, they can generate sections that can either be design or functionality-focused. Each section acts as a component, whether it's a navigation bar or a blog post generator. Integrations like database storage, authentication, or APIs (OpenAI, Twilio, etc.) are built as modular functions, specifically selected for each section’s generation/regeneration. Upon publishing the project, all of the pages and sections are compiled together and deployed to a custom domain.

Dream 是一款基于 AI 的无代码工具，支持用户仅通过自然语言即可构建功能完备的网页应用与组件。无论是 AI 应用、游戏，还是内部工具，Dream 都能让技术背景或非技术背景的用户轻松构建并部署可运行的网站。Dream 用户可以创建网站项目；在每个项目中创建页面；并在每一页中生成若干区块（section），这些区块可聚焦于设计或功能。每个区块都作为一个独立组件运作——例如导航栏、博客文章生成器等。数据库存储、身份认证或各类 API（如 OpenAI、Twilio 等）集成，则以模块化函数形式实现，并根据每个区块的生成/重生成需求被精准调用。当项目发布后，所有页面与区块将被统一编译，并部署至用户自定义域名。

## Getting started

## 入门指南

At the beginning of my residency, Dream was at a semi-completed stage. I had started Dream back in the summer, thinking “If GPT-4 can generate code, can it generate functional web apps with enough iterations?” I was then working on the 3rd version of Dream, each version becoming more focused on performance, extensibility, and generation quality. Many of the big shifts between each version involved breaking up language operations to become more modular and organized so that the output quality could consistently improve as users iterated on their projects.

驻留项目启动之初，Dream 已处于半成品阶段。我早在去年夏天便启动了 Dream 项目，当时思考的问题是：“如果 GPT-4 能生成代码，那它能否通过足够多的迭代，生成真正可用的网页应用？”彼时我正开发 Dream 的第三个版本——每一版都更聚焦于性能、可扩展性与生成质量。各版本间的关键演进，大多围绕着将语言处理流程拆解为更模块化、更结构化的单元，从而确保用户在反复迭代项目过程中，输出质量能持续提升。

At the start, I just wanted to make a few improvements to the code generation process and improve the UX, but it continually grew into a longer, more ambitious roadmap. Here are all of the improvements I made to Dream, and how I did it.

最初，我本只想对代码生成流程做几处优化，并小幅改善用户体验；但随着探索深入，这一目标不断延展，最终演化成一份更长、更具雄心的路线图。以下是我为 Dream 所做的全部改进，以及具体实现方式。

## UX for prompt enhancement

## 提示词增强的用户体验设计

The ultimate goal of Dream is to become an all-encompassing platform for anyone (especially non-technical people) to build functional software and share it with the world without coding or facing a steep learning curve. So, the first major problem I tackled was building a comprehensive UX for a non-technical audience.

Dream 的终极目标，是打造一个面向所有人的全能型平台——尤其服务于非技术背景用户——让他们无需编写代码、也无需跨越陡峭的学习曲线，即可构建出功能完备的软件，并将其分享给全世界。因此，我着手解决的第一个重大问题，便是为非技术用户构建一套完整、易用的用户体验（UX）体系。

There were many questions to be answered. How do you build a platform to empower a user to turn thoughts into words, and words into code? How do you convey an experience that helps the user clearly articulate what they want in their project, even when most of the time they don’t even know what they want? How do you balance user-directed context/instructions with AI-directed decisions in generations? And the hardest one, how do you help a user debug their project and handle unforeseen edge cases from a non-technical perspective?

这背后涉及诸多亟待解答的问题：如何构建一个平台，赋能用户将脑海中的想法转化为文字，再将文字转化为可运行的代码？如何设计一种体验，帮助用户清晰表达其项目需求——哪怕大多数时候，他们自己都不确定想要什么？如何在生成过程中，合理平衡“用户主导的上下文/指令”与“AI 主导的决策”？而最难的一点是：如何从非技术视角出发，协助用户调试项目、应对那些意料之外的边界情况？

I wrestled with these questions over the 10 weeks and continued to think about ways to optimize the user’s experience.

在为期十周的驻留中，我持续与这些问题角力，并不断思考优化用户体验的可行路径。

I first tried to build a conversational agent to guide the user through their thoughts and articulate what they wanted to build. However, it was hard to properly detect the end of a user’s articulation without either cutting them off early or droning on for way too long and being way too specific.

我最初尝试构建一个对话式智能体（conversational agent），引导用户梳理思路、明确其想构建的内容。然而，要准确判断用户表达的结束时机十分困难——要么过早打断用户，要么则陷入冗长、过度具体的追问之中。

Then, I tried to take a survey approach, asking a set of templated, open-ended questions, forcing the user to spill cognitive context. This worked much better, but it was still not a great input for my code generation inference.

接着，我尝试采用问卷调查的方式，向用户提出一组模板化的开放式问题，强制其主动输出认知上下文。这种方式效果明显更好，但对我的代码生成推理任务而言，输入质量仍不够理想。

Finally, I wrestled with a few different iterations to build out what’s currently being used. First, the user fills out a templated survey with open-ended questions and some multiple-choice answers that direct the logical flow of the survey. Then, using that context, an overview of the section or modification being generated is created, and from that, the integrations/data sources as well as a technical scope of the generation are created and displayed to the user for approval. After it’s user-approved, it passes the overview and the technical scope as context, allowing a detailed technical explanation to be generated from a few simple answers from the user survey.

最后，我经过多次迭代打磨，构建出当前正在使用的方案：首先，用户填写一份模板化问卷，其中包含开放式问题及若干引导问卷逻辑走向的多选题；随后，系统基于该问卷内容生成待生成模块或修改项的概览；再进一步，据此推导出所需集成/数据源以及技术实现范围，并将这两部分内容呈现给用户审批；待用户确认后，系统将概览与技术范围作为上下文输入，仅凭用户问卷中的几个简明回答，即可生成详尽的技术说明。

### Improving custom integrations

### 改进自定义集成能力

One of the most important features that makes Dream versatile and dynamic is custom integrations. Dream has pre-built integrations to services and functions that users commonly need, like OpenAI or file extraction. But, Dream users also needed to use integrations and APIs that weren’t already pre-built. This is where custom integrations came in. Previously, Dream had enabled custom integrations by requiring the user to specify all the details of the specific endpoints and API calls they wanted. This still required technical knowledge and a clear vision of the project, which were both pretty big barriers.

让 Dream 具备高度灵活性与动态适应能力的最重要特性之一，便是自定义集成能力。Dream 已预置了用户高频使用的各类服务与功能集成（例如 OpenAI、文件提取等），但用户也常常需要接入尚未预置的第三方集成与 API——这正是自定义集成的用武之地。此前，Dream 实现自定义集成的方式是要求用户手动指定目标端点（endpoint）和 API 调用的所有细节。这种方式仍需用户具备一定的技术背景，且对项目整体架构有清晰构想，而这二者恰恰构成了较高的使用门槛。

The new experience I wanted was similar to Cursor — a user can drop a link to the documentation of the integration they want to add, the documentation will be scraped and saved in memory, and the new integration can be used by just mentioning it semantically and describing the desired functionality.

我期望打造的新体验，类似于 Cursor：用户只需提供待接入集成的官方文档链接，系统便会自动抓取并存入内存；此后，用户仅需在自然语言描述中语义化地提及该集成，并说明所需功能，即可直接调用。

My first approach to building this out was simple: scrape all of the unique links that held the same apex domain (ex. “docs” subdomain), scrape all the content off each page, chunk + embed it, and then retrieve relevant chunks upon generation time. The issue became clear: there was so much hidden gibberish content and metadata on the pages that the retrieval became continually more inaccurate.

我的第一版实现方案较为直接：抓取同一根域名下（例如 “docs” 子域名）所有唯一链接，逐页提取全部内容，分块并嵌入向量空间，最终在生成阶段检索相关文本块。问题很快浮现：网页中充斥着大量隐藏的无意义内容与冗余元数据，导致检索结果持续失准。

My second approach was to scrape all of the page contents but then use LangChain’s contextual compression upon generation time to chunk and retrieve relevant documents to use. This produced better results, but the context window was extremely long, making retrieval much more expensive and still relatively inaccurate.

第二版方案改为：仍抓取全部页面内容，但在生成阶段借助 LangChain 的上下文压缩（contextual compression）机制进行动态分块与相关文档检索。该方案效果有所提升，但上下文窗口过长，不仅显著增加计算开销，检索精度仍不够理想。

Finally, the approach I settled on utilized both embeddings and Claude 2. I realized that I just needed to scrape the content off of the API reference and pages that included information about REST API information specifically (not SDKs!). To do this, I used Claude 2’s 100k context window and some basic regular expression matching to classify the content of each page to determine if it was relevant to be scraped. After filtering, all of the page content would be chunked and embedded. Upon generation time, relevant vectors are queried and then compressed using LangChain contextual compression.

最终，我确定采用融合嵌入向量（embeddings）与 Claude 2 的混合方案。我意识到，真正需要抓取的，仅限于 API 参考文档及明确介绍 REST API 接口信息的网页（而非 SDK 文档！）。为此，我利用 Claude 2 高达 100K 的上下文窗口，辅以基础正则表达式匹配，对每一页内容进行分类判定，精准筛选出值得抓取的相关页面。筛选完成后，所有保留页面内容被分块并嵌入向量空间；在生成阶段，则先查询相关向量，再通过 LangChain 的上下文压缩机制进一步精炼检索结果。

## Migrating generation output from HTML/JS to React

## 将生成输出从 HTML/JS 迁移至 React

Before, Dream was generating raw HTML with TailwindCSS and vanilla JS for function calling and integrations. I knew this system had to change and with the support from LangChain (s/o Jacob!) I decided to migrate all projects to generating React instead. There were a few reasons behind this decision:

此前，Dream 生成的是原生 HTML（配合 TailwindCSS 样式）与纯 JavaScript（用于函数调用与集成）。我深知这一系统亟需重构；在 LangChain 团队（特别感谢 Jacob！）的支持下，我决定将所有项目全面迁移至 React 生成方案。这一决策背后有若干关键原因：

React was cleaner, more versatile, and easier to work with  

React 更简洁、更灵活，也更易于开发。

2\. The context and completion lengths of my inference were getting too long since raw HTML/JS isn’t as token-efficient as React  

2．我的推理任务中上下文与补全长度变得过长，因为原生 HTML/JS 在 token 使用效率上远不如 React。

3\. It opened up the opportunity to work with pre-built components and UI libraries that would normally take up a lot of tokens to write logic and styling for  

3．这让我得以利用现成的组件和 UI 库——若手动编写其逻辑与样式，通常会消耗大量 token。

Making the change wasn’t too hard since it was mainly a change in the prompts, but I took a good amount of time to set up the context to instruct GPT-4 how to properly use the UI component libraries I was feeding it (for now, shadcn UI). Just like integrations, I set up an LLM selection pipeline to select the UI components that were most relevant to the generation being made, so that the context length could be cut as short as possible and my inference calls were more specific and modular.  

这一转变本身并不困难，主要在于调整提示词（prompts）；但我花费了相当多的时间来构建上下文，以指导 GPT-4 正确使用我提供给它的 UI 组件库（目前是 shadcn UI）。与集成其他服务类似，我还构建了一条 LLM 选择流水线（LLM selection pipeline），用于动态筛选出与当前生成任务最相关的 UI 组件，从而将上下文长度压缩至最短，使我的推理调用更加精准且模块化。

## Pivot prompting style and context management  

## 调整提示风格与上下文管理

I was pretty happy with the improvements I had been making, but randomly on Hacker News, I came across openv0. It was an open-source build of v0, a popular platform that Vercel had been promoting in private beta in the first few weeks of my hacker residency. I was well aware of v0 and what directions they wanted to take with it and didn’t necessarily feel threatened.  

我对已取得的改进颇为满意；但偶然间，在 Hacker News 上，我发现了 openv0——这是 v0 的一个开源实现。v0 是 Vercel 在我参与黑客驻留计划（hacker residency）初期几周内正以私有 Beta 形式大力推广的热门平台。我对 v0 及其发展方向早已有所了解，因此并未感到明显威胁。

With openv0 being open-source, I got the opportunity to see how someone else was approaching the problem of optimizing generation quality. As I looked through the repo, I saw a lot of opportunities on how I could clean up my code and manage my context templates and dynamic injections a lot cleaner and more effectively.  

得益于 openv0 的开源属性，我得以观察他人如何优化生成质量。在浏览其代码仓库时，我发现了诸多可借鉴之处：例如如何精简自身代码，以及如何更清晰、更高效地管理上下文模板与动态注入逻辑。

More importantly, I made a strong pivot from my previous prompting strategy, which was heavily example-based. I had 3 custom-written section examples put into the context to guide the inference to follow specific output formats, but it ended up commonly generating designs that were all very similar and clearly showed bias in certain edge case generations. With inspiration from openv0, I fully removed my contextual examples and shortened my context window by a great deal while still maintaining good quality and improving the model’s design flexibility.  

更重要的是，我彻底转向了全新的提示策略，放弃了此前高度依赖示例（example-based）的老方法。过去，我在上下文中嵌入了 3 个手工编写的章节示例，用以引导模型遵循特定输出格式；但结果却常常生成高度雷同的设计，并在某些边界场景下暴露出明显的生成偏差。受 openv0 启发，我完全移除了所有上下文示例，大幅缩短了上下文窗口长度，同时不仅保持了良好的生成质量，还显著提升了模型在设计层面的灵活性。

## Conclusion  

## 结语

Throughout the 10-week residency, I made so many more changes and improvements to Dream than I had initially imagined. Over a few months, I realized that a platform like Dream is not one that’s well-suited for a scrappy approach but rather requires a detailed, thoughtful approach with a lot of engineering time.  

在为期 10 周的黑客驻留期间，我对 Dream 所做的修改与优化，远超我最初的设想。经过数月实践，我逐渐意识到：像 Dream 这样的平台，并不适合“快速试错、野蛮生长”（scrappy）式的开发路径；它更需要一种细致入微、深思熟虑的工程化方法，并投入大量扎实的工程时间。

Non-technical stakeholders trying to build software has been a long-standing problem, and the existing solutions like Bubble have steep learning curves of their own.  
非技术背景的利益相关者尝试构建软件，长期以来一直是个难题；而 Bubble 等现有解决方案自身也存在陡峭的学习曲线。

Code generation is still a very hard technical process to build for in production, and designing an intuitive interface around it is very hard.  
在生产环境中构建代码生成能力仍是一项极具挑战性的技术任务，围绕它设计出直观易用的界面更是难上加难。

Non-deterministic platforms still do not have design standards, which gave me the freedom to design completely new modes of interaction.  
目前，非确定性平台尚无统一的设计规范，这为我提供了充分自由，去设计一套全新的交互范式。

Dream is still a huge work in progress and the last 10 weeks have been a challenge, but I’m excited to continue to improve the platform and hopefully enable non-technical founders, designers, and others to build software that they could never before.  
Dream 仍处于大规模开发阶段，过去十周充满挑战；但我非常期待持续优化这一平台，并希望最终赋能非技术背景的创始人、设计师及其他用户，构建他们此前根本无法实现的软件。

Huge shout out to LangChain and my mentor Jacob Lee for the support over the last 10 weeks!  
衷心感谢 LangChain 及我的导师 Jacob Lee 在过去十周给予的大力支持！  

It’s been extremely helpful to have technical guidance on a lot of the problems that I tackled, and it helped me accelerate my engineering time by a lot.  
针对我所攻克的诸多技术难题，获得专业指导极为宝贵；这极大缩短了我的工程实现周期。