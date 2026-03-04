---
title: "MultiOn x LangChain: Powering Next-Gen Web Automation & Navigation with AI"
source: "LangChain Blog"
url: "https://blog.langchain.com/multion-x-langchain-powering-next-gen-web-automation-navigation-with-ai/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:14:29.458643554+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with [MultiOn](https://www.multion.ai/?ref=blog.langchain.com). We're really excited about the way they're using Agents to automate and streamline online interactions. They are one of the first real world, production agent applications that we know of. Their integration with LangChain as a Toolkit makes it quick and easy to personalize and automate everyday web tasks._

_编辑注：本文由 [MultiOn](https://www.multion.ai/?ref=blog.langchain.com) 与 LangChain 团队联合撰写。我们非常兴奋地看到 MultiOn 如何利用 Agent 技术自动化并优化线上交互流程。这是目前我们所知最早投入实际生产环境、真正落地的 Agent 应用之一。其作为 Toolkit 与 LangChain 的集成，让个性化与自动化日常网页任务变得快速而简便。_

## MultiOn: Your Personal AI Agent Now on LangChain

## MultiOn：您的个人 AI Agent 现已接入 LangChain

Whether it's searching for information, filling out forms, or navigating complex websites, daily web tasks can often be tedious and time-consuming. That's why we're thrilled to introduce MultiOn, a next-generation personal AI assistant designed to interact with the web, to handle these tasks on your behalf.

无论是搜索信息、填写表单，还是浏览结构复杂的网站，日常网页操作往往繁琐且耗时。正因如此，我们非常激动地向大家介绍 MultiOn —— 一款面向下一代的个人 AI 助手，专为与网页深度交互而设计，可代您高效完成上述各类任务。

Operating much like the sci-fi concept of JARVIS, MultiOn leverages cutting-edge AI technology to interact with your browser to perform tasks for you in real-time, from [ordering you dinner](https://youtu.be/2pF5SNhduTc?ref=blog.langchain.com), [booking flights](https://youtu.be/Lh6c8Evo-kY?ref=blog.langchain.com), [scheduling](https://youtu.be/KgH7I7Y59G8?ref=blog.langchain.com), finding information online, [to even filling out forms](https://youtu.be/zP0Ug9BVvhk?ref=blog.langchain.com). And the best part? MultiOn is now integrated directly within LangChain as a Toolkit, making it even easier to automate your everyday web tasks & build custom agents and applications that can take actions on the web.

MultiOn 的运作方式酷似科幻作品中的智能助手 JARVIS：它依托前沿 AI 技术，实时与您的浏览器交互，为您执行各类任务——例如 [为您订晚餐](https://youtu.be/2pF5SNhduTc?ref=blog.langchain.com)、[预订航班](https://youtu.be/Lh6c8Evo-kY?ref=blog.langchain.com)、[安排日程](https://youtu.be/KgH7I7Y59G8?ref=blog.langchain.com)、在线检索信息，甚至 [自动填写表单](https://youtu.be/zP0Ug9BVvhk?ref=blog.langchain.com)。最令人振奋的是？MultiOn 现已作为 Toolkit 原生集成至 LangChain，让您更轻松地自动化日常网页任务，并构建可主动在网页上执行操作的定制化 Agent 与应用程序！

## Seamless Integration with LangChain

## 与 LangChain 无缝集成

With MultiOn directly integrated into LangChain, the power of Autonomous Web AI Agents is now at the fingertips of all users.

MultiOn 已深度集成至 LangChain，这意味着自主式网页 AI Agent 的强大能力，如今触手可及。

The integration unlocks numerous advantages. It provides LangChain users with an AI-powered tool that can automate a variety of everyday web tasks, from information retrieval to interaction with web services on their behalf. This integration not only enhances the functionality of LangChain but also takes the Action ability of agents to the next level - to now interact with any website!

该集成带来诸多优势：它为 LangChain 用户提供了一款 AI 驱动的工具，可自动化执行各类日常网页任务——从信息检索，到代表用户与各类网络服务交互。此次集成不仅显著增强了 LangChain 的功能边界，更将 Agent 的“行动力”（Action Ability）提升至全新高度——使其真正具备与任意网站交互的能力！

Here is a glimpse of how you can use MultiOn within LangChain to interact with the website in just **3 Lines of Code 🔥:**

以下是一个示例，展示您仅需 **3 行代码 🔥**，即可在 LangChain 中调用 MultiOn 与网页进行交互：

Import MultiOn as a LangChain Toolkit to add it to any custom Agent:

将 MultiOn 作为 LangChain Toolkit 导入，即可将其添加至任意自定义 Agent：

```
# IMPORTS
from langchain import OpenAI
from langchain.agents import initialize_agent, AgentType
from langchain.agents.agent_toolkits import MultionToolkit
import multion
multion.login() # MultiOn -> Login to the MultiOn Website
# Initialize Agent
agent = initialize_agent(
    tools=MultionToolkit().get_tools(),
    llm=OpenAI(temperature=0),
    agent=AgentType.STRUCTURED_CHAT_ZERO_SHOT_REACT_DESCRIPTION,
    verbose = True
)
print(agent.run("Show Beautiful Pictures of New York"))
```

Get more samples at the [MultiOn API repository](https://www.google.com/url?q=https://github.com/MULTI-ON/api&sa=D&source=docs&ust=1692134001253806&usg=AOvVaw0xFKlpwYs8u8vulVJ77IvW).

欢迎访问 [MultiOn API 代码仓库](https://www.google.com/url?q=https://github.com/MULTI-ON/api&sa=D&source=docs&ust=1692134001253806&usg=AOvVaw0xFKlpwYs8u8vulVJ77IvW)，获取更多示例。

LangChain Agent Demo:

LangChain Agent 演示：

Other

其他示例：

- [MultiOn 调度应用（Task Scheduler）](https://github.com/MULTI-ON/api/tree/main/examples/task_scheduler?ref=blog.langchain.com): 定期执行重复性任务，例如“每天在 Facebook 上向朋友们送上生日祝福”。

- [聚餐预订助手（Group Dinner Reservation Agent）](https://github.com/MULTI-ON/api/tree/main/examples/restaurant-bot?ref=blog.langchain.com): 将 MultiOn 接入短信群聊，让它帮你通过 OpenTable 预订多人聚餐。

## **加入 MultiOn 社区！**

## **加入 MultiOn 社区！**

We’re very enthusiastic about the potential for Autonomous Web AI Agents, and more broadly, exploring new ways to harness the power of AI to improve online experiences. We believe that Actions are key to building powerful AI applications, and we want to empower developers & the open source community to build AI that can interact with the Web by building on top of MultiOn. Please check [our documentation](https://docs.multion.ai/?ref=blog.langchain.com),  [contribute to adding examples](https://github.com/MULTI-ON/api/tree/main/examples?ref=blog.langchain.com), and join our Discord to experience the future of web task automation!

我们对自主式网页 AI 智能体（Autonomous Web AI Agents）的潜力充满热情；更广泛而言，我们也正积极探索如何以全新方式释放 AI 的力量，从而提升用户的在线体验。我们坚信，“操作能力（Actions）”是构建强大 AI 应用的关键；我们希望赋能广大开发者与开源社区，基于 MultiOn 构建能够与网页交互的 AI 应用。欢迎查阅我们的 [官方文档](https://docs.multion.ai/?ref=blog.langchain.com)，参与 [示例贡献](https://github.com/MULTI-ON/api/tree/main/examples?ref=blog.langchain.com)，并加入我们的 Discord 社区，亲身体验网页任务自动化的新未来！

Stay tuned for more updates on our journey, and don't hesitate to reach us out at [info@multion.ai](mailto:info@multion.ai) if you have any questions or suggestions. We're always looking to hear from users and improve MultiOn to best serve your needs 🚀

敬请持续关注我们的发展动态！如您有任何问题或建议，欢迎随时通过 [info@multion.ai](mailto:info@multion.ai) 与我们联系。我们始终期待聆听用户的声音，并不断优化 MultiOn，以更好地满足您的需求 🚀
{% endraw %}
