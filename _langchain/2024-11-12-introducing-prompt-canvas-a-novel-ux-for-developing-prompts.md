---
render_with_liquid: false
title: "Introducing Prompt Canvas: a Novel UX for Developing Prompts"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-prompt-canvas/"
date: "2024-11-12"
scraped_at: "2026-03-03T07:48:58.629085529+00:00"
language: "en-zh"
translated: true
description: "Use Prompt Canvas in LangSmith to collaborate with an AI agent to build and optimize your prompts."
---
render_with_liquid: false
render_with_liquid: false

What it means to “build” applications is changing. When building AI applications, you are not just writing code - you’re also writing prompts. Tooling has evolved over the years to make software engineering more accessible - like code editors, code collaboration tools, pen testing, and more. We believe that tooling will emerge that makes **prompt engineering** just as accessible.

“构建”应用程序的内涵正在发生变化。在构建 AI 应用程序时，你不仅是在编写代码，同时也在编写提示词（prompts）。多年来，各类开发工具不断演进，使软件工程变得更加易用——例如代码编辑器、代码协作工具、渗透测试（pen testing）工具等。我们相信，未来将涌现出一系列新工具，让**提示工程（prompt engineering）** 同样变得触手可及。

To that end, we are excited to announce Prompt Canvas, a novel UX for developing prompts. On top of a better editing experience, it also facilitates the sharing of prompting best practices - a game changer in a new discipline like prompt engineering.

为此，我们很高兴地宣布推出 **Prompt Canvas**——一种专为提示词开发而设计的全新用户体验（UX）。它不仅提供了更优质的编辑体验，还支持提示工程最佳实践的共享——这对于提示工程这一新兴学科而言，堪称一次范式变革。

## **What Is Prompt Canvas?**

## **什么是 Prompt Canvas？**

![](images/introducing-prompt-canvas-a-novel-ux-for-developing-prompts/img_001.png)

Prompt Canvas is an interactive tool designed to simplify and accelerate the prompt-creation experience. With Prompt Canvas, you can collaborate with an LLM agent to iteratively build and refine your prompts. This approach not only saves time but enables you to craft highly optimized prompts for any use case.

Prompt Canvas 是一款交互式工具，旨在简化并加速提示词的创建过程。借助 Prompt Canvas，你可以与大语言模型（LLM）智能体协同工作，通过迭代方式构建并优化你的提示词。这种方法不仅能节省时间，更能帮助你为任意应用场景打造高度优化的提示词。

Instead of manually adjusting your prompt to follow best practices, Prompt Canvas leverages the expertise of an LLM agent to automate prompt development and offer guidance. This interactive and conversational setup makes prompt creation dynamic, empowering you to optimize as you go, while still maintaining control over the process.

你无需再手动调整提示词以遵循最佳实践；Prompt Canvas 将调用 LLM 智能体的专业能力，自动完成提示词开发，并提供实时指导。这种交互式、对话式的设置，让提示词创作过程更加动态灵活——你可以在持续优化的过程中保持对整个流程的完全掌控。

Many of the features are inspired by the recent “Canvas” UX that OpenAI launched. We think the “Canvas” UX is fantastic for collaborating on documents with AI, much better than chat. At the end of the day, prompts are just a specific type of document - so it makes complete sense to bring this experience to prompting.

Prompt Canvas 的诸多功能灵感源自 OpenAI 近期推出的“Canvas”用户体验（UX）。我们认为，“Canvas” UX 在人机协同处理文档方面表现极为出色，远胜于传统聊天界面。归根结底，提示词本质上就是一类特殊的文档——因此，将这种体验引入提示工程领域，可谓水到渠成、顺理成章。

### How to Use Prompt Canvas

### 如何使用 Prompt Canvas

Prompt Canvas is built with a dual-panel layout:

Prompt Canvas 采用双面板布局设计：

**Chat Panel**  

**聊天面板**

The chat panel is where your collaboration with the LLM agent takes place. You can:

- Request prompt drafts or adjustments to existing prompts. Each request generates a new version of your prompt, which you can iterate through to compare performance.  
聊天面板是您与大语言模型（LLM）智能体协作的主界面。您可以：  
- 请求生成提示词草稿，或对现有提示词进行调整。每次请求都会生成提示词的一个新版本，您可反复迭代，对比不同版本的效果。

- Ask questions about your prompt, like, “What improvements can I make?” or “Is my prompt too long?”  
- 就您的提示词提出问题，例如：“我可以做哪些改进？”或“我的提示词是否过长？”

**Canvas**  
**画布（Canvas）**

The canvas provides a hands-on editing area where you can:  
画布提供一个交互式编辑区域，您可在其中：

- Directly edit your prompt.  
- 直接编辑您的提示词。

- Select specific text for targeted feedback or adjustments from the agent.  
- 选中特定文本片段，向智能体请求针对性反馈或修改建议。

- Utilize quick actions to quickly alter your prompt:  
- 使用快捷操作快速调整提示词：  
  - Default actions include adjusting reading level or length.  
    - 默认操作包括调整阅读难度或长度。  
  - Define/apply custom quick actions tailored to your workspace, making it easy to apply team-wide prompt standards (more on this later).  
    - 定义并应用适配您工作空间的自定义快捷操作，便于在团队范围内统一提示词规范（后文将详述）。  

- View differences between the current and previous versions, making it clear how each change impacts the prompt.  
- 查看当前版本与上一版本之间的差异，清晰了解每次修改对提示词产生的具体影响。

### Custom Quick Actions  
### 自定义快捷操作

While most of the features are very similar to OpenAI’s Canvas UX, “custom quick actions” are one that we added in ourselves.  
尽管大多数功能与 OpenAI 的 Canvas 用户体验高度相似，但“自定义快捷操作”是我们自主新增的一项特性。

This was born out of talking to companies and hearing a pain point around sharing best practices of how to prompt. We are still extremely early on in “prompt engineering” as a field, and not that many people have a ton of expertise. What we consistently saw was that there may be a few prompting experts, and they wanted to share their knowledge with others in the organization. Custom quick actions enables exactly this.  
这一功能源于我们与多家企业的深入交流——客户普遍反映，在组织内部共享提示工程（prompt engineering）最佳实践存在困难。目前，“提示工程”作为一个新兴领域仍处于早期发展阶段，真正具备深厚经验的专业人士尚属少数。我们持续观察到的现象是：每个组织中往往只有少数几位提示工程专家，而他们迫切希望将自身经验高效传递给其他成员。自定义快捷操作正是为实现这一目标而设计。

With custom quick actions, you can define quick actions to apply to the prompt at an organization level — this makes it easier to maintain consistent style and structure in your prompt design when working with other stakeholders. For example, if your expert prompt engineer has a specific format they like to write prompts in, they can just write a quick action to reformat prompts in that way; then, all other developers will be able to easily apply that to their prompt with one click!  
借助自定义快捷操作，您可在组织层面定义并部署适用于提示词的快捷操作——这有助于在跨角色协作过程中，持续保持提示词风格与结构的一致性。例如，若您组织中的提示工程专家习惯采用某种特定格式撰写提示词，他们只需编写一个快捷操作，即可自动将任意提示词重排为此格式；随后，所有其他开发者仅需单击一次，即可将该格式一键应用于自己的提示词！

![](images/introducing-prompt-canvas-a-novel-ux-for-developing-prompts/img_002.png)![](images/introducing-prompt-canvas-a-novel-ux-for-developing-prompts/img_003.png)

### **Ready to Try It?**

### **准备试用了吗？**

Whether you’re building a prompt from scratch or modifying an existing prompt, Prompt Canvas offers a robust set of tools to make prompt engineering a collaborative and more efficient process.

无论您是从零开始构建提示词，还是修改现有提示词，Prompt Canvas 都提供了一套功能强大的工具，让提示工程变得更加协作化与高效。

See our [walkthrough video](https://youtu.be/nXrx-_9Yucc?ref=blog.langchain.com) on the Prompt Canvas for more information. And try it out inside the LangSmith Playground!

请观看我们的 [Prompt Canvas 操作演示视频](https://youtu.be/nXrx-_9Yucc?ref=blog.langchain.com) 了解更多信息。并立即在 LangSmith Playground 中亲自体验！