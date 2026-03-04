---
title: "How We Deployed our Multi-Agent Flow to LangGraph Cloud"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-we-deployed-our-multi-agent-flow-to-langgraph-cloud-2/"
date: "2024-07-16"
scraped_at: "2026-03-03T07:59:09.366514078+00:00"
language: "en-zh"
translated: true
description: "Read this guest blog post on how to create a LangGraph multi-agent flow via React & LangGraph Cloud."
---
&#123;% raw %}

_Note: This is a guest blog post by Elisha Kramer, Tech Lead at Fiverr. He is also one of the top contributors of the leading `gpt-researcher` Github project by Assaf Elovic._

_注：本文为 Fiverr 技术主管 Elisha Kramer 撰写的客座博客文章。他同时也是 Assaf Elovic 主导的知名开源项目 `gpt-researcher` GitHub 仓库的核心贡献者之一。_

After experimenting with the new LangGraph Cloud feature, we were so excited that we had to write about it. Below, we’ll show of how we deployed our LangGraph Cloud Host & queried it from the [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) frontend (NextJS).

在试用全新的 LangGraph Cloud 功能后，我们兴奋不已，迫不及待要与大家分享。下文将详细介绍我们如何部署 LangGraph Cloud Host，并从 [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 前端（基于 Next.js 构建）调用该服务。

## **What is GPT Researcher?**

## **什么是 GPT Researcher？**

[GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) is an open-source autonomous agent designed for comprehensive online research on a variety of tasks. The open source has grown in popularity over the past year, with over 13K stars and a community of 4K+ developers.

[GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 是一款面向多样化任务的开源自主智能体（autonomous agent），专为开展全面的在线研究而设计。过去一年中，该项目广受欢迎，GitHub Star 数已突破 13,000，开发者社区规模超过 4,000 人。

GPT Researcher has also been evolved over time, starting as a successful RAG implementation and now using multi-agents with the popular LangGraph framework.

GPT Researcher 也在持续演进——最初是一个成功的 RAG（检索增强生成）实现，如今已升级为基于主流 LangGraph 框架构建的多智能体系统。

But there was still a missing piece. GPT Researcher didn't yet have a top-standard front-end application and was still built on simple HTML and CSS. We’re excited to introduce our latest client built with NextJS, designed to provide an optimal research experience! [Check out a demo here](https://www.youtube.com/watch?v=hIZqA6lPusk&ref=blog.langchain.com).

但此前仍存在一个关键缺口：GPT Researcher 尚未配备业界一流的前端应用，其界面仍基于简单的 HTML 和 CSS 实现。我们非常高兴地推出全新打造的 Next.js 客户端，旨在提供卓越的研究体验！[点击此处观看演示视频](https://www.youtube.com/watch?v=hIZqA6lPusk&ref=blog.langchain.com)。

## **How does LangGraph tie into the picture?**

## **LangGraph 在其中扮演什么角色？**

As we started trying to build context-aware AI agents capable of reasoning through problems, we discovered the LangChain library and LangGraph.

当我们着手构建具备上下文感知能力、能对问题进行推理的 AI 智能体时，我们接触并深入了解了 LangChain 库及其核心组件 LangGraph。

Specifically, we were hooked on the concept of LangGraph: a framework that could enable us to build out complex multi-agent flows where AI agents coordinate with other agents, bringing their unique perspectives and reviewing each other's work.

尤其令我们着迷的是 LangGraph 的设计理念：它是一个可支撑复杂多智能体工作流的框架，使 AI 智能体之间能够协同合作——各自贡献独特视角，并相互审阅彼此的工作成果。

LangGraph turned out to be a great fit for that! And the ability to easily connect our new frontend to a cloud-based version of GPT Researcher sounded too good to be true.

事实证明，LangGraph 完美契合我们的需求！而能轻松将全新前端接入云端版 GPT Researcher 的能力，听起来简直令人难以置信。

## **What is LangGraph Cloud?**

## **什么是 LangGraph Cloud？**

The concept behind the LangGraph Cloud Host is very similar to the concept behind a GraphQL API Server.

LangGraph Cloud Host 的设计理念与 GraphQL API 服务器非常相似。

A GraphQL API Server:

GraphQL API 服务器：

- Can help abstract away access to a database  
- 可帮助屏蔽对数据库的直接访问  

- Can leverage any library of the Server Language  
- 可调用服务端语言支持的任意库  

So too, a LangGraph API Server can:

同理，LangGraph API 服务器也能：

- Abstract away access to a LangGraph  
- 屏蔽对 LangGraph 的底层访问细节  

- Leverage any pip package used within your LangGraph  
- 调用您 LangGraph 中依赖的任意 pip 包  

Essentially, you’re deploying a Python server with your LangGraph baked into it. And while you’re at it, you get a bunch of stuff for free; here are the [API endpoints automatically exposed on your LangGraph Cloud Host](https://langchain-ai.github.io/langgraph-example/?ref=blog.langchain.com) to enable easy job-triggering & graph edits.

本质上，您部署的是一个将 LangGraph “内嵌”其中的 Python 服务器。与此同时，您还能免费获得一系列开箱即用的功能；例如，您的 LangGraph Cloud Host 会自动暴露以下 [API 端点](https://langchain-ai.github.io/langgraph-example/?ref=blog.langchain.com)，便于轻松触发任务和编辑图结构。

## **What did we deploy?**

## **我们部署了什么？**

In our case, the brunt of the work was done by Assaf, founder of  [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com), when he built a multi-agent workflow leveraging LangGraph. (Feel free to read up on that adventure in this earlier post: [How to Build the Ultimate AI Automation with Multi-Agent Collaboration](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/).)

在本次实践中，主要工作由 [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 创始人 Assaf 完成——他基于 LangGraph 构建了一套多智能体（multi-agent）工作流。（欢迎阅读此前发布的这篇深度文章，了解这段探索历程：[如何借助多智能体协作构建终极 AI 自动化系统](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/)。）

Once that multi-agent flow was built with LangGraph, it set the stage for some easy wins down the road. Several weeks later, Harrison (CEO of LangChain) stepped in & created a pull request to enable us to easily deploy Assaf’s pre-built LangGraph: [Here’s the GPT Researcher PR](https://github.com/assafelovic/gpt-researcher/pull/537/files?ref=blog.langchain.com).

该多智能体流程一经 LangGraph 实现，便为后续快速落地奠定了坚实基础。数周后，LangChain 首席执行官 Harrison 加入进来，并提交了一个 Pull Request，使我们得以便捷地部署 Assaf 已构建完成的 LangGraph：[GPT Researcher 的 PR 链接](https://github.com/assafelovic/gpt-researcher/pull/537/files?ref=blog.langchain.com)。

The beauty of that PR was that it made our GPT-Researcher LangGraph easily available to deploy, edit & trigger with custom parameters via an API Call. Wow! Only 4 changed files to go from our dev environment to a scalable production-ready service!

该 PR 的精妙之处在于，它使我们的 GPT-Researcher LangGraph 能够轻松地通过 API 调用进行部署、编辑，并以自定义参数触发。太棒了！仅需修改 4 个文件，即可从开发环境跃升为可扩展的、面向生产的就绪服务！

## **Querying the LangGraph API Server**

## **调用 LangGraph API 服务器**

It took me a while to fully appreciate the simplicity of the previous 2 steps. It couldn’t be that easy to trigger a multi-agent LLM workflow... could it?

我花了一段时间才真正体会到前两个步骤的简洁性。触发一个多智能体大语言模型（LLM）工作流，真的会这么简单吗？……难道真的可以？

Turns out, it was.

事实证明，的确如此。

Building on top of Assaf & Harrison’s code, all we needed to do was the following.

在 Assaf 与 Harrison 代码的基础上，我们只需完成以下操作。

### Step 1: Watch [Harrison’s deployment tutorial](https://youtu.be/l4sMKF1dTDM?si=L2HdcZMg_UM1QGKZ&t=254&ref=blog.langchain.com)

### 步骤 1：观看 [Harrison 的部署教程](https://youtu.be/l4sMKF1dTDM?si=L2HdcZMg_UM1QGKZ&t=254&ref=blog.langchain.com)

### Step 2: Deploy our custom LangGraph [via the LangSmith GUI](https://smith.langchain.com/?ref=blog.langchain.com)’s “Deployments” tab.

### 步骤 2：通过 LangSmith 图形界面（GUI）[的“Deployments”（部署）标签页](https://smith.langchain.com/?ref=blog.langchain.com) 部署我们定制的 LangGraph。

In our case, I selected my fork of the GPT Researcher Project & pointing to my langgraph.json config file within GPT Researcher’s multi\_agents directory (see below)

在我们的案例中，我选择了自己 Fork 的 GPT Researcher 项目，并指向 GPT Researcher 项目 `multi_agents` 目录下的 `langgraph.json` 配置文件（如下所示）：

![](images/how-we-deployed-our-multi-agent-flow-to-langgraph-cloud/img_001.jpg)

### **Step 3:** Add my environment variables to my LangGraph Cloud deployment.

### **步骤 3：** 将我的环境变量添加至 LangGraph Cloud 部署中。

These should suffice:

这些应该足够了：

![](images/how-we-deployed-our-multi-agent-flow-to-langgraph-cloud/img_002.jpg)

Notice in the screenshot above that LangGraph Cloud will automatically create a “Tracing Project” for me.

请注意上图截图：LangGraph Cloud 会自动为我创建一个“追踪项目（Tracing Project）”。

That means we get the same LangSmith tracing benefits that we got with our MVP multi-agents flow. Here’s what it looks like:

这意味着我们能获得与 MVP 多智能体流程相同的 LangSmith 追踪功能。效果如下图所示：

![](images/how-we-deployed-our-multi-agent-flow-to-langgraph-cloud/img_003.jpg)

And here’s what you get — a powerful tool for:

而您将获得的，正是一款功能强大的工具，可用于：

- Enabling users to visualize and inspect the backend data flow  
  - 帮助用户直观呈现并检查后端数据流向；
- Quality assurance debugging - i.e. where can the input or output of our AI flows use improvement  
  - 质量保障调试——即识别 AI 流程的输入或输出中哪些环节有待优化。

### **Step 4:** Query the newly deployed LangGraph.

### **第四步：** 查询新部署的 LangGraph。

Here’s a sample of the React Code:

以下是 React 代码的一个示例：

```javascript
import { getHost } from '../../helpers/getHost';
import { Client } from "@langchain/langgraph-sdk";
import { task } from '../../config/task';

export async function startLanggraphResearch(newQuestion, report_source) {
   // Update the task query with the new question
   // 使用新问题更新任务查询
   task.task.query = newQuestion;
   task.task.source = report_source;
   const host = getHost({purpose: 'langgraph-gui'});
   const client = new Client({apiUrl: host});
    // List all assistants
    // 列出所有助手
   const assistants = await client.assistants.search({
     metadata: null,
     offset: 0,
     limit: 10,
   });

   const agent = assistants[0];
    // Start a new thread
    // 启动一个新线程
   const thread = await client.threads.create();
    // Start a streaming run
    // 启动流式运行
   const input = task;
    const streamResponse = client.runs.stream(
     thread["thread_id"],
     agent["assistant_id"],
     {
       input,
     },
   );

   return {streamResponse, host, thread_id: thread["thread_id"]};
}
```

The task object imported at the top of the file can be thought of as our API Request object. It’s practically identical to the [task.json file leveraged by Assaf’s LangGraph.](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration#running-the-research-assistant)

文件顶部导入的 `task` 对象可视为我们的 API 请求对象。它与 [Assaf 的 LangGraph 所使用的 `task.json` 文件](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration#running-the-research-assistant) 在结构和用途上几乎完全一致。

The `getHost` function either returns `localhost:8123` (for the `langgraph-cli` service) or the domain of the LangGraph Cloud Server we deployed on.

`getHost` 函数返回 `localhost:8123`（对应本地 `langgraph-cli` 服务），或我们所部署的 LangGraph Cloud 服务器的域名。

And that’s pretty much all there is to it. The above code enables us to trigger a run on the LangGraph server — which is fully observable on the LangSmith User Interface! Here’s the continuation of the above code which displays to the user the status of our LangGraph State (per task) as our multi-agent flow runs through its paces:

以上基本就是全部逻辑。上述代码使我们能够触发 LangGraph 服务器上的一次运行——该运行过程可在 LangSmith 用户界面中完整观测！以下是上述代码的后续部分，用于在多智能体工作流执行过程中，向用户实时展示每个任务对应的 LangGraph 状态：

```
     const langsmithGuiLink = `https://smith.langchain.com/studio/thread/${thread_id}?baseUrl=${host}`;

     let previousChunk = null;

     for await (const chunk of streamResponse) {
       console.log(chunk);
       if (chunk.data.report != null && chunk.data.report != "Full report content here") {
         setOrderedData((prevOrder) => [...prevOrder, { ...chunk.data, output: chunk.data.report, type: 'report' }]);
         setLoading(false);
       } else if (previousChunk) {
         const differences = findDifferences(previousChunk, chunk);
         setOrderedData((prevOrder) => [...prevOrder, { type: 'differences', content: 'differences', output: JSON.stringify(differences) }]);
       }
       previousChunk = chunk;
     }
   }
```

Notice in an earlier code snippet that we leveraged the `client.runs.stream` method.

请注意，在之前的一段代码片段中，我们使用了 `client.runs.stream` 方法。

That means that the LangGraph API Server will feed us back updates in chunks. Those chunks can contain: the updated state of the Job currently running or any custom errors our python scripts encountered on our deployed LangGraph server.

这意味着 LangGraph API 服务器将以分块（chunk）形式向我们推送更新。这些数据块可能包含：当前正在运行的 Job 的最新状态，或我们在已部署的 LangGraph 服务器上运行的 Python 脚本所遇到的任何自定义错误。

In our case, we wanted to show our users a custom play-by-play of the LangGraph API Job - therefore, we also added a `findDifferences` function whose role is to calculate the difference between two JavaScript objects.

在我们的场景中，我们希望为用户提供 LangGraph API Job 的定制化逐帧播报（play-by-play）——因此，我们还添加了一个 `findDifferences` 函数，其作用是计算两个 JavaScript 对象之间的差异。

If the Graph completes the report, that report is displayed to the user.

如果图（Graph）成功生成报告，则该报告将展示给用户。

If the Graph had some field edits in real-time, those differences in the Graph are displayed to the user.

如果图（Graph）在运行过程中对某些字段进行了实时编辑，则这些图中的差异也将实时呈现给用户。

## **Summary**

## **总结**

In this blog post, we show how we triggered our LangGraph multi-agent flows via React & LangGraph Cloud. These flows mimic human reasoning, making them quite complex. However, as demonstrated in the walkthrough above, an elegant API simplifies the process and makes everything fall into place effortlessly.

本文博客展示了我们如何通过 React 与 LangGraph Cloud 触发 LangGraph 多智能体工作流（multi-agent flows）。这些工作流模拟人类推理过程，因而具有相当高的复杂性。然而，如上文操作指南所示，一个优雅简洁的 API 极大地简化了整个流程，使一切水到渠成、轻松自如。
&#123;% endraw %}
