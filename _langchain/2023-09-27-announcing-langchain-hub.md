---
title: "Announcing LangChain Hub"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-prompt-hub/"
date: "2023-09-27"
scraped_at: "2026-03-03T08:40:57.451626522+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

Today, we're excited to launch LangChain Hub–a home for uploading, browsing, pulling, and managing your prompts. (Soon, we'll be adding other artifacts like chains and agents).

今天，我们非常激动地推出 LangChain Hub——一个用于上传、浏览、拉取和管理提示词（prompts）的中心平台。（不久后，我们还将支持其他类型构件，例如 chains 和 agents。）

💡

[Explore the Hub here](https://smith.langchain.com/hub?ref=blog.langchain.com)

[点击此处探索 Hub](https://smith.langchain.com/hub?ref=blog.langchain.com)

LangChain Hub is built into LangSmith (more on that below) so there are 2 ways to start exploring LangChain Hub.

LangChain Hub 已深度集成至 LangSmith（下文将详细介绍），因此目前有两种方式开始探索 LangChain Hub：

- **With LangSmith access:** Full read and write permissions. You can explore all existing prompts and upload your own by logging in and navigate to the Hub from your admin panel.

- **拥有 LangSmith 访问权限：** 全读写权限。您只需登录后，从管理员面板进入 Hub，即可浏览所有现有提示词，并上传您自己的提示词。

- **Without LangSmith access:** Read only permissions. You can view and download and run prompts. Head directly to [https://smith.langchain.com/hub](https://smith.langchain.com/hub?ref=blog.langchain.com) to start exploring.

- **无 LangSmith 访问权限：** 仅读取权限。您可以查看、下载并运行提示词。请直接访问 [https://smith.langchain.com/hub](https://smith.langchain.com/hub?ref=blog.langchain.com) 开始探索。

**If you would like to upload a prompt but don't have access to LangSmith** fill out [this form](https://airtable.com/appbtdQ3PDLqWq3By/shrjPqoBROI1bJTpR?ref=blog.langchain.com) and we will expedite your access so you can start publishing your prompts.

**如果您希望上传提示词，但尚未获得 LangSmith 访问权限**，请填写 [此表单](https://airtable.com/appbtdQ3PDLqWq3By/shrjPqoBROI1bJTpR?ref=blog.langchain.com)，我们将加快审批流程，助您尽快开启提示词发布之旅。

### Motivation for LangChain Hub

### 推出 LangChain Hub 的初衷

We launched a very early version of LangChain Hub at the beginning of the year as a directory of code and README's with the same goal we have today–make it easier to share and discover prompts for any use-case.

今年年初，我们曾上线 LangChain Hub 的早期版本，当时它只是一个包含代码与 README 文件的目录，其目标与今天完全一致——让各类应用场景下的提示词更易于共享与发现。

As LangChain and the broader ecosystem has evolved, the role of prompting has only become more important to the LLM development process. As Ethan Mollick recently wrote in a ( [FANTASTIC) article](https://www.oneusefulthing.org/p/now-is-the-time-for-grimoires?ref=blog.langchain.com) on the topic, "now is the time for grimoires." By "grimoires" he means "prompt libraries that encode the expertise of their best practices into forms that anyone can use."

随着 LangChain 及整个大模型生态系统的持续演进，“提示工程”（prompting）在大语言模型（LLM）开发流程中的地位愈发关键。正如 Ethan Mollick 近期在一篇（[极为精彩](https://www.oneusefulthing.org/p/now-is-the-time-for-grimoires?ref=blog.langchain.com)）的文章中所指出：“现在正是‘魔法书’（grimoires）登场之时。” 此处的“魔法书”，指的就是“将最佳实践所凝结的专业知识，封装为人人皆可复用的提示词库”。

We whole-heartedly agree–the value of a Hub extends beyond individual applications. It's about advancing our collective wisdom and translating that into knowledge we can all put to use now. We want to help make this easier on an individual, team, and organization scale, across any use-case and every industry.

我们深表赞同——Hub 的价值远不止于服务单个应用。它关乎推动人类集体智慧的演进，并将这种智慧转化为当下即可被所有人付诸实践的知识。我们希望助力个人、团队乃至整个组织，在任何应用场景、任何行业领域，更轻松地实现这一目标。

Our goal for LangChain Hub is that it becomes _the_ go-to place for developers to discover new use cases and polished prompts.

我们构建 LangChain Hub 的目标，是让它成为开发者探索全新应用场景与精炼提示词（polished prompts）的首选之地。

Today, polished prompts and the wisdom that comes with it are distributed across the web and all-too-often buried in the crannies of blog posts, Twitter threads, and people's head's. By bringing all this knowledge together in one easily-navigable place, we think we can accelerate the pace of development and learning together.

如今，精炼的提示词及其背后的经验智慧散落在互联网各处——常常深埋于博客文章的角落、Twitter 推文串（threads）之中，甚至只存在于开发者的脑海里。通过将所有这些知识汇聚到一个易于浏览的统一平台，我们相信能够共同加快开发与学习的步伐。

To use Mollick's terminology–we're starting with public grimoires today, but we'll be enabling private, company-specific grimoires very soon.

借用 Mollick 的术语：我们今天从“公开咒语集”（public grimoires）起步，但很快便会支持私有化、面向企业定制的咒语集（private, company-specific grimoires）。

**So why now?** A few new insights emerged over the past months that motivated us to rebuild the hub properly.

**那么，为何是现在？** 过去几个月中，我们获得了一些新洞察，促使我们下定决心对 Hub 进行彻底重构。

1. **Model Variety and Non-Transferable Prompts**

1. **模型多样性与提示词不可迁移性**

People aren't just using OpenAI anymore. Anthropic with `claude-2` has become the go-to choice for people needing long context windows. Google is releasing (and will release) more powerful models. And, most excitingly, the open source model community is catching up and Llama2 proving to be a viable alternative.

人们已不再仅依赖 OpenAI。Anthropic 的 `claude-2` 凭借超长上下文窗口，已成为相关需求用户的首选；Google 正在发布（并将继续发布）更强大的模型；而最令人振奋的是，开源模型社区正快速追赶——Llama2 已被证实是一种切实可行的替代方案。

Unfortunately, prompts don't simply transfer from one model to another. Each model may have different tricks that work best for that model (e.g. `claude-2` prefers XML encoding when prompting) or different syntax (e.g. `SYS` and `INST` for Llama2).

遗憾的是，提示词并不能简单地跨模型复用。不同模型往往需要各自适配的技巧（例如 `claude-2` 在提示时更倾向使用 XML 编码）或特定语法结构（例如 Llama2 使用 `SYS` 和 `INST` 标签）。

As developers explore the wide variety of models, we hope the LangChain Hub can assist in that exploration by providing starter prompts for those models. We've added tags to prompts to indicate which model(s) they work best with.

当开发者探索纷繁多样的大模型时，我们希望 LangChain Hub 能通过提供各类模型的入门级提示词，助其一臂之力。我们已在提示词上添加了标签，明确标示其最适配的一个或多个模型。

2\. **Inspectability**

2. **可检视性（Inspectability）**

Prompts power the chains and agents in LangChain. Often times, the prompts are obfuscated away. We built LangChain Hub in a way that puts them front and center, so that anyone can see what's going on under the hood.

提示词驱动着 LangChain 中的链（chains）与智能体（agents）。然而，这些提示词常常被隐藏或封装起来，难以直接查看。我们构建 LangChain Hub 时，特意将其置于核心位置——让任何人都能清晰看到系统底层正在发生什么。

3. **Cross-Team Collaboration**

3. **跨团队协作**

While most LLM applications require substantial engineering work to set up, we've noticed that non-technical team members are participating in the process of editing and refining prompts. We wanted to make it _much_ easier for more team members to get involved in what we believe is going to become a core part of every company's app development process. Along these lines, we don't believe that prompts should be treated as traditional code–it's simply not the best way to facilitate this kind of collaboration.

尽管大多数大语言模型（LLM）应用在搭建过程中需要大量工程工作，但我们注意到，非技术背景的团队成员正积极参与提示词（prompt）的编辑与优化过程。我们希望大幅降低门槛，让更多团队成员能够参与进来——因为这将成为每家企业应用开发流程中的核心环节之一。基于这一理念，我们认为提示词不应被视作传统意义上的代码；这种处理方式显然并不利于此类协作。

We're aiming to make LangChain Hub the best place for teams to write and manage prompts, together. The product isn't quite there today–this first iteration only supports personal accounts–but we're actively looking for organizations that are excited to explore an Alpha with us so if you want organizational support for the Hub, please reach out to us directly at `support@langchain.dev` with the subject `[Hub: Orgs]`

我们的目标是将 LangChain Hub 打造成团队协同编写与管理提示词的最佳平台。目前产品尚未完全实现这一愿景——当前版本仅支持个人账户——但我们正积极寻找对共同探索 Hub Alpha 版本充满热情的企业组织。若您希望 Hub 尽快支持企业级功能，请直接发送邮件至 `support@langchain.dev`，邮件主题请注明 `[Hub: Orgs]`。

**4. Artifact Management and LangSmith**

**4. 产物管理与 LangSmith**

From partnering with early LangSmith users, the tie-in between debugging, logging, testing, and evaluation and artifact management has become increasingly obvious. By making LangChain Hub a part of LangSmith, we knew we could help teams not only identify and collaborate on prompts, but also make informed decisions about how to implement them. Testing integrations with prompts aren't out yet but they are coming soon!

通过与早期 LangSmith 用户的合作，我们愈发清晰地认识到：调试（debugging）、日志记录（logging）、测试（testing）、评估（evaluation）与产物（artifact）管理之间存在紧密关联。将 LangChain Hub 深度整合进 LangSmith 后，我们不仅能帮助团队更高效地识别和协同优化提示词，还能为其提供数据支撑，辅助团队就如何落地实施这些提示词做出明智决策。目前，提示词与测试功能的集成尚未发布，但即将上线！

## Favorite Features

## 精选功能

**Home Page**

**首页**

We want to make discoverability and navigability as easy as possible. You should be able to go from curiosity to coding in just a few clicks.

我们致力于让内容发现与页面导航尽可能简单直观——您只需几次点击，即可从灵光一现跃入编码实践。

You can view sort prompts by:

您可按以下维度对提示词进行排序浏览：

- Most favorites  
- 最受喜爱  
- Most viewed  
- 浏览量最高  
- Most downloaded  
- 下载次数最多  
- Recently uploaded  
- 最近上传

You can filter prompts by:

您可以按以下条件筛选提示词：

- Use cases (chatbots, extraction, summarization, etc)  
- 使用场景（聊天机器人、信息抽取、文本摘要等）

- Type (prompt template, etc)  
- 类型（提示词模板等）

- Language (English, Chinese, etc)  
- 语言（英语、中文等）

- Model (OpenAI, Anthropic, Llama2, VertexAI, etc)  
- 模型（OpenAI、Anthropic、Llama2、VertexAI 等）

![](images/announcing-langchain-hub/img_001.png)

**Downloading and Uploading Prompts**

**下载与上传提示词**

We have released an SDK to enable [easy programatic downloading](https://docs.smith.langchain.com/hub/dev-setup?ref=blog.langchain.com#3-pull-an-object-from-the-hub-and-use-it) of prompts:

我们已发布一个 SDK，支持[便捷地以编程方式下载](https://docs.smith.langchain.com/hub/dev-setup?ref=blog.langchain.com#3-pull-an-object-from-the-hub-and-use-it)提示词：

```
from langchain import hub

prompt = hub.pull("hwchase17/eli5-solar-system")
```

```
from langchain import hub

prompt = hub.pull("hwchase17/eli5-solar-system")
```

You can also [easily upload](https://docs.smith.langchain.com/hub/dev-setup?ref=blog.langchain.com#4-push-a-prompt-to-your-personal-organization) prompts via the SDK

您也可以通过该 SDK [便捷地上传](https://docs.smith.langchain.com/hub/dev-setup?ref=blog.langchain.com#4-push-a-prompt-to-your-personal-organization)提示词：

```
from langchain import hub
from langchain.prompts.chat import ChatPromptTemplate

prompt = ChatPromptTemplate.from_template("tell me a joke about {topic}")
```

```
from langchain import hub
from langchain.prompts.chat import ChatPromptTemplate

prompt = ChatPromptTemplate.from_template("tell me a joke about {topic}")
```

```python
hub.push("<handle>/topic-joke-generator", prompt)
```

```python
hub.push("<handle>/topic-joke-generator", prompt)
```

If you want to upload a prompt to the Hub, but don't yet have access to LangSmith, fill out this [form](https://airtable.com/appbtdQ3PDLqWq3By/shrjPqoBROI1bJTpR?ref=blog.langchain.com) and we will expedite your access.

如果您希望将提示（prompt）上传至 Hub，但尚未获得 LangSmith 的访问权限，请填写此 [表单](https://airtable.com/appbtdQ3PDLqWq3By/shrjPqoBROI1bJTpR?ref=blog.langchain.com)，我们将加快为您开通权限。

**Prompt Versioning**

**提示版本管理**

Each time you commit a prompt, it is added as a new commit. This means that you can easily access previous versions of prompts should you want to go back to a previous version.

每次提交提示时，系统都会将其作为一次新提交保存。这意味着，如需回退到历史版本，您可以轻松访问该提示的任意先前版本。

**Playground**

**交互式 Playground**

![](images/announcing-langchain-hub/img_002.png)

![](images/announcing-langchain-hub/img_002.png)

All prompts can be opened in the playground by clicking the "Try it" button. This allows you to interact with prompts right from LangChain Hub. It's useful for testing prompts...and it's fun!

所有提示均可通过点击“Try it”（立即尝试）按钮，在 Playground 中直接打开。您无需离开 LangChain Hub 即可与提示进行交互——既便于测试提示效果……又充满乐趣！

_Note: You will be required to enter an OpenAI or Anthropic API key in order to run it in the playground. These keys are only stored in your browser and are used solely to communicate directly to services._

_注意：在 Playground 中运行提示前，您需输入 OpenAI 或 Anthropic 的 API 密钥。这些密钥仅保存于您的浏览器中，且仅用于与对应服务进行直连通信。_

**Editing and Saving**

**编辑与保存**

![](images/announcing-langchain-hub/img_003.png)

![](images/announcing-langchain-hub/img_003.png)

From the playground you can edit a prompt, and then save it by clicking the "Commit" button in the top right corner. You can do this either for your own prompts, or for others (when saving, you will have to create your own repo to save it to). This is exciting because it helps everyone build on top of each other's work!

在 Playground 中，您可以编辑提示词（prompt），然后点击右上角的“Commit”（提交）按钮将其保存。您既可为自己创建的提示词执行此操作，也可为他人创建的提示词执行此操作（保存时，您需创建自己的代码仓库以存放该提示词）。这令人振奋，因为它让所有人能够基于彼此的工作持续共建与迭代！

## Coming Soon

## 即将上线

- **More Artifact Types:** Right now, only prompt templates are supported. We plan to expand support for other types of artifacts like chains and agents.

- **更多类型的构件（Artifacts）：** 目前仅支持提示词模板（prompt templates）。我们计划扩展对其他类型构件的支持，例如链（chains）和智能体（agents）。

- **Organization Support:** Right now the Hub only works for your personal account. If your organization needs the ability to collaborate on prompts, for now please reach out to us directly at `support@langchain.dev` with the subject `[Hub: Orgs]`. We will be rolling this out more widely in a few weeks.

- **组织级支持：** 当前 Hub 仅支持个人账户。若您所在的组织需要协同开发提示词，请暂时直接发送邮件至 `support@langchain.dev`，邮件主题注明 `[Hub: Orgs]`。我们将在数周内向更广泛的用户群体正式推出该功能。

- **Integration with testing:** Just as you test code, you should test prompts. We are working on integrating the Hub with our dataset & testing functionality. If you need to test your prompts in the meantime, please check out our [LangSmith cookbooks](https://github.com/langchain-ai/langsmith-cookbook?ref=blog.langchain.com).

- **测试能力集成：** 正如您会测试代码一样，提示词也应被系统化测试。我们正在将 Hub 与数据集及测试功能深度集成。在此期间如需测试您的提示词，请查阅我们的 [LangSmith 食谱库（cookbooks）](https://github.com/langchain-ai/langsmith-cookbook?ref=blog.langchain.com)。

- **More social features:** Just as you test code, you should test prompts. We are working on integrating the Hub with our dataset and testing functionality. If you need to test your prompts in the meantime, please check out our [LangSmith cookbooks](https://github.com/langchain-ai/langsmith-cookbook?ref=blog.langchain.com).

- **更多社交功能：** 正如您会测试代码一样，提示词也应被系统化测试。我们正在将 Hub 与数据集及测试功能深度集成。在此期间如需测试您的提示词，请查阅我们的 [LangSmith 食谱库（cookbooks）](https://github.com/langchain-ai/langsmith-cookbook?ref=blog.langchain.com)。

- **What else?** If you have product feedback or ideas for us, we want to hear it! [Join us in Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) to share more.

- **还有哪些期待？** 如果您有任何产品反馈或创意建议，我们非常期待聆听！欢迎[加入我们的 Discord 社区](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) 与我们分享。

## Show us your prompts!

## 快来展示您的提示词！

We’ll be rounding up and sharing the most creative, useful, thought-provoking prompts with the community.

我们将定期汇总并面向社区分享最具创意性、实用性与启发性的提示词。

So share your prompts, ❤️ your favorites, and tag us when you post your prompts or stumble across ones you like!

因此，请踊跃分享您的提示词，❤️ 点赞您最喜爱的作品，并在发布提示词或发现心仪提示词时 @ 我们！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/announcing-langchain-hub/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/announcing-langchain-hub/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/announcing-langchain-hub/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 3 分钟

[![LangChain State of AI 2024 Report](images/announcing-langchain-hub/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/announcing-langchain-hub/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/announcing-langchain-hub/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/announcing-langchain-hub/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/announcing-langchain-hub/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/announcing-langchain-hub/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：让模型评估更轻松**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/announcing-langchain-hub/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/announcing-langchain-hub/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台正式开启 Beta 测试：为可扩展智能体基础设施提供全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
&#123;% endraw %}
